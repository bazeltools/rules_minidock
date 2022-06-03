load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "09cdd94dd5c3cee45858f43d74bf4f4a6aad046ea41c7c0edd371d285c35a577",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.48/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "d035e13dd926e0b2299a28f4514aa77a367190c444908eb5c15fb6be8ffcff13",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.48/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "2e541b0fdfe7db8480cee946e65d7341d532c7503cc9c64fef798ea3a4dda564",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.48/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "2886c811fc645668675773e7ed9ec0cfeac88c725109605eb3aa972f385c8575",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.48/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "d4cd2cea5b45a89f85db1f8698693dd06df993d64a25f3c3cf45a2265645c060",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.48/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "fa5e276f38bf55775c24cc5ed4e0f030fab503ee43229cbc52d7792e3301f038",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.48/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["dc975a3f6c53d987c308f010bd90341a66bc4ea53fad08d908df3016492c0120", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.48/puller-app-linux-x86_64"],
                "macos__x86_64": ["f9a96e18997cc8f366a26c84cefdcc83440ebba7392756b0c9720010169b51bb", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.48/puller-app-macos-x86_64"],
                "macos__aarch64": ["e0d1336428e2eb985a412652e9993ea98fdcd0d36861c62a832c4279c9fc3a26", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.48/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
