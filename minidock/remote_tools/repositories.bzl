load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "208b34ca09a7b2de39fcc9b099fdf017436578ba46fdf26985bed7c3fbae197f",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.65/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "88609bf9af391fe65dc3e24e3879326298dff6b7a83ba435410dd3ac81e30f27",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.65/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "7cf341b31d59a8bdbf69f791f3d395c8f5bda2db1d8927b81d3532b0fbd64453",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.65/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "538926989c6e24299c90068f22b015c145f160a7ae25267c90ee5e66503064d5",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.65/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "88b04cfd5c5f7b3454eff431344d978e1faa0e197da660225491d0e472d360b2",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.65/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "829a7273175c5d915544064cc06b30f3c2c996ba336049eba985de25ecd2f7aa",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.65/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["8050554cc194e85ac250c973eb3e82b4b980c4f82fc2c56fb7876723cc3024e6", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.65/puller-app-linux-x86_64"],
                "macos__x86_64": ["5d754eb8ac8330ad5b05a945f8ccad62d943822b43855365f23f3d0cd19cc20a", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.65/puller-app-macos-x86_64"],
                "macos__aarch64": ["e6854323990f0ce039f3e68a9ed4b1c41a0b827997391c688d9fce27b5e1f4cf", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.65/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
