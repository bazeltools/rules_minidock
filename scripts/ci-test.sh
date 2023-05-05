#!/bin/bash

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail

pushd tests/simple_flow
bazel clean --expunge
bazel build ...
SHA_A=$(shasum -a 256 bazel-bin/test_assemble_simple_merger_manifest.json)
bazel clean --expunge
bazel build ...
SHA_B=$(shasum -a 256 bazel-bin/test_assemble_simple_merger_manifest.json)
if [[ "$SHA_A" != "$SHA_B" ]]; then
  echo "expected same sha but got"
  echo $SHA_A
  echo $SHA_B
  exit 1
else
  echo "[ok] SHA256 matched $SHA_A"
fi
popd

pushd tests/override_tools
bazel query ...
popd
