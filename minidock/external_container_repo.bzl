def ___external_container_repo(repository_ctx):
    fetch_args = ctx.actions.args()

    digest = repository_ctx.attr.digest

    if not digest.startswith("sha256:"):
        fail("Invalid digest value, should start with sha256, as it is the only supported digest today but is a required prefix")

    fetch_args.add(repository_ctx.path(repository_ctx.attr.metadata_fetch))
    fetch_args.add("--registry").add(repository_ctx.attr.registry)
    fetch_args.add("--repository").add(repository_ctx.attr.repository)
    fetch_args.add("--digest").add(repository_ctx.attr.digest)

    result = repository_ctx.execute(fetch_args)
    if result.return_code:
        fail("Failed to fetch metadata: %s (%s)" % (result.stderr, fetch_args))

    repository_ctx.file("BUILD", """package(default_visibility = ["//visibility:public"])
load("@com_github_bazeltools_rules_minidock//minidock/internal:external_metadata.bzl", "external_metadata")

external_metadata(
    name = "metadata",
    config = "config.json",
    registry = "{registry}",
    repository = "{repository}",
    digest = "{digest}",
    manifest = "manifest.json",
)
    """.format(
        registry = repository_ctx.attr.registry,
        repository = repository_ctx.attr.repository,
        digest = repository_ctx.attr.digest,
    ))

external_container_repo = repository_rule(
    doc = "Fetches metadata about containers",
    attrs = {
        "digest": attr.string(
            doc = "Digest of the container image.",
        ),
        "metadata_fetch": attr.label(
            executable = True,
            default = Label("@//minidock:metadata_fetch"),
            cfg = "host",
            doc = "Fetch engine to fetch metadata",
        ),
        "registry": attr.string(
            mandatory = True,
        ),
        "repository": attr.string(
            mandatory = True,
            doc = "The name of the image.",
        ),
    },
    implementation = ___external_container_repo,
)
