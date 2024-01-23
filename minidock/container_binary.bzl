load(
    "@com_github_bazeltools_rules_minidock//minidock:container_data.bzl",
    "container_data",
)
load(
    "@com_github_bazeltools_rules_minidock//minidock:container_compose.bzl",
    "container_compose",
)

GROUP_COUNT = 15

def __binary_to_outputs_impl(ctx):
    group_idx = ctx.attr.group_idx

    default_info = ctx.attr.binary[DefaultInfo]
    base_files = default_info.default_runfiles.files.to_list()
    if default_info.files != None:
        base_files.extend(default_info.files.to_list())

    if default_info.files_to_run != None:
        files_to_run = default_info.files_to_run
        if files_to_run.runfiles_manifest != None:
            base_files.append(files_to_run.runfiles_manifest)

    no_jdk = [x for x in base_files if x not in ctx.files._jdk]

    def _shard(x):
        p = x.short_path
        if not p.startswith("../"):
            return 0
        hash_str = p.split("/")[1]
        hash_v = hash(hash_str)
        if hash_v < 0:
            hash_v = hash_v * -1
        hash_v = (hash_v % (GROUP_COUNT - 1)) + 1
        return hash_v

    filtered = depset([x for x in no_jdk if _shard(x) == group_idx])

    return [DefaultInfo(files = filtered)]

__binary_to_outputs = rule(
    attrs = {
        "binary": attr.label(mandatory = True, executable = True, cfg = "target"),
        "group_idx": attr.int(),
        "_jdk": attr.label(
            default = Label("@bazel_tools//tools/jdk:current_java_runtime"),
            providers = [java_common.JavaRuntimeInfo],
        ),
    },
    implementation = __binary_to_outputs_impl,
)

def _launcher_script_impl(ctx):
    template = ctx.attr.app_launch_template.files.to_list()[0]
    exe = ctx.actions.declare_file(
        "%s.files/%s" % (ctx.attr.name, ctx.attr.exe_name),
    )

    ctx.actions.expand_template(
        template = template,
        output = exe,
        substitutions = {
            "%runfiles_path%": ctx.attr.runfiles_path,
            "%exec_path%": ctx.attr.exec_path_path,
        },
        is_executable = True,
    )

    return [
        DefaultInfo(files = depset([exe])),
    ]

launcher_script = rule(
    attrs = {
        "exe_name": attr.string(),
        "exec_path_path": attr.string(),
        "runfiles_path": attr.string(),
        "app_launch_template": attr.label(),
    },
    implementation = _launcher_script_impl,
)

def _binary_data_layers(name, jvm_binary):
    results = []
    for idx in range(0, GROUP_COUNT):
        merge_transformer = "%s.data.transformer%d" % (name, idx)
        layer_data = "%s.data.layer.external.%d" % (name, idx)
        if idx == 0:
            layer_data = "%s.data.layer.%d" % (name, idx)
        __binary_to_outputs(name = merge_transformer, binary = jvm_binary, group_idx = idx)
        container_data(
            name = layer_data,
            files = [merge_transformer],
            gzip_compression_level = 0,
            data_path = "/",
            directory = "/usr/local/data/%s.runfiles/minidock" % (name),
            tags = ["expensive_build", "no-remote-cache"],
        )
        results.append(layer_data)
    return results

def container_binary(
        name,
        binary,
        binary_name = None,
        app_launch_template_script = "@com_github_bazeltools_rules_minidock//minidock:app_launch_template"):
    if binary_name == None:
        binary_name = name
    launcher_name = "%s.launcher" % name
    launcher_data = "%s.launcher.data" % name

    path = binary
    if path.startswith("//"):
        path = path.lstrip("//")
    elif path.startswith(":") or not ("/" in path):
        path = path.lstrip(":")
        path = "%s/%s" % (native.package_name(), path)
    else:
        fail("Don't know how to handle path %s" % path)

    path = path.replace(":", "/")

    data_layers = _binary_data_layers(
        name,
        binary,
    )

    in_container_data_binary = "/usr/local/data/{target_name}.runfiles/minidock/{path}".format(
        path = path,
        target_name = name,
    )

    runfiles_path = "/usr/local/data/%s.runfiles" % name
    launcher_script(
        name = launcher_name,
        exe_name = binary_name,
        exec_path_path = in_container_data_binary,
        runfiles_path = runfiles_path,
        app_launch_template = app_launch_template_script,
    )

    container_data(
        name = launcher_data,
        files = [launcher_name],
        gzip_compression_level = 0,
        directory = "/usr/bin",
        tags = ["expensive_build"],
    )
    container_compose(
        name = name,
        layers = data_layers + [
            launcher_data,
        ],
        tags = ["expensive_build"],
        visibility = ["//visibility:public"],
    )
