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
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.26/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "ff90f19cca8741fb791c030cda3ed75eef2c95889b12f64e7ddaa31b08cdf8be",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.26/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "d058c2d53042229208a6d2faecde27ae7f4df30967e40e6aea775a658cf8fc46",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.26/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "080aaa21207ad6a7fc0bb391829029f462cdb528b5dce223bb394e11baa5edb5",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.26/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "c13614a4cf2d2d6a1bf0db53a2f5592c58bd878354c06ea7a4027458e6d10a23",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.26/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "fea28cb5b8f35bee9e46d88528f1a712a9e10947070c945b56ee0bbfe7ac619d",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.26/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["10310856a58d9d3bae06e8d0b9618c2fc3e4e258febcbbb8f118fafcc3e28898", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.26/puller-app-linux-x86_64"],
                "macos__x86_64": ["bb327c72a59a14699de71f3ca5bab30fb3d7233197ad64a5b409d1ef819cbb11", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.26/puller-app-macos-x86_64"],
                "macos__aarch64": ["a2f156adf93ffafa43778fe597cf90c2c9032083b4312d27657b767c6b389a2a", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.26/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
