load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "c783c7a2d332fdc6373d8f325e6c2e2d05de7b5b9b1b03ecb47af98b646efbd7",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/ianoc/rules_minidock_tools/releases/download/v0.0.6/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "14763ddca109a354fa1a6cfac5953e8635cafe58bd8db4456a4978b089d3e1c3",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/ianoc/rules_minidock_tools/releases/download/v0.0.6/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "77ddb4ad4c79ef1c63e83d2da8e37c65b9520bfe96f30013cb7873d111d53986",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/ianoc/rules_minidock_tools/releases/download/v0.0.6/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "17a7c159141fd13c771682ccd88013124c5b23c37c36cac1dc26eea288be9be5",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/ianoc/rules_minidock_tools/releases/download/v0.0.6/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "d312f490c8f8492753efc63984d8a8842a49db910fa5e3200d59206e62835adf",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/ianoc/rules_minidock_tools/releases/download/v0.0.6/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "f94b218dd06f041b6ef9b4a1b6c6a34ad26b0f42c0f69b677a72a524ccfe9556",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/ianoc/rules_minidock_tools/releases/download/v0.0.6/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["a0740aea059ad316e90cb3682b01beee70b71c8c7e280551463a8fd0c8768b83", "https://github.com/ianoc/rules_minidock_tools/releases/download/v0.0.6/puller-app-linux-x86_64"],
                "macos__x86_64": ["69379792732651a04a575ac17530b2ecbc2d3b125e8221b6cf66ed4ee1cf865e", "https://github.com/ianoc/rules_minidock_tools/releases/download/v0.0.6/puller-app-macos-x86_64"],
                "macos__aarch64": ["266ddd10d9795e794cdbead0298a9f7d8d339d8647c60007c720ba562a0f3ae7", "https://github.com/ianoc/rules_minidock_tools/releases/download/v0.0.6/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
