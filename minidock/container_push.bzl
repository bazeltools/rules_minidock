load("@com_github_bazeltools_rules_minidock//minidock:providers.bzl", "ContainerInfo", "container_info_struct")
load("@io_bazel_rules_docker//container:providers.bzl", "PushInfo", "STAMP_ATTR", "StampSettingInfo")
load(
    "//skylib:path.bzl",
    "runfile",
)

launcher_template = """
#!/bin/bash

set -euo pipefail

export INVOKE_ROOT="\\$PWD"

exec {tool} {config_file_path} "\\$@"
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
        inputs = depset(merger_input, transitive = []),
        outputs = [configured_data],
        arguments = [merger_args],
        executable = ctx.executable._merger,
    )

    registry = ctx.expand_make_variables("registry", ctx.attr.registry, {})
    repository = ctx.expand_make_variables("repository", ctx.attr.repository, {})
    tag = ctx.expand_make_variables("tag", ctx.attr.tag, {})
    tag_file = None
    pusher_input = []

    # If a tag file is provided, override <tag> with tag value
    if ctx.file.tag_file:
        tag = None
        tag_file = ctx.file.tag_file.short_path
        pusher_input.append(ctx.file.tag_file)

    pusher_config = struct(
        merger_data = configured_data.short_path,
        registry = registry,
        repository = repository,
        tag = tag,
        tag_file = tag_file,
    )

    pusher_config_file = ctx.actions.declare_file("%s_pusher_config.json" % ctx.attr.name)
    ctx.actions.write(pusher_config_file, json.encode(pusher_config))

    pusher_runfiles = [ctx.executable._pusher, configured_data] + merger_input + pusher_input
    runfiles = ctx.runfiles(files = pusher_runfiles, transitive_files = composed_transitive_deps)
    runfiles = runfiles.merge(ctx.attr._pusher[DefaultInfo].default_runfiles)

    exe = ctx.actions.declare_file(ctx.label.name)

    ctx.actions.write(
        exe,
        launcher_template.format(
            tool = ctx.executable._pusher.short_path,
            config_file_path = pusher_config_file.short_path,
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
    attrs = dicts.add({
        "composed": attr.label(
            providers = [ContainerInfo],
            mandatory = True,
            doc = "The label of the image to push.",
        ),
        "registry": attr.string(
            mandatory = True,
            doc = "The registry to which we are pushing.",
        ),
        "repository": attr.string(
            mandatory = True,
            doc = "The name of the image.",
        ),
        "stamp": STAMP_ATTR,
        "tag": attr.string(
            default = "latest",
            doc = "The tag of the image.",
        ),
        "tag_file": attr.label(
            allow_single_file = True,
            doc = "The label of the file with tag value. Overrides 'tag'.",
        ),
        "_pusher": attr.label(
            default = "//container/go/cmd/pusher",
            cfg = "host",
            executable = True,
            allow_files = True,
        ),
        "_merger": attr.label(
            default = "//container:merger",
            cfg = "host",
            executable = True,
        ),
    }),
    executable = True,
    implementation = __container_push_impl,
)
