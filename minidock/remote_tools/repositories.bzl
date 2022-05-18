load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "91ac5ae1245574eaf7bcba5b3d458d71dba679da6f9367e690a53cf717cd80f0",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.19/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "d6e149025444cb5edd9b0db5a1e408c84b9829bbb2d8b5543284d82a2de1b60c",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.19/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "7d40ff9903ad7e9ba3c8d0c103ac21755ed5a1657c979f1b61fa334d619fa06f",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.19/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "819d5844578d0aa42278c3f788a21790961005851b1a85b0a47d2c1cf0aedce7",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.19/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "be13b73728c542b097160b903a82308dbe0e963636260578e584acbeee229a3e",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.19/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "93696aeb37862798e5c1da44b9bd8801223a6549dbc4d63fe88385da2a3225c4",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.19/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["ef3994fbe527c0428481eab1159e1b68b0d81a734fdfbc90f40d4c19cfd2b635", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.19/puller-app-macos-aarch64"],
                "macos__x86_64": ["ef3994fbe527c0428481eab1159e1b68b0d81a734fdfbc90f40d4c19cfd2b635", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.19/puller-app-macos-aarch64"],
                "macos__aarch64": ["ef3994fbe527c0428481eab1159e1b68b0d81a734fdfbc90f40d4c19cfd2b635", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.19/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
