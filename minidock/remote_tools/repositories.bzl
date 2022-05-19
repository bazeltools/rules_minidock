load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "16a9f7cc89674c70413a10d505c767e2dbe3e6b89da28f50cc3aaaa550bf8e8e",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.25/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "ff90f19cca8741fb791c030cda3ed75eef2c95889b12f64e7ddaa31b08cdf8be",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.25/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "d058c2d53042229208a6d2faecde27ae7f4df30967e40e6aea775a658cf8fc46",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.25/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "b400f9cab6a1596573459191c45d79e43d51ea7ba9a224eba39b9ec362194ad5",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.25/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "76a996851f122e70e841d153ef14b7ac89f9a781cd27e96e14d19a2f7588b59c",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.25/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "dd718e81b0620abdf8b7c20b049e2c00a00e62d85718a293802d715e3b3cfc8d",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.25/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["f78cbdb951e6fa2d63a7ad783f27990e48294e5de54f4a8f2ed35e3c01c201d4", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.25/puller-app-linux-x86_64"],
                "macos__x86_64": ["a21d0e96b11a9b8ee3a8d82de9bc214948e8a6288558951151940aee3bc05bad", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.25/puller-app-macos-x86_64"],
                "macos__aarch64": ["8b8d75db978546ccee956e931262d3a67e8d1aaf64d50b29cab109fb1588397b", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.25/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
