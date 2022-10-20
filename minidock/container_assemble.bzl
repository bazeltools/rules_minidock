load("@com_github_bazeltools_rules_minidock//minidock:providers.bzl", "ContainerInfo", "ManifestResult", "AssembledData", "container_info_struct")


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

exec {tool} --pusher-config {config_file_path} --cache-path {local_cache_path} {verbose_str} "$@"
"""

def __container_assemble_impl(ctx):

    composed = ctx.attr.composed[ContainerInfo]
    composed_transitive_deps = composed.dependencies

    merger_config_output = ctx.actions.declare_file("%s_merger_config.json" % ctx.attr.name)
    merger_manifest_output = ctx.actions.declare_file("%s_merger_manifest.json" % ctx.attr.name)
    merger_upload_metadata_output = ctx.actions.declare_file("%s_merger_upload_metadata.json" % ctx.attr.name)
    merger_manifest_sha256_output = ctx.actions.declare_file("%s_sha256.txt" % ctx.attr.name)

    merger_config_file = ctx.actions.declare_file("%s_merger_config_file.json" % ctx.attr.name)
    ctx.actions.write(merger_config_file, json.encode(container_info_struct(composed)))

    merger_args = ctx.actions.args()
    merger_args.add("--merger-config-path").add(merger_config_file)
    merger_args.add("--manifest-path").add(merger_manifest_output.path)
    merger_args.add("--manifest-sha256-path").add(merger_manifest_sha256_output.path)
    merger_args.add("--upload-metadata-path").add(merger_upload_metadata_output.path)
    merger_args.add("--config-path").add(merger_config_output.path)

    merger_input = depset([merger_config_file], transitive = [composed_transitive_deps])
    ctx.actions.run(
        inputs = merger_input,
        outputs = [merger_config_output, merger_manifest_output, merger_upload_metadata_output, merger_manifest_sha256_output],
        arguments = [merger_args],
        executable = ctx.executable.merger,
    )

    return [
        AssembledData(
        manifest = merger_manifest_output,
        config = merger_config_output,
        upload_metadata = merger_upload_metadata_output,
        dependencies = depset([merger_manifest_output, merger_config_output, merger_upload_metadata_output], transitive = [merger_input])
    ),
    DefaultInfo(
            files = depset([merger_manifest_output]),
        )
    ]

container_assemble = rule(
    attrs = {
        "composed": attr.label(
            providers = [ContainerInfo],
            mandatory = True,
            doc = "The label of the image to push.",
        ),
        "merger": attr.label(
            default = "@com_github_bazeltools_rules_minidock//minidock/remote_tools:merge_app",
            cfg = "host",
            executable = True,
        ),
    },
    implementation = __container_assemble_impl,
)
