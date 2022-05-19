load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "980e1709d34fe5fa660f253d96a037f0259dac65878e6c0f71b64349735b7fc4",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.27/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "ff90f19cca8741fb791c030cda3ed75eef2c95889b12f64e7ddaa31b08cdf8be",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.27/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "d058c2d53042229208a6d2faecde27ae7f4df30967e40e6aea775a658cf8fc46",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.27/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "1d71a597280be1b3822b1f420bb5ec62b1483a8497cdd6e5371faf43e22ecdf3",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.27/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "b5bddab4c760e931b0bb892e99486925c87d70520e1783705070340f7e3b31f6",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.27/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "93e1e03c932482a9031e1a8751f963f77d1ee6da2783737f1f2b777d1386ebe4",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.27/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["a032791b70aac99903f9dfa8c0d54e6afccba67b518b004b157029778a434f52", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.27/puller-app-linux-x86_64"],
                "macos__x86_64": ["e553ff02d39e3b983c2a86b9bafd91587bbd0ea38ac50ab6248e65bc5d9c3b45", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.27/puller-app-macos-x86_64"],
                "macos__aarch64": ["a69ddf1eed1e506cff08134c07bab5ad1f7e91fb2c80ba23386c466fd1b4d897", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.27/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
