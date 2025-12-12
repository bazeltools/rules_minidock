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

    # Get puller binary path
    puller_path = None
    if repository_ctx.attr.puller:
        puller_path = repository_ctx.path(repository_ctx.attr.puller)
    else:
        # Read from multitool lockfile
        lockfile_path = repository_ctx.path(Label("@rules_minidock//minidock/remote_tools:multitool.lock.json"))
        lockfile_content = repository_ctx.read(lockfile_path)
        lockfile_json = json.decode(lockfile_content)

        # Determine platform
        os_name = repository_ctx.os.name
        os_key = None
        cpu_key = None

        if os_name == "linux":
            os_key = "linux"
            cpu_key = "x86_64"
        elif os_name == "mac os x":
            os_key = "macos"
            res = repository_ctx.execute(["uname", "-m"])
            if res.return_code == 0 and res.stdout.strip() == "arm64":
                cpu_key = "arm64"
            else:
                cpu_key = "x86_64"
        else:
            fail("Unsupported OS: " + os_name)

        # Find the matching binary in the lockfile
        puller_tool = lockfile_json.get("puller-app")
        if not puller_tool:
            fail("puller-app not found in multitool lockfile")

        puller_url = None
        puller_sha = None
        for binary in puller_tool["binaries"]:
            if binary["os"] == os_key and binary["cpu"] == cpu_key:
                puller_url = binary["url"]
                puller_sha = binary["sha256"]
                break

        if not puller_url:
            fail("No puller-app binary found for os=%s cpu=%s" % (os_key, cpu_key))

        # Download the puller
        repository_ctx.download(
            url = puller_url,
            output = "puller",
            sha256 = puller_sha,
            executable = True,
        )
        puller_path = repository_ctx.path("puller")

    fetch_args = []
    fetch_args.append(puller_path)
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
load("@rules_minidock//minidock/internal:external_metadata.bzl", "external_metadata")
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

_external_container_repo_rule = repository_rule(
    doc = "Fetches metadata about containers",
    attrs = {
        "digest": attr.string(
            doc = "Digest of the container image.",
        ),
        "puller": attr.label(
            cfg = "exec",
            doc = "Override generated based on settings option to fetch metadata",
            executable = True,
            allow_files = True,
            mandatory = False,
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
            cfg = "exec",
            executable = True,
            allow_files = True,
            mandatory = False
        ),
    },
    implementation = ___external_container_repo,
)

_container_tag = tag_class(
    attrs = {
        "name": attr.string(
            mandatory = True,
            doc = "Name of the container repository.",
        ),
        "digest": attr.string(
            mandatory = True,
            doc = "Digest of the container image.",
        ),
        "registry": attr.string(
            mandatory = True,
            doc = "Container registry.",
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
        "puller": attr.label(
            cfg = "exec",
            doc = "Override puller binary",
            executable = True,
            allow_files = True,
            mandatory = False,
        ),
        "authentication_helper": attr.label(
            cfg = "exec",
            executable = True,
            allow_files = True,
            mandatory = False,
            doc = "Authentication helper binary",
        ),
    },
)

def _external_container_repo_extension_impl(module_ctx):
    """Implementation of the external_container_repo module extension."""
    for mod in module_ctx.modules:
        for container in mod.tags.container:
            _external_container_repo_rule(
                name = container.name,
                digest = container.digest,
                registry = container.registry,
                repository = container.repository,
                architecture = container.architecture,
                puller = container.puller,
                authentication_helper = container.authentication_helper,
            )

external_container_repo = module_extension(
    implementation = _external_container_repo_extension_impl,
    tag_classes = {"container": _container_tag},
)
