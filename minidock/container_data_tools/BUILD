load("@rules_python//python:defs.bzl", "py_binary")

py_binary(
    name = "build_tar",
    srcs = ["build_tar.py"],
    data = ["@zstd//:zstd_cli"],
    visibility = ["//visibility:public"],
)
