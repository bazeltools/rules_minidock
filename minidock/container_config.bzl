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
    layer_config = struct(
        config = struct(
            entrypoint = ctx.attr.entrypoint,
            cmd = ctx.attr.cmd,
            env = __expand_env(ctx, ctx.attr.env),
            user = ctx.attr.user,
            workdir = ctx.attr.workdir,
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
        Cmd @ [] -> Set to empty

        This field supports stamp variables.""",
            mandatory = False,
        ),
        "entrypoint": attr.string_list(
            doc = """List of entrypoints to add in the image.

        entrypoint @ None -> Ignore and leave as base image
        entrypoint @ [] -> Set to empty

        This field supports stamp variables.""",
            mandatory = False,
        ),
        "layers": attr.label_list(
            doc = """List of `container_layer` targets.

        The data from each `container_layer` will be part of container image,
        and the environment variable will be available in the image as well.""",
            providers = [LayerInfo],
        ),
        "user": attr.string(
            doc = """The user that the image should run as.
        See https://docs.docker.com/engine/reference/builder/#user
        Because building the image never happens inside a Docker container,
        this user does not affect the other actions (e.g., adding files).
        This field supports stamp variables.""",
        ),
        "workdir": attr.string(
            doc = """Initial working directory when running the Docker image.

        See https://docs.docker.com/engine/reference/builder/#workdir

        Because building the image never happens inside a Docker container,
        this working directory does not affect the other actions (e.g., adding files).

        This field supports stamp variables.""",
        ),
    },
    implementation = __container_config__impl,
)
