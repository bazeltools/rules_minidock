load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "06122c92a3002b7844a6d44ba6677a219bcec6709e32a91459102a54a5fc4d21",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.63/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "51a00cc8fe0f5b74528b05555ba032de3a1b47ca25214af351345d1cc287339e",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.63/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "8ee3a5b786a5d1d3c9ae435af7649ff8df5455963c0f5fab21515c332d6a0701",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.63/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "e38e9ac7ab6f57f4423697d7557b3efe452254e1ac5693b9ad128d6e2a76bb63",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.63/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "178ec637ac1af97103e28739fc2b705239059b300eeaf16b85222c68622e8f60",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.63/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "29de3252e8e0ed52da9b78e8c9b1c64edb83f058600ef89a152ecbd509b1dd9f",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.63/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["9276d9f807d0b84ece73e7692a257ccc72e8157a3a1c258e69b414288c4a46b9", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.63/puller-app-linux-x86_64"],
                "macos__x86_64": ["8e07bda7dcb0383e0d9bb5e35ab7bcc088cfa5161912f48c8cc435712ce8c9a5", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.63/puller-app-macos-x86_64"],
                "macos__aarch64": ["42011265f4a469d47dd898f8057227f1a462e34226db18ad0e8b76cc04c7862f", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.63/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
