load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "3018cb3f385d02abea8e44b328167c8d4e3b23c975d091028c7cfa65001304c3",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.16/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "0930d19f46eadc9c21ed5a74ef656326a19ecbd2716714445169d97555b899da",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.16/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "c5c762739d1a68824038fcf9775c675de191a8923c19827669c6b6f5a63b1fdb",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.16/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "80a390aef0dc51be94d38e2d145c2ab5206daaba16b5d0045ea6d168cfed469f",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.16/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "a68ccabca7b67392a6e37e056f4ab46d3973508d3273ed17f2a8aee688b9769f",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.16/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "d785543eadb6051ca239a2a6a700b38e39cd85a98108d94400dd354df3095086",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.16/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["b79e140f5ca7c44ef039bf282463a6a4c96bc8af958b1b26390729cd5cdb0a4d", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.16/puller-app-macos-aarch64"],
                "macos__x86_64": ["b79e140f5ca7c44ef039bf282463a6a4c96bc8af958b1b26390729cd5cdb0a4d", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.16/puller-app-macos-aarch64"],
                "macos__aarch64": ["b79e140f5ca7c44ef039bf282463a6a4c96bc8af958b1b26390729cd5cdb0a4d", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.16/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
