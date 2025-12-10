#!/bin/bash

read -r -d '' HELP << EOM
This script is used to fetch binary information from a GitHub release and update multitool.lock.json.
You should invoke it as:
./minidock/remote_tools/update_multitool_remote_tools.sh <git tag of tools release>

If you wish to override the github organization and repo name you can use:
CI_UPDATE_GITHUB_ORG_AND_REPO_NAME=""

Otherwise these will be determined from the origin url.
EOM

set -efo pipefail

TOOLS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export REPO_ROOT="$(cd $TOOLS_DIR && cd ../.. && pwd)"
cd $REPO_ROOT

RELEASE_TAG="${1:-}"

if [ -z "$RELEASE_TAG" ]; then
    echo -e "\nRelease tag not specified\n\n" 1>&2
    echo "$HELP" 1>&2
    exit 1
fi

if [ -z "$CI_UPDATE_GITHUB_ORG_AND_REPO_NAME" ]; then
    ORIGIN_URL="$(git config --get remote.origin.url)"
    CI_UPDATE_GITHUB_ORG_AND_REPO_NAME="$(echo $ORIGIN_URL | sed -e 's/.*github\.com[:/]\([A-Za-z0-9_/-]*\)\.git/\1/')_tools"
    if [[ "$CI_UPDATE_GITHUB_ORG_AND_REPO_NAME" =~ ":" ]]; then
        echo "Failed to parse out CI_UPDATE_GITHUB_ORG_AND_REPO_NAME from origin, origin was: $ORIGIN_URL"
        exit 1
    fi
fi

TEMPDIR="$(mktemp -d "${TMPDIR:-/tmp}/tmpupdate.XXXXXXXX")"
trap 'rm -rf "$TEMPDIR"' EXIT

URL_BASE="https://github.com/${CI_UPDATE_GITHUB_ORG_AND_REPO_NAME}/releases/download/${RELEASE_TAG}"

# Tools and platforms to update
TOOLS="merge-app pusher-app puller-app"
PLATFORMS="linux-x86_64 macos-x86_64 macos-aarch64"

# Map platform names to multitool format
map_os() {
    case "$1" in
        linux-*) echo "linux" ;;
        macos-*) echo "macos" ;;
        *) echo "UNKNOWN" ;;
    esac
}

map_cpu() {
    case "$1" in
        *-x86_64) echo "x86_64" ;;
        *-aarch64) echo "arm64" ;;
        *) echo "UNKNOWN" ;;
    esac
}

# Start building JSON
cat > $TEMPDIR/multitool.lock.json << 'EOF'
{
  "$schema": "https://raw.githubusercontent.com/theoremlp/rules_multitool/main/lockfile.schema.json",
EOF

FIRST_TOOL=true
for tool in $TOOLS; do
    if [ "$FIRST_TOOL" = true ]; then
        FIRST_TOOL=false
    else
        echo "," >> $TEMPDIR/multitool.lock.json
    fi

    echo "  \"${tool}\": {" >> $TEMPDIR/multitool.lock.json
    echo "    \"binaries\": [" >> $TEMPDIR/multitool.lock.json

    FIRST_PLATFORM=true
    for platform in $PLATFORMS; do
        binary_name="${tool}-${platform}"
        os=$(map_os "$platform")
        cpu=$(map_cpu "$platform")

        echo "Fetching SHA256 for ${binary_name}..."
        SHA256_VALUE="$(curl --fail -L "${URL_BASE}/${binary_name}.sha256")"

        if [ "$FIRST_PLATFORM" = true ]; then
            FIRST_PLATFORM=false
        else
            echo "," >> $TEMPDIR/multitool.lock.json
        fi

        cat >> $TEMPDIR/multitool.lock.json << EOF
      {
        "kind": "file",
        "url": "${URL_BASE}/${binary_name}",
        "sha256": "${SHA256_VALUE}",
        "os": "${os}",
        "cpu": "${cpu}"
EOF
        echo -n "      }" >> $TEMPDIR/multitool.lock.json
    done

    echo "" >> $TEMPDIR/multitool.lock.json
    echo "    ]" >> $TEMPDIR/multitool.lock.json
    echo -n "  }" >> $TEMPDIR/multitool.lock.json
done

echo "" >> $TEMPDIR/multitool.lock.json
echo "}" >> $TEMPDIR/multitool.lock.json

# Replace the original file
cp $TEMPDIR/multitool.lock.json minidock/remote_tools/multitool.lock.json
echo "Successfully updated minidock/remote_tools/multitool.lock.json with binaries from ${RELEASE_TAG}"
