config_setting(
    name = "macos_x86",
    constraint_values = [
        "@platforms//os:macos",
        "@platforms//cpu:x86_64",
    ],
)

config_setting(
    name = "macos_arm64",
    constraint_values = [
        "@platforms//os:macos",
        "@platforms//cpu:arm64",
    ],
)

config_setting(
    name = "macos",
    constraint_values = [
        "@platforms//os:macos",
    ],
)

config_setting(
    name = "linux_x86",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
)

alias(
    name = "merge_app",
    actual = select({
        ":macos_x86": "@rules_minidock__merge_app_macos_x86_64//:bin",
        ":macos_arm64": "@rules_minidock__merge_app_macos_aarch64//:bin",
        ":linux_x86": "@rules_minidock__merge_app_linux_aarch64//:bin",
    }),
    visibility = ["//visibility:public"],
)


alias(
    name = "pusher_app",
    actual = select({
        ":macos_x86": "@rules_minidock__pusher_app_macos_x86_64//:bin",
        ":macos_arm64": "@rules_minidock__pusher_app_macos_aarch64//:bin",
        ":linux_x86": "@rules_minidock__pusher_app_linux_aarch64//:bin",
    }),
    visibility = ["//visibility:public"],
)
