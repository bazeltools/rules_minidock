load("@com_github_bazeltools_rules_minidock//minidock:providers.bzl", "ContainerInfo")

def __expand_env(ctx, env):
    env_lst = None
    if env != None:
        env_lst = []
        for key, value in env.items():
            env_lst.append("%s" % "=".join([
                ctx.expand_make_variables("env", key, {}),
                ctx.expand_make_variables("env", value, {}),
            ]))
    return env_lst

def __container_config__impl(ctx):

    entry_point = ctx.attr.entrypoint
    if len(entry_point) == 1 and entry_point[0] == "rules_minidock_is_unset":
        entry_point = None

    cmd = ctx.attr.cmd
    if len(cmd) == 1 and cmd[0] == "rules_minidock_is_unset":
        cmd = None

    user = ctx.attr.user
    if user == "rules_minidock_is_unset":
        user = None

    workdir = ctx.attr.workdir
    if workdir == "rules_minidock_is_unset":
        workdir = None
    layer_config = struct(
        config = struct(
            Entrypoint = entry_point,
            Cmd = cmd,
            Env = __expand_env(ctx, ctx.attr.env),
            User = user,
            WorkingDir = workdir,
        ),
    )

    return [
        ContainerInfo(
            parent_info = [],
            remote_metadata = None,
            dependencies = depset(),
            layer_data = None,
            config = layer_config,
        ),
    ]

container_config = rule(
    attrs = {
        "cmd": attr.string_list(
            doc = """List of commands to execute in the image.

        See https://docs.docker.com/engine/reference/builder/#cmd

        Cmd @ None -> Ignore and leave as base image
        Cmd @ [] -> Set to empty""",
            mandatory = False,
            default = ["rules_minidock_is_unset"],
        ),
        "entrypoint": attr.string_list(
            doc = """List of entrypoints to add in the image.

        entrypoint @ None -> Ignore and leave as base image
        entrypoint @ [] -> Set to empty""",
            mandatory = False,
            default = ["rules_minidock_is_unset"],
        ),
        "env": attr.string_dict(
            doc = """Environmental variables to set""",
            mandatory = False,
        ),
        "user": attr.string(
            doc = """The user that the image should run as.
        See https://docs.docker.com/engine/reference/builder/#user
        Because building the image never happens inside a Docker container,
        this user does not affect the other actions (e.g., adding files).""",
            default = "rules_minidock_is_unset",
        ),
        "workdir": attr.string(
            doc = """Initial working directory when running the Docker image.
        See https://docs.docker.com/engine/reference/builder/#workdir
        Because building the image never happens inside a Docker container,
        this working directory does not affect the other actions (e.g., adding files).""",
            default = "rules_minidock_is_unset",
        ),
    },
    implementation = __container_config__impl,
)
