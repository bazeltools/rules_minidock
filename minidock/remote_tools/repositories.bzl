load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "222590b0a213bd3fec415c3f235a57a04b209c5c86645065a580a0864a20b74f",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.18/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "db8cc2a5c1fd79ac7b082ac3d8e588fab3601cacaa4d4310276e9a427a065544",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.18/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "1d4dc9ed783fc53dd2a7c339ab5b6c60d37502e0d5219360596d7e210b639173",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.18/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "c42ee7f22f0b071d2c490aec8bf3116fd3d7c5f875b34e28a9a342e53ddc8dc7",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.18/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "78906ec1f43f314c9aefe15c8df1e1b073aeb23213f1c4b0b43bbfd6ba749ab4",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.18/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "023014b5f98b18fbffed5f97297ada3f12ebae9aeb3a330e7ae405dddd8a0a80",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.18/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["66ddb8ddfe14a53451787f13c1b262b09cd0b060e2891d4b5ea63cbcbd560918", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.18/puller-app-macos-aarch64"],
                "macos__x86_64": ["66ddb8ddfe14a53451787f13c1b262b09cd0b060e2891d4b5ea63cbcbd560918", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.18/puller-app-macos-aarch64"],
                "macos__aarch64": ["66ddb8ddfe14a53451787f13c1b262b09cd0b060e2891d4b5ea63cbcbd560918", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.18/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
