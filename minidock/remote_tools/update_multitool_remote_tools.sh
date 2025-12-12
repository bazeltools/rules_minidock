#!/bin/bash

set -euo pipefail

echo "Running multitool update..."
# Change to workspace root to run multitool update
cd "$(git rev-parse --show-toplevel)"

./bazel run @multitool//tools/multitool:workspace_root -- --lockfile minidock/remote_tools/multitool.lock.json update

echo "Successfully updated minidock/remote_tools/multitool.lock.json"
