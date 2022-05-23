load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "d8c64b1226373e7d825f7594c6a8326576b45df0c828b26db63262ffe9a74eee",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.34/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "e615b4579c7d42a610de45a2773e37bd4f8c747afa7bb85a2154e1f6f255bb82",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.34/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "ba39f8b81ccae7981f1ded1325403509e430094104c98174cfc2c04bc2bdabec",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.34/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "f1c54864658bd3ca0ff299d290a9443715b6c676f885acbcd0c7b2f8bb4e0a5f",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.34/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "3a768b195bd6956f5dd5821ecc9cb55e4fa5c317023499a46970bec7918c0568",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.34/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "8b17f098018e557c300eeb06cb3e4fd494d6ff9d2023ae86cfe3da3ddbd484c5",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.34/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["e2dd98168c03174c8ed13b9c109e922ff719c93b30f6e251c2419925d78a653c", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.34/puller-app-linux-x86_64"],
                "macos__x86_64": ["ae999ed3dfee59d94983cb6f086023b892148f35a79307aed19e7ebf88794e65", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.34/puller-app-macos-x86_64"],
                "macos__aarch64": ["0be38f7b85800653eb0248b9572d9d69bc54c076b960146164cadc01311af065", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.34/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
