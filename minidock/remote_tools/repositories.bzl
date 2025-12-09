load("@rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")

def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "ec36e90e1dfd4ab486647715acb20c404ed5e1427ec51fc6bcd0fa2d471fbf6c",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.75/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "633065d4f5199c20fe0fc9a750fc41f2b5bf0b28d4f51d5d4dab9bc3f1a56c97",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.75/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "110d44df10c495d972533cb4db134dd1a95db7c436180655b1258e1f17c9154b",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.75/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "6448bb16191cb4e0f8750003c43ab158df58ecc1cd0644179e60fbf0556638c7",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.75/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "da24d3a25d46c7561bcdb21fa21c938cac20862a26d62f774f46e8b38ed68a32",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.75/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "449fbbe83f680138143ace22f02d980197ddcd8c94dbf293f448833e403e37e1",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.75/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["9a28cd949268a397e57c4faf106a942f3053438c84b70077072452d83971060a", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.75/puller-app-linux-x86_64"],
                "macos__x86_64": ["70bc80d0f1e098a6d2f522a4f907011f54ce15e5a8bd300ee3442a777f75eafb", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.75/puller-app-macos-x86_64"],
                "macos__aarch64": ["950d2192cc23ff4dd44d7dc7b942b6ec02b425a03d648924136449ff0702002d", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.75/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
