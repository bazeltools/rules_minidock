load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")

def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "da071439fa5f8211d3db3913b5bd2bc14e2dc6c8a30d657a9e319d7459805c7a",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.74/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "dcf74c98e31381db7df3ec85088877ac74479db655183fd65b48dca058fe7d36",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.74/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "bc09ce9610ff74dcee8059177ce3a9c0f215c7eb6a3db0e321f6e537d178e577",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.74/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "2d2f6e43f9ff61296804abf52c7b5ee61eda76c39d23f940c360a91f4942368f",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.74/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "84c3530bf58e985812b558e69bb908422a984f1102c91c7d2081e93d72797e49",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.74/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "0e07cbf653ae9b211e559f6d1162d1582fca2cb669e9d2acfb08a902ec085e20",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.74/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name = "rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["55582c7977e2bf3c1e2eee59b039fd3fb806dbf39d423068d42248823f7744bc", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.74/puller-app-linux-x86_64"],
                "macos__x86_64": ["450a5e23b20563ad623db0d20e39e753968b01c3fcc4ac13637913351b25377a", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.74/puller-app-macos-x86_64"],
                "macos__aarch64": ["58a52a3231c29d11561d8507a2c707fbf8ea3f386ee93c2c3f739f0bcac6fbcc", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.74/puller-app-macos-aarch64"],
            },
        )

    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
