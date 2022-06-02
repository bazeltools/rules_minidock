load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "62972b2d12e18baff48808a66c4207f985f99c24d80822c45f8979a43778dd53",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.44/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "4c090d39bd2dc6c7b316dcd3098f09d76215607ef77f004fa603fd1788244be3",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.44/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "c1055ca8db51eb4fe5798a1e6f2d910e345a85ee5cfc05b873ccbcfc0cb5c9d0",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.44/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "2b0a18d0017d231e17f1b2b3dbdc36daafde933ccf9d552065e3e4731590c529",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.44/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "ac29e3180e0a5f5b55b4535114fb963bd6088321bb1114a62dd7a04a6e8a0403",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.44/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "ca9b7d703288a4d1257453deb31686957fc84531cf178fecea3416b43735d817",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.44/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["9d86534cce666a885f304cc12e481a4888df97679b322b45dcc92f5b7e7cec9c", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.44/puller-app-linux-x86_64"],
                "macos__x86_64": ["ae1c7f6d883c184ef76454fd0e91f2ce024bb155ba464469b079ad02c44834de", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.44/puller-app-macos-x86_64"],
                "macos__aarch64": ["4657ad4aa1bb2a1486ab172c0f2ef0076da37dbf1c2cb05f96f1a9d5a1a41925", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.44/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
