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
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.29/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "ff90f19cca8741fb791c030cda3ed75eef2c95889b12f64e7ddaa31b08cdf8be",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.29/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "d058c2d53042229208a6d2faecde27ae7f4df30967e40e6aea775a658cf8fc46",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.29/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "ff41f2e4c5ed65a2e6b1fc70ab23dca1f04d67197a4beb27f7f95beedee9733f",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.29/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "b46ad914fcd293a41c69e92dc4a2e72840d9867ff4493aee335ad98f100baf55",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.29/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "f565a47f2dd372d768f4a37238879ce5dc2d816c324b119781e8a3ad7c2af291",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.29/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["744a31eec04e06c33a7a95561b6c9e91c68eca633a18dc24b4254c00a2f42c34", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.29/puller-app-linux-x86_64"],
                "macos__x86_64": ["1e04d95473091098698e53afc6e967d6c55a6778a5553c3838ffcf934056f2e1", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.29/puller-app-macos-x86_64"],
                "macos__aarch64": ["958800867fae8be184b07266ce5dfe5dc1472bf3698a70559816d2afe777b602", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.29/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
