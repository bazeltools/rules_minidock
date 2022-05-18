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
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.12/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "0930d19f46eadc9c21ed5a74ef656326a19ecbd2716714445169d97555b899da",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.12/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "c5c762739d1a68824038fcf9775c675de191a8923c19827669c6b6f5a63b1fdb",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.12/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "88a5d8d8113c6981fc9695fcb897c72bbc9d8c7092de2d7b768764a24aa2fb10",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.12/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "967b8ee4a5caf918b1f071fbcbc7718fdc7b9303b137dbe5102733399f07c4fa",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.12/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "2c03b9994faef0551a7e87ee77f4d4045870ddf248bbdbc60539991bf5410825",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.12/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["b79e140f5ca7c44ef039bf282463a6a4c96bc8af958b1b26390729cd5cdb0a4d", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.12/puller-app-macos-aarch64"],
                "macos__x86_64": ["b79e140f5ca7c44ef039bf282463a6a4c96bc8af958b1b26390729cd5cdb0a4d", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.12/puller-app-macos-aarch64"],
                "macos__aarch64": ["b79e140f5ca7c44ef039bf282463a6a4c96bc8af958b1b26390729cd5cdb0a4d", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.12/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
