load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "4ba52af51d8caa454cab7a28dab874de5fd33c10ea9f7ff76dda1b08d5505b26",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.32/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "bea2fd7a168f40fdfdf5464861558c9d81dc12f0a8d4985518c47e6718b3cf55",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.32/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "e04a75122d4623e1c00b1e30736700d5aa94693862e6ba3ffc974802fc11beee",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.32/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "de076bb542e38f533f2ec191cdd5c06b20a127dd8b299ab632fba16b4663fa2a",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.32/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "c6d587d473c27f9b6f2a53e086d01e417cfaeaaef7f5e0482771724a4d74463d",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.32/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "d0e15376fce866cfe7c1de5e4c4d4dea95a5ee4e7e8f51207b1de70559b32d56",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.32/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["d6d79dd2256a9cf761fadfbd093960a193e44541d76d511a5e826c9050d49e34", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.32/puller-app-linux-x86_64"],
                "macos__x86_64": ["83e8e63372d7fdc22a6590f30ccab3080f5f92c7fe71e006583dc84d4bbb2184", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.32/puller-app-macos-x86_64"],
                "macos__aarch64": ["aee6000d5125f00b4b2024d0c3f369bf4ff2a970335ee767d6ea980b870066e9", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.32/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
