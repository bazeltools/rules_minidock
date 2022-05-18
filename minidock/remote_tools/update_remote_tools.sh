#!/bin/bash


read -r -d '' HELP << EOM
This script is used to try fetch the binary information about a release from a github release and update the repo.
You should invoke it as:
./minidock/remote_tools/update_remote_tools.sh <git tag of tools release>

If you wish to override the github organiztion and repo name you can use:
CI_UPDATE_GITHUB_ORG_AND_REPO_NAME=""

Otherwise these will be determined from the origin url. So if it needs to come from something other than the origin you probably should override these.
EOM

set -efo pipefail


TOOLS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export REPO_ROOT="$(cd $TOOLS_DIR && cd ../.. && pwd)"
cd $REPO_ROOT

RELEASE_TAG="${1:-}"

if [ -z "$RELEASE_TAG" ]; then
    echo -e "\nRelease tag not specified\n\n" 1>&2
    echo $HELP 1>&2
    exit 1
fi


if [ -z "$CI_UPDATE_GITHUB_ORG_AND_REPO_NAME" ]; then
    ORIGIN_URL="$(git config --get remote.origin.url)"
    CI_UPDATE_GITHUB_ORG_AND_REPO_NAME="$(echo $ORIGIN_URL | sed -e 's/.*github\.com:\([A-Za-z0-9_/-]*\)\.git/\1/')_tools"
    if [[ "$CI_UPDATE_GITHUB_ORG_AND_REPO_NAME" =~ ":" ]]; then
        echo "Failed to parse out CI_UPDATE_GITHUB_ORG_AND_REPO_NAME from origin, origin was: $ORIGIN_URL"
        exit 1
    fi
fi


TEMPDIR="$(mktemp -d "${TMPDIR:-/tmp}/tmpupdate.XXXXXXXX")"
trap 'rm -rf "$TEMPDIR"' EXIT

URL_BASE="https://github.com/${CI_UPDATE_GITHUB_ORG_AND_REPO_NAME}/releases/download/${RELEASE_TAG}"
cat minidock/remote_tools/repositories.bzl | sed '/RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START/,$d' > $TEMPDIR/prelude.txt
cat minidock/remote_tools/repositories.bzl | sed '1,/RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END/ d' > $TEMPDIR/suffix.txt

TOOLS="merge-app pusher-app"
PLATFORM_OS="linux-x86_64 macos-x86_64 macos-aarch64"
TMP_OUTPUT=$TEMPDIR/result.bzl

function load_entry() {
    TOOL=$1
    PLATFORM=$2
    binary_name="$TOOL-$PLATFORM"
    repo_name="rules_minidock__$(echo $binary_name | sed -e 's/-/_/g' | sed -e 's/\./_/g')"
    set -x
    SHA256_VALUE="$(curl --fail -L "${URL_BASE}/${binary_name}.sha256")"
cat << EOM >>$TMP_OUTPUT

    if "$repo_name" not in excludes:
        load_tool(
            name = "${repo_name}",
            sha256 = "$SHA256_VALUE",
            packaged = False,
            binary_path = "${binary_name}",
            urls = ["${URL_BASE}/${binary_name}"],
        )
EOM
}


for tool in $TOOLS; do
    for platform in $PLATFORM_OS; do
        load_entry $tool $platform
    done
done

cat << EOM >>$TMP_OUTPUT
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
EOM
# Puller app
TOOL="puller-app"
for platform in $PLATFORM_OS; do
    key="$(echo $platform | sed 's/-/__/g')"
    binary_name="$TOOL-$PLATFORM"
    SHA256_VALUE="$(curl --fail -L "${URL_BASE}/${binary_name}.sha256")"
    set -x
    SHA256_VALUE="$(curl --fail -L "${URL_BASE}/${binary_name}.sha256")"
cat << EOM >>$TMP_OUTPUT
                "$key": ["$SHA256_VALUE", "${URL_BASE}/${binary_name}"],
EOM
done
cat << EOM >>$TMP_OUTPUT
            }
        )
EOM


cat $TEMPDIR/prelude.txt > minidock/remote_tools/repositories.bzl
echo "    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START" >> minidock/remote_tools/repositories.bzl
cat $TEMPDIR/result.bzl >> minidock/remote_tools/repositories.bzl
echo "    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END" >> minidock/remote_tools/repositories.bzl
cat $TEMPDIR/suffix.txt >> minidock/remote_tools/repositories.bzl
