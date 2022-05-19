load("@com_github_bazeltools_rules_minidock//minidock:providers.bzl", "ContainerInfo", "container_info_struct")


launcher_template = """
#!/bin/bash

set -euo pipefail

exec {tool} --pusher-config {config_file_path} --cache-path {local_cache_path} "$@"
"""

def __container_push_impl(ctx):
    merger_input = []

    composed = ctx.attr.composed[ContainerInfo]
    composed_transitive_deps = composed.dependencies

    configured_data = ctx.actions.declare_directory("%s_configured_data" % ctx.attr.name)
    merger_config_file = ctx.actions.declare_file("%s_merger_config_file.json" % ctx.attr.name)
    ctx.actions.write(merger_config_file, json.encode(container_info_struct(composed)))
    merger_input.append(merger_config_file)

    merger_args = ctx.actions.args()
    merger_args.add("--merger-config-path").add(merger_config_file)
    merger_args.add("--directory-output").add(configured_data.path)
    merger_args.add("--directory-output-short-path").add(configured_data.short_path)

    ctx.actions.run(
        inputs = depset(merger_input, transitive = [composed_transitive_deps]),
        outputs = [configured_data],
        arguments = [merger_args],
        executable = ctx.executable.merger,
    )

    registry = ctx.expand_make_variables("registry", ctx.attr.registry, {})
    repository = ctx.expand_make_variables("repository", ctx.attr.repository, {})
    container_tags = ctx.attr.container_tags
    container_tag_file = None
    pusher_input = []

    # If a tag file is provided, override <tag> with tag value
    if ctx.file.container_tag_file:
        container_tag_file = ctx.file.container_tag_file.short_path
        pusher_input.append(ctx.file.container_tag_file)

    pusher_config = struct(
        merger_data = configured_data.short_path,
        registry = registry,
        repository = repository,
        container_tags = container_tags,
        registry_type = ctx.attr.registry_format,
        container_tag_file = container_tag_file,
    )

    pusher_config_file = ctx.actions.declare_file("%s_pusher_config.json" % ctx.attr.name)
    ctx.actions.write(pusher_config_file, json.encode(pusher_config))

    pusher_runfiles = [ctx.executable.pusher, pusher_config_file, configured_data] + merger_input + pusher_input
    runfiles = ctx.runfiles(files = pusher_runfiles, transitive_files = composed_transitive_deps)
    runfiles = runfiles.merge(ctx.attr.pusher[DefaultInfo].default_runfiles)

    exe = ctx.actions.declare_file(ctx.label.name)

    ctx.actions.write(
        exe,
        launcher_template.format(
            tool = ctx.executable.pusher.short_path,
            config_file_path = pusher_config_file.short_path,
            local_cache_path = ctx.attr.local_cache_path
        ),
        is_executable = True,
    )
    return [
        DefaultInfo(
            executable = exe,
            runfiles = runfiles,
        ),
    ]

container_push = rule(
    attrs = {
        "composed": attr.label(
            providers = [ContainerInfo],
            mandatory = True,
            doc = "The label of the image to push.",
        ),
        "registry_format": attr.string(
            mandatory = True,
            values = [
                "OCI",
                "Docker",
            ],
            doc = "The form to push: Docker or OCI, default to 'Docker'.",
        ),
        "registry": attr.string(
            mandatory = True,
            doc = "The registry to which we are pushing.",
        ),
        "repository": attr.string(
            mandatory = True,
            doc = "The name of the image.",
        ),
        "container_tags": attr.string_list(
            default = ["latest"],
            doc = "The tags to push for the image the image.",
        ),
        "container_tag_file": attr.label(
            allow_single_file = True,
            doc = "The label of the file with tag values, added to tag. Can use multiple tags separated by , or whitespace",
        ),
        "pusher": attr.label(
            default = "@com_github_bazeltools_rules_minidock//minidock/remote_tools:pusher_app",
            cfg = "host",
            executable = True,
            allow_files = True,
        ),
        "merger": attr.label(
            default = "@com_github_bazeltools_rules_minidock//minidock/remote_tools:merge_app",
            cfg = "host",
            executable = True,
        ),
        "local_cache_path": attr.string(
            default = "/tmp/bzl_docker_cache",
            doc = "Local cache location",
        ),
    },
    executable = True,
    implementation = __container_push_impl,
)
