load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "662d6ee62432320d1d9b2d387d2c28ae38d7372f33cf9a000c89a59c80e402f4",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.71/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "7e114248993811d867ebbe87afa24fe2bca83b955220e48c937db0d5440dfe99",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.71/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "80f03a97a4ac072e32c06df73787920769210678ad91cd6edbd4bd206a6fa3f9",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.71/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "7f4cb2c2e0fcc1fe7711096b4a30e96075651502a3af638a0cfebe29913d802e",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.71/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "219cade49181f220e7c91f0c04f4c1a1c3a4fc54384c7cd45ac46d44b1d74326",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.71/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "9efad50ba74e8c1b9b4c1c18bd6504811037ae1ad33098eb750990ad6bcd4640",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.71/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["edfe94378bfb815e7ce4a18f5048dddca63fe763f5c824f5081999174f2e4334", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.71/puller-app-linux-x86_64"],
                "macos__x86_64": ["c0d0e238f986536e2c3f37096e0824429e1fb78bcf8319916c6e149ac5adfd55", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.71/puller-app-macos-x86_64"],
                "macos__aarch64": ["968f41423689216d1dfb985502eabb0bb5b48001faad34b571ce9217ab3a013f", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.71/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
