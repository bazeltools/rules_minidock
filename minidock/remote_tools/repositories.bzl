load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "4f69af19acec49659ff5b0b7598c436aa8625a8341e49ef311db012b5e06a4ef",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.43/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "82e0a11c34d16b6cb4a48fc3ab3c46d973ec165556a95936c666929ecf6cd6bd",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.43/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "f861d109bde11a00dbf9daddb346513dfd059ae8421423ea63e1b4727b724efe",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.43/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "bdc272883defdc4902493725b7d8360121b9cd4629ceeca140b780dd637f85d7",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.43/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "ff886fcad288397c12c6f4b992055610e2611e056d8301e8a5261d698ad227ed",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.43/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "b98f46b8db0147cc555f0c3b87f1d0c912c0f5bfabb18fc897e0a9136d834206",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.43/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["7a6fa0323a4a6f6a7b8ce0e66ddad3523ab2e5de46f88bf34b316801ddbbdc8d", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.43/puller-app-linux-x86_64"],
                "macos__x86_64": ["72e54483d005bc8121c326851aa19d7eef1f086f13f72e7d79a323c05c17e08b", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.43/puller-app-macos-x86_64"],
                "macos__aarch64": ["072d1023dd29c4c1046a4908946ba30aa9e9c0bfb8184852838fb2f9ee4ce5cc", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.43/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
