"""Module extension for rules_minidock tooling."""

load("//minidock:external_container_repo.bzl", "external_container_repo")


def _test_repos_impl(module_ctx):
    """Implementation of the test_repos module extension.

    This extension sets up external container repositories for testing.
    """
    # Set up the bazel_320 container for tests
    external_container_repo(
        name = "bazel_320",
        digest = "sha256:08434856d8196632b936dd082b8e03bae0b41346299aedf60a0d481ab427a69f",
        registry = "gcr.io",
        repository = "bazel-public/bazel",
    )

test_repos = module_extension(
    implementation = _test_repos_impl,
)
