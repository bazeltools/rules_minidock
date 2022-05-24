load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "6d32e2b240d4d19978fba4dfef99b17dc219e5d68b263f4218ad88490fc1c5a1",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.40/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "60584affbac46fffc67b3814f323f3dd4723ea9f8ed4a93ceda50dbeba139ecc",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.40/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "25475298a419836b81c1d3ef80335ece636171fdfd1f26a8dc1cb0d665cb679b",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.40/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "cb433416433a1e276d22b61334d57888849a5ef0d90e48a9826653b9cedfabec",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.40/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "a7c71d54000736c4aae4df7b078747aee42ca3d7de234e2751ad5cab000df9bd",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.40/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "5568e713af296e01098ba2506188ee7cc2067c1ae7b4ff6ccd2eccdcd5fb6aed",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.40/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["80e76b71e2539ce867edd4bab00331e5e3f55a626b0effb30371037321b62790", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.40/puller-app-linux-x86_64"],
                "macos__x86_64": ["f7d2901122c232ace21a96558c2c535fe7b7cf37891521d6229d58192e5e3443", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.40/puller-app-macos-x86_64"],
                "macos__aarch64": ["346bd28e2b9f0e164f4bfd8163d4319ec5886ffb37b5ce32dbd6d599fde5b532", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.40/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
