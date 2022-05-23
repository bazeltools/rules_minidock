load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:load_tool.bzl", "load_tool")
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:repo_rule_load_tool.bzl", "repo_rule_load_tool")


def load_tools():
    excludes = native.existing_rules().keys()
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_START

    if "rules_minidock__merge_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_linux_x86_64",
            sha256 = "39aadd72ec2ad528ce31573ef70648d512768e6f8461fb88450f21f80ba7ffce",
            packaged = False,
            binary_path = "merge-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.33/merge-app-linux-x86_64"],
        )

    if "rules_minidock__merge_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_x86_64",
            sha256 = "e615b4579c7d42a610de45a2773e37bd4f8c747afa7bb85a2154e1f6f255bb82",
            packaged = False,
            binary_path = "merge-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.33/merge-app-macos-x86_64"],
        )

    if "rules_minidock__merge_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__merge_app_macos_aarch64",
            sha256 = "ba39f8b81ccae7981f1ded1325403509e430094104c98174cfc2c04bc2bdabec",
            packaged = False,
            binary_path = "merge-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.33/merge-app-macos-aarch64"],
        )

    if "rules_minidock__pusher_app_linux_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_linux_x86_64",
            sha256 = "770c369dc341c5840cafcc6d96c1c6b5ef3587adffa728220f495339cfea1d72",
            packaged = False,
            binary_path = "pusher-app-linux-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.33/pusher-app-linux-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_x86_64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_x86_64",
            sha256 = "a4ba58fa12d8578c3715b0f160bbf538259332f9b2f2b7a5afd98b33d1061350",
            packaged = False,
            binary_path = "pusher-app-macos-x86_64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.33/pusher-app-macos-x86_64"],
        )

    if "rules_minidock__pusher_app_macos_aarch64" not in excludes:
        load_tool(
            name = "rules_minidock__pusher_app_macos_aarch64",
            sha256 = "72f6da13b5cb646786f996feca9a0c4d5e007b036511e6212c54a59c1fe47365",
            packaged = False,
            binary_path = "pusher-app-macos-aarch64",
            urls = ["https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.33/pusher-app-macos-aarch64"],
        )
    if "rules_minidock__puller_app" not in excludes:
        repo_rule_load_tool(
            name="rules_minidock__puller_app",
            platform_to_sha_pairs = {
                "linux__x86_64": ["b187dbaca9d7d80957b510b249c08295adcfa5996dc9dd6a4134983e9d02dd37", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.33/puller-app-linux-x86_64"],
                "macos__x86_64": ["d3643c9b65aadc82574cf633f2c03953970d825804068355ac77728d6db9c9a9", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.33/puller-app-macos-x86_64"],
                "macos__aarch64": ["d7a4a11b7dbfa2da5a78d1b832eea3f343e1a81c6262f927f8bfb4d831aeadc8", "https://github.com/bazeltools/rules_minidock_tools/releases/download/v0.0.33/puller-app-macos-aarch64"],
            }
        )
    # RUST_BINARIES_AUTO_GEN_REPLACE_SECTION_END
