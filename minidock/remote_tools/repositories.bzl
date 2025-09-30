load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")

def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "a2ccf053f711a5331bfa2c99946fe7f2e900cacb00c6f057fe4038be270b8a6a",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.73/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "3d4ef9799d6497a65cc986bdc17076574eae25b46ad4249bee30e5ebbe8e8477",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.73/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "b2d95c4deadc45ab6f1ef22eec47961eeb3bcc2850afb1ade4718ad18534cd2b",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.73/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "e25d089bcca0c9e02a8c60c8195630c29ba6a218740bdb7e1ca0aac7436a48b8",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.73/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "4114db22c1981d2286ac7c7d341d48f6acb9426f4fb585e1414dd0d528d47209",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.73/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "fd9f757b78efe7310f55a7983cbfb50485fa650c44293e04663dfb176aaf03dd",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.73/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["d1c82a3519ecfe9afb253dabe398b748e2a190ec07a69d1fe4f5de3ecccfe52d", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.73/puller-app-linux-x86_64"],
                "macos__x86_64": ["476de5c2d2c1135f9ee9cba0ad190aaa6179040a2157584e13308af1d93da697", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.73/puller-app-macos-x86_64"],
                "macos__aarch64": ["4ee87bcaa10c1a8ef3a2d717a221d48f0b214ff6ab5ad1a06b2a9707b9d5b636", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.73/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
