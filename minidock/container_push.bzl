load("@com_github_bazeltools_rules_minidock//minidock:providers.bzl", "AssembledData")


launcher_template = """
#!/bin/bash

function guess_runfiles() {{
    if [ -d ${{BASH_SOURCE[0]}}.runfiles ]; then
 # Runfiles are adjacent to the current script.
        echo "$( cd ${{BASH_SOURCE[0]}}.runfiles && pwd )"
    else
        # The current script is within some other script's runfiles.
        mydir="$( cd "$( dirname "${{BASH_SOURCE[0]}}" )" && pwd )"
        echo $mydir | sed -e 's/\\.runfiles\\/.*/.runfiles/'
    fi
}}

set -euo pipefail

# We never use anything from the original CWD, so move to the runfiles location if not there.
GEN_RUNFILES="$(guess_runfiles)"
if [ -n "$GEN_RUNFILES" ]; then
    cd $GEN_RUNFILES
    cd {workspace_name}
fi

exec {tool} --pusher-config {config_file_path} --cache-path {local_cache_path} {verbose_str} {auth_helper} "$@"
"""

def __container_push_impl(ctx):
    merger_input = []

    assembled = ctx.attr.assembled[AssembledData]

    registry_list = []
    if ctx.attr.registry != None and ctx.attr.registry != "":
        registry_list.append(ctx.attr.registry)

    for reg in ctx.attr.registry_list:
        if len(reg) == 0:
            fail("Passed an invalid registry, was an empty string")
        registry_list.append(reg)

    if len(registry_list) == 0:
        fail("Need to supply at least one of registry or registry_list")


    repository = ctx.expand_make_variables("repository", ctx.attr.repository, {})
    container_tags = ctx.attr.container_tags
    container_tag_file = None
    pusher_input = []

    # If a tag file is provided, override <tag> with tag value
    if ctx.file.container_tag_file:
        container_tag_file = ctx.file.container_tag_file.short_path
        pusher_input.append(ctx.file.container_tag_file)

    pusher_config = struct(
        manifest_path = assembled.manifest.short_path,
        config_path = assembled.config.short_path,
        upload_metadata_path = assembled.upload_metadata.short_path,
        registry_list = registry_list,
        repository = repository,
        container_tags = container_tags,
        registry_type = ctx.attr.registry_format,
        container_tag_file = container_tag_file,
        stamp_info_file = ctx.info_file.short_path,
        stamp_to_env = ctx.attr.stamp_to_env
    )

    pusher_config_file = ctx.actions.declare_file("%s_pusher_config.json" % ctx.attr.name)
    ctx.actions.write(pusher_config_file, json.encode(pusher_config))

    pusher_runfiles = [ctx.executable.pusher, pusher_config_file, ctx.info_file] + pusher_input
    runfiles = ctx.runfiles(files = pusher_runfiles, transitive_files = assembled.dependencies)
    runfiles = runfiles.merge(ctx.attr.pusher[DefaultInfo].default_runfiles)

    exe = ctx.actions.declare_file(ctx.label.name)

    verbose_str = ""
    if ctx.attr.pusher_verbose:
        verbose_str = "--verbose"

    auth_helper_arg = ""
    if ctx.executable.authentication_helper:
        helper_arg = ",".join(["%s:%s" % (reg, ctx.executable.authentication_helper.short_path) for reg in registry_list])
        auth_helper_arg =  "--docker-authorization-helpers %s" % (helper_arg)
        runfiles = runfiles.merge(ctx.attr.authentication_helper[DefaultInfo].default_runfiles)

    ctx.actions.write(
        exe,
        launcher_template.format(
            workspace_name = ctx.workspace_name,
            tool = ctx.executable.pusher.short_path,
            config_file_path = pusher_config_file.short_path,
            local_cache_path = ctx.attr.local_cache_path,
            verbose_str = verbose_str,
            auth_helper = auth_helper_arg
        ),
        is_executable = True,
    )
    return [
        DefaultInfo(
            executable = exe,
            runfiles = runfiles,
        )
    ]

container_push = rule(
    attrs = {
        "assembled": attr.label(
            providers = [AssembledData],
            mandatory = True,
            doc = "The assembled data to push.",
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
            mandatory = False,
            doc = "The registry to which we are pushing.",
        ),
        "registry_list": attr.string_list(
            mandatory = False,
            doc = "Extra registries to push to, where its the same repository.",
            default = []
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
        "authentication_helper": attr.label(
            cfg = "host",
            executable = True,
            allow_files = True,
            mandatory = False
        ),
        "pusher_verbose": attr.bool(
            default = False,
        ),
        "stamp_to_env": attr.bool(
            default = True,
            mandatory = False
        ),
        "local_cache_path": attr.string(
            default = "/tmp/bzl_docker_cache",
            doc = "Local cache location",
        ),
    },
    executable = True,
    implementation = __container_push_impl,
)
