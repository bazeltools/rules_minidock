load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "8d8374c2b6685a950842b0ab5cbd9685df74810e317ce21b1c32c44933464f1c",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.20/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "84cbb409444964e7a27484dc0bc1b3854ce6c890588802d2400a071264f897fd",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.20/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "12b99a18c0dad992a74303ee4a6ecc89b7e284c74a50885c430fa58f7a238490",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.20/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "52a3be2d12b02e34bf9be364976517366ba4ea6b0857462aebb75e3d469b7565",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.20/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "2b15665bd96779d971d18240f7f282137cc17734cbc1979c54b332b11bba089f",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.20/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "2c5ef51073ccf843e2e08091bcd2ddaeca68141cf2ebfac30ffed06cb28c636b",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.20/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["ff3d1f31758b109ff69a0a943675c41b6fe63b5e9e2e4e28d361adeadc80531e", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.20/puller-app-linux-x86_64"],
                "macos__x86_64": ["b224b11180594dad2dc0d15761b6f94a9695a5d009196714e1aa5238995e8ae1", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.20/puller-app-macos-x86_64"],
                "macos__aarch64": ["0a316a2eeca36522272b52b26fd15299975cabf22eae24a55ff5ce493293a694", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.20/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
