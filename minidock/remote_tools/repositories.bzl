load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "09e48303f2ffaff0b53745757e6b8ab4f46c1e2153abe29f74fce5cebd6e3f8c",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.53/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "4dec25f318b4ae006df2f2664fbf58241d7890a23fb9d58382ce82d8b9aeb52b",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.53/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "cfac9bcc5a15de42b194d0964f7c17d8034cec33bcb19382d6820429628e8750",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.53/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "527f0a2d20a519e9ed19f1f73c69648cfac705bd71c96fe19fc879ac27360d6b",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.53/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "467f0de4256f51f5f77ba4e8cf1518bc327db7524ad5998baa13b40d1dcdce53",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.53/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "de42fbcf80a1acf0200f43294e0dbdf8caf1897b0547106cd88ef6fe30c3fec6",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.53/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["130aee188c47c2d0579f4b8d44b2410bb55a2e22743b1b194443d1a7cd12cb57", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.53/puller-app-linux-x86_64"],
                "macos__x86_64": ["58353969fc47613845b1fa95c2864af6790ff6ee4070c5961915a3cb344d6904", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.53/puller-app-macos-x86_64"],
                "macos__aarch64": ["593acebeed2bba3ae6d4ae14b2dd782c3af43ee64c7b28892cd55938243f936a", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.53/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
