load("@rules_minidock//minidock:providers.bzl", "ContainerInfo")

def __external_metadata_impl(ctx):
    manifest = ctx.files.manifest[0]
    config = ctx.files.config[0]
    container_info = ContainerInfo(
        remote_metadata = struct(
            manifest = manifest,
            config = config,
            registry = ctx.attr.registry,
            repository = ctx.attr.repository,
            digest = ctx.attr.digest,
        ),
        parent_info = [],
        config = None,
        layer_data = None,
        dependencies = depset(ctx.files.manifest + ctx.files.config),
    )
    return [
        container_info,
    ]

external_metadata = rule(
    attrs = {
        "digest": attr.string(doc = "The digest of the image"),
        "registry": attr.string(doc = "The registry from which we pulled the image"),
        "repository": attr.string(doc = "The repository from which we pulled the image"),
        "config": attr.label(allow_files = [".json"]),
        "manifest": attr.label(allow_files = [".json"], mandatory = True),
    },
    implementation = __external_metadata_impl,
)
