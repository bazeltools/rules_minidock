load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "6ee20214fa33ed929663d32fa7e4405f1ccf12b0063d13e5d6d3320611ea5691",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.67/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "76eccf85f03685b98510b94d9fe1260eee30ffbfadcc2c5f05ae59c36387c213",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.67/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "ce28de82a8ae529104f3b96c0b8cf432b55d3cd14ed267a123d352470146a49d",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.67/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "3ce30fb25f9f2f20e7d69bc405596d9be8467c348b2dd3e889d98cfebe0a8110",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.67/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "4b17dcaec1bd69d0e164948b461fbdc6e319c6bed133906e99663f172ddeb3ab",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.67/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "d920e1243b1be0125624e3185faf52fbce81dab8d3c592706652b01da264579b",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.67/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["0ca3a02049653b4528211d1ad1cb50645f2aeb28e4fb5f47e4512d1ab6ca4335", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.67/puller-app-linux-x86_64"],
                "macos__x86_64": ["13196354e535606551a29cc282dbd4e3806f3c66d12f5b4a36bfea65feb0cded", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.67/puller-app-macos-x86_64"],
                "macos__aarch64": ["211623458cf0373c299c9daf8b10db34e6f651985a4957e3da61536d43875c8a", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.67/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
