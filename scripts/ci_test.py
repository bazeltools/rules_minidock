#!/usr/bin/python3

import json
import os
import subprocess

# Use the bazel wrapper script
BAZEL = "./bazel"

# Run from root directory instead of changing into test directories
subprocess.run([BAZEL, "clean", "--expunge"], check=True)
subprocess.run([BAZEL, "build", "//tests/simple_flow/..."], check=True)

with open("bazel-bin/tests/simple_flow/test_assemble_simple_merger_manifest.json", "rb") as f:
    SHA_A = subprocess.run(["shasum", "-a", "256"], stdin=f, capture_output=True, check=True).stdout.strip()

with open("bazel-bin/tests/simple_flow/test_assemble_simple_merger_config.json") as json_file:
    data = json.load(json_file)

cmd = data["config"]["Cmd"]
labels = data["config"]["Labels"]
user = data["config"]["User"]
env = data["config"]["Env"]

expected_cmd = ["/usr/bin/my_app"]
expected_labels = {
    "label1": "foo",
    "label2": "bar",
    "external-config-label-1": "extlabel1",
    "external-config-label-2": "extlabel2",
    "external-config-label-3": "extlabel3",
    "external-config-label-4": "extlabel4"
}
expected_user = "nfbasic"

assert(cmd == expected_cmd)
assert(labels == expected_labels)
assert(user == expected_user)
# We should not override the env, we should add to the existing env
assert(len(env) > 2)
assert("ENV1=FOO" in env)
assert("ENV2=BAR" in env)
assert("EXTERNALENV1=extenv1" in env)

subprocess.run([BAZEL, "clean", "--expunge"], check=True)
subprocess.run([BAZEL, "build", "//tests/simple_flow/..."], check=True)

with open("bazel-bin/tests/simple_flow/test_assemble_simple_merger_manifest.json", "rb") as f:
    SHA_B = subprocess.run(["shasum", "-a", "256"], stdin=f, capture_output=True, check=True).stdout.strip()

if SHA_A != SHA_B:
    print("expected same sha but got")
    print(SHA_A)
    print(SHA_B)
    exit(1)
else:
    print(f"[ok] SHA256 matched {SHA_A}")

# Run bazel query for override_tools
subprocess.run([BAZEL, "query", "//tests/override_tools/..."], check=True)
