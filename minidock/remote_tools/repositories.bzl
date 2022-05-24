load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "ab0d14ae79c6ad3e5cfbf2eb1b1843706f5d38bb0dace4937594feab236a93d0",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.41/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "2b28cb98ae5f50bc01012d7119028af4f18631d43eec09986a84a664f7738e95",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.41/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "c125764a3f74d2db1507a2106cfb013aef2c8a642fdb3a6f514a15f5d9e90aa5",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.41/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "ab19fd9ef56a6d36942582a2ba2f4df1358398e4f90c72604c33b571d75e6292",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.41/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "b68cdf54792836e002a4113bd0dab29a08a20887608abfa6a746041186315509",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.41/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "c93d2dd2044c75abe19ee3ed10535aa2f5efcd5e420e34cea825f1cc63edfe83",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.41/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["2598e3b0de56b034f866c0c065ec2d08575825fc1f1e1bf3092e1e1eeb12a8c5", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.41/puller-app-linux-x86_64"],
                "macos__x86_64": ["493fd021682ca24b9972648d9e8c96beb08dfec09ebc191c50197e4e063a5d8b", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.41/puller-app-macos-x86_64"],
                "macos__aarch64": ["bb2f5ffb45b49bae7de119c96bab2a2b7b12f9facd700fd9b1962948f39ce8c3", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.41/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
