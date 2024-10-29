def ___external_container_repo(repository_ctx):
    # Repository rules don't seem to still be able to use aliases and constraints ?

    # os_name = repository_ctx.os.name

    # metadata_fetch = None
    # if (os_name.startswith("mac os")):
    #     metadata_fetch = "@rules_minidock_tools_metadata_fetch_darwin_arm64//:bin"

    # if metadata_fetch == None:
    #     fail("Unable to find metadata fetch for platform : %s " % os_name)
    #     # ":linux_x86": "@rules_minidock_tools_metadata_fetch_x86//:bin",


    digest = repository_ctx.attr.digest

    if not digest.startswith("sha256:"):
        fail("Invalid digest value, should start with sha256, as it is the only supported digest today but is a required prefix")

    fetch_args = []
    fetch_args.append(repository_ctx.path(repository_ctx.attr.puller))
    fetch_args.append("--registry")
    fetch_args.append(repository_ctx.attr.registry)
    fetch_args.append("--repository")
    fetch_args.append(repository_ctx.attr.repository)
    fetch_args.append("--digest")
    fetch_args.append(repository_ctx.attr.digest)
    fetch_args.append("--architecture")
    fetch_args.append(repository_ctx.attr.architecture)

    if repository_ctx.attr.authentication_helper:
        fetch_args.append("--docker-authorization-helpers")
        fetch_args.append("%s:%s" % (repository_ctx.attr.registry, repository_ctx.path(repository_ctx.attr.authentication_helper)))


    result = repository_ctx.execute(fetch_args)
    if result.return_code:
        fail("Failed to fetch metadata: %s\nSTDOUT: %s\nSTDERR: %s" % (fetch_args, result.stdout,result.stderr))

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
        "puller": attr.label(
            cfg = "host",
            default = "@rules_minidock__puller_app//:exe",
            doc = "Override generated based on settings option to fetch metadata",
        ),
        "registry": attr.string(
            mandatory = True,
        ),
        "repository": attr.string(
            mandatory = True,
            doc = "The name of the image.",
        ),
         "architecture": attr.string(
            mandatory = False,
            default = "amd64",
            doc = "Architecture.",
        ),
        "authentication_helper": attr.label(
            cfg = "host",
            executable = True,
            allow_files = True,
            mandatory = False
        ),
    },
    implementation = ___external_container_repo,
)
