#!/usr/bin/python3

import json
import os
import subprocess

# Navigate to tests/simple_flow
os.chdir('tests/simple_flow')

# Run bazel clean --expunge
subprocess.run(['bazel', 'clean', '--expunge'], check=True)

# Run bazel build ...
subprocess.run(['bazel', 'build', '...'], check=True)

# Calculate SHA_A
with open('bazel-bin/test_assemble_simple_merger_manifest.json', 'rb') as f:
    SHA_A = subprocess.run(['shasum', '-a', '256'], stdin=f, capture_output=True, check=True).stdout.strip()

# Load JSON file
with open('bazel-bin/test_assemble_simple_merger_config.json') as json_file:
    data = json.load(json_file)

# Check Cmd, Labels, and User fields
cmd = data['config']['Cmd']
labels = data['config']['Labels']
user = data['config']['User']

# Expected values
expected_cmd = ["/usr/bin/my_app"]
expected_labels = {"label1": "foo", "label2": "bar"}
expected_user = "nfbasic"

assert(cmd == expected_cmd)
assert(labels == expected_labels)
assert(user == expected_user)

# Run bazel clean --expunge
subprocess.run(['bazel', 'clean', '--expunge'], check=True)

# Run bazel build ...
subprocess.run(['bazel', 'build', '...'], check=True)

# Calculate SHA_B
with open('bazel-bin/test_assemble_simple_merger_manifest.json', 'rb') as f:
    SHA_B = subprocess.run(['shasum', '-a', '256'], stdin=f, capture_output=True, check=True).stdout.strip()

# Compare SHA_A and SHA_B
if SHA_A != SHA_B:
    print("expected same sha but got")
    print(SHA_A)
    print(SHA_B)
    exit(1)
else:
    print(f"[ok] SHA256 matched {SHA_A}")

# Navigate to tests/override_tools
os.chdir('../../tests/override_tools')

# Run bazel query ...
subprocess.run(['bazel', 'query', '...'], check=True)
