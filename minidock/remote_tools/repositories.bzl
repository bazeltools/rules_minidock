load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "9f5172decafe799ea5611617929c58ab04a374f1979133d416b15f6d0a0ec22c",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.24/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "343289d58bf10387dda19c21f644ecd56f9f32b0bae85607011b2fd373945b37",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.24/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "c30d39306aeff4666e5c72cc9c706d14111a42264b324c04d174be7721594a1d",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.24/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "07db0cd1a567455734a87b79d8b3bfc923907ba6b37364eeefab14d6bfc888f6",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.24/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "ed7a4997dfe329632bb076c3203face160ce00672eb5224bd7e120f820245429",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.24/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "a69fdc708d861c3d015ad2fac98e09d34d0847e3e3008f1d67ccada37011ac36",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.24/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["f8cab39d0ad8c10a92e2f857bcdf2be18c9d6f23b6a493b3b4468ab3b65dc042", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.24/puller-app-linux-x86_64"],
                "macos__x86_64": ["c5eaf56764c9102d87a5ce8c6996516ad9ad2b80fa6797789a8f055bdb4fdf35", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.24/puller-app-macos-x86_64"],
                "macos__aarch64": ["42be9cfe4578f508c16b9be42d3fd6fd3fdae14e5ca94f291772e911c8e0d220", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.24/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
