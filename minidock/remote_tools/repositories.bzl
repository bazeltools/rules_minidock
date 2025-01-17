load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "94fdb82f9eeb7ff267027145c62c04c74d3cfabc26f9fa75fba17c7a63926a0a",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.69/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "7be3c6d5dd4eaea32962b4e32cb5d5fd7c7ef71c887805dc883440e273b358b8",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.69/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "3f512799aadd95bf76d6d7eb938c171783f0186710af1f4f6e4e17fac8f5aae2",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.69/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "c63a5e5e7e7266fb1c6732d8e87ff5dc433d876a26c1ab27df2ccf9fc2d6e1d5",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.69/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "b675d239cf2ff23b15b4773b57bfbf6041196da3db6b41677ca1b34d2a21547c",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.69/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "f8ed2328aadd2d9b6c0acee82d51d60ede983b7eb19a43e2b082f12fec3e7501",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.69/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["df78d6ee4e2712cadbbad03e4df86d376bcec661117a59e0287e1eb47669a6aa", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.69/puller-app-linux-x86_64"],
                "macos__x86_64": ["e19477a435124eb38f4930d66799415e86c445262ba5f02005246e87ec491ad2", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.69/puller-app-macos-x86_64"],
                "macos__aarch64": ["ccf7788301eca98a30dcff7a67b46d1d75206c2fb6fef6a32c994ae8d17b8903", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.69/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
