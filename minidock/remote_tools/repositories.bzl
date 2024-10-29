load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "f800dcc7d1cbf26ec93ae55902289d386651f96062d9225d8553f9afa8683854",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.64/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "f6bded8a4409501b3a1be45f8acfa2ae101888b9b36fe6cac968c2d77d69a872",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.64/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "d27b0762c2bbd240b3ec27f562b421a97c84eba21d28c9e9f8b5bb2549c8dcf4",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.64/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "9343932e85da099f78c46d1127689f1b358782d98ea03e46b248e7b9487a7841",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.64/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "dccbe50b8eb880781e7b93cb58cc8c32c9ecffb94fb8874aa33ab700a44e751b",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.64/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "9256d7fadbfd12c2cf213faf5a5b090fb97137ead82cd7f68f40dbdf1ab2d221",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.64/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["ee53c96f6760f56a39a867972ac7a93bfe8a48536120c7b798b813b79e756439", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.64/puller-app-linux-x86_64"],
                "macos__x86_64": ["ff5de54ba000e91c46ed4d061467bc13b0f03b196845e7169c1242413793fa41", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.64/puller-app-macos-x86_64"],
                "macos__aarch64": ["dd75b2cb63249c40102c14c81f608d0148802d04aef60e7ebc3b055c2ce59e82", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.64/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
