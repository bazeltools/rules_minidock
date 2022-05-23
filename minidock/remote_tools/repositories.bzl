load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "64bb4f9363591316b66c74c6d049997e6458a37fca05eaa7ce227a474ff85fdc",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.35/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "7631033e88052aef97d0fa4dd4d83b2f2530c5e098695893ecf1451475d5c5da",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.35/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "ba39f8b81ccae7981f1ded1325403509e430094104c98174cfc2c04bc2bdabec",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.35/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "46a62495c854c65ee7cf50bf108f1e5f73a02dd20b53a15408062030b26a709b",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.35/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "4322e696f278515369f641797de65b25761c70aa115e773975d9077110756753",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.35/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "84919fa3533e4fa5998c50487c663a5c10f24090c75d9d7b8b70ab196e965265",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.35/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["743794acde8bfb2ac95e64a70136b2274debcccc5e74cb083692d3726bbd7b4f", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.35/puller-app-linux-x86_64"],
                "macos__x86_64": ["3b59bd851e400329d6f8edc6b282273aae0302873ab4a3fbc49424b9d72f3fd4", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.35/puller-app-macos-x86_64"],
                "macos__aarch64": ["4857f562d33c06fe3fd5dea5133bdb4815a2e80905506a7e51f91aa046c85611", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.35/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
