load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "a2f11bb0e135271a1d41a8812a2532e0ea8868d40ac89d00ac4e58b953b11e52",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.61/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "1591fc03b647b6d399e26250dd30115463a44215a1e343a067b0c75f8404287b",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.61/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "4f3aa6d5984b138cd7af5811c346d53351d3ca02e8364d9072378965efb6240e",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.61/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "1c83cb1c84239cbaddf58bac1b43ae83546c8cf5ec51a3a9aae9e4e3bcd3b538",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.61/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "d83b047bcbb47238a02897350f4f3ee24020f30cf70b0db7c226922d36d00b18",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.61/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "33298b9299acba15e90667b806305a52de6146614124c790ef7def9305ff5c5c",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.61/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["a6d338d9df9b9c087421152387cc5be19431f6dcff5b4d476ab2aace762bb067", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.61/puller-app-linux-x86_64"],
                "macos__x86_64": ["bd52783111fe6c22647d2b5dddb680e7f46d08338dc96867fcceee54864131cb", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.61/puller-app-macos-x86_64"],
                "macos__aarch64": ["5cc25b21a749d5384b6c374b4f9a02ce26cee2ea8aa349f948e5d4ff645b47cd", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.61/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
