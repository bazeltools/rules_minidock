load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "e66cf68ae60ec10a4baa302b0c90b7dbe4b6df18a19dca2afcdbddf45a3474e6",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.51/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "cda45c3a631da8c2b5d3d7af0db5f1aa31ec6f88bfe56ffc5f7d51465006ed6f",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.51/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "014decd0e716f4e1fbf7316e0bdff03e34d49b5693f5b38983e453f5ecfce545",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.51/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "296dfa60beb5ae325297be22c475368ff4112dcdaa214ae2b67ddea71b50bb97",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.51/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "5b08ec51be4a5fb415ed7760db3a57c76d9d9c974c333bc79c5bb696cc459dcd",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.51/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "8d238c1d56bb1061951bdbabc33bed6637db4abc4b77bf5721f5e4215dec3853",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.51/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["4724b8e9c5457983a524d24a3643f39d382a22928a24de151fdb1c73fd5967c9", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.51/puller-app-linux-x86_64"],
                "macos__x86_64": ["1d0df44fd06d25be73bfb6f11eaaa578d2aa1cfa00754b86491f991bf84fc1d5", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.51/puller-app-macos-x86_64"],
                "macos__aarch64": ["f0b16d35a19ba1715f8384bea206cf5085dc9d0a35cddf928a8e1d7787b59a57", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.51/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
