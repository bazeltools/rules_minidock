exports_files(["puller"])
load(
    "@com_github_bazeltools_rules_minidock//minidock:container_data.bzl",
    "container_data",
)

load(
    "@com_github_bazeltools_rules_minidock//minidock:container_compose.bzl",
    "container_compose",
)

load(
    "@com_github_bazeltools_rules_minidock//minidock:container_push.bzl",
    "container_push",
)

container_data(
    name = "file_a_data",
    files = ["file_a.txt"]
)

container_data(
    name = "file_b_data",
    files = ["file_b.txt"]
)

container_compose(
    name = "test_simple_imagen",
    base = "@bazel_320//:metadata",
    layers = [":file_a_data", ":file_b_data"]
)

container_push(
    name = "test_push_simple",
    composed = ":test_simple_imagen",
    registry = "http://localhost:9000",
    repository = "docker/test",
    container_tags = ["unchanged_tag1"],
    merger = "//merger:merger",
    pusher = "//pusher:pusher"
)
