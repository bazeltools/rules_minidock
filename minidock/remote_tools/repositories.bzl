load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "9ae88eb012f6ddcdeef87e1bf0d2d050fac78e9007c78b3433d0ec44f0f20c4a",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.56/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "2ebb3e2d31686399b61c188d3519ad7cb762fcbcb42f6037e65cfa10f1e55578",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.56/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "cf4ac984193348aa927ef567e18987e9fdceca04097d9386364b2537f20aa0bc",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.56/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "5406a376c263cf135ab1a7b7821eee935cb7d8d9374ebf45beb6dee39bc4cb7c",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.56/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "f109170cf9b486b8abbc8c1d581973d1c65ae5eb47ccaef2732f2d87f78be4b2",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.56/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "077b894ae88997010bc228cf0d6a86388ccb1772f3edfda9062c8071b1d0b6c4",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.56/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["c9b1c867a481f40c3078fef4eacc27f11150cf383feb6b038a1f2bd832ab5f6a", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.56/puller-app-linux-x86_64"],
                "macos__x86_64": ["09b6ae3d3b9375de67784d2fe127bdcaf4f4af10b3ee7258bc01f8d5cb462a55", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.56/puller-app-macos-x86_64"],
                "macos__aarch64": ["d65f6d8c556bc5840aac7b2fb8152d2cc6a3ae28381cc3309cff671684bd63f4", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.56/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
