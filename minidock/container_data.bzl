load("@com_github_bazeltools_rules_minidock//minidock:providers.bzl", "ContainerInfo")

# This is currently whats used in rules_docker, evaluate if we should change it?
# We have no legacy needs to support.
def _magic_path(ctx, f, output_layer):
    # Right now the logic this uses is a bit crazy/buggy, so to support
    # bug-for-bug compatibility in the foo_image rules, expose the logic.
    # See also: https://github.com/bazelbuild/rules_docker/issues/106
    # See also: https://groups.google.com/forum/#!topic/bazel-discuss/1lX3aiTZX3Y

    if ctx.attr.data_path:
        # If data_prefix is specified, then add files relative to that.
        data_path = _join_path(
            dirname(output_layer.short_path),
            _canonicalize_path(ctx.attr.data_path),
        )

        # data path get get calculated incorrectly for external repo
        if data_path.startswith("/.."):
            data_path = data_path[1:]
        return strip_prefix(f.short_path, data_path)
    else:
        # Otherwise, files are added without a directory prefix at all.
        return f.basename

def __container_data_impl(
        ctx):
    layer = ctx.actions.declare_file("%s.tgz" % ctx.name)

    files = ctx.files.files
    args = ctx.actions.args()
    args.add(layer, format = "--output=%s")
    args.add(ctx.attr.directory, format = "--directory=%s")
    args.add(ctx.attr.mode, format = "--mode=%s")

    all_files = [struct(src = f.path, dst = _magic_path(ctx, f, layer)) for f in files]
    manifest = struct(
        files = all_files,
        symlinks = [struct(linkname = k, target = ctx.attr.symlinks[k]) for k in ctx.attr.symlinks],
        empty_files = ctx.attr.empty_files or [],
        empty_dirs = ctx.attr.empty_dirs or [],
        tars = [f.path for f in ctx.files.tars],
    )
    manifest_file = ctx.actions.declare_file(name + "-layer.manifest")
    ctx.actions.write(manifest_file, manifest.to_json())
    args.add(manifest_file, format = "--manifest=%s")

    ctx.actions.run(
        executable = ctx.executable._build_tar,
        arguments = [args],
        inputs = ctx.files.tars + [manifest_file] + files,
        outputs = [layer],
        use_default_shell_env = True,
        mnemonic = "ContainerData",
    )
    return [ContainerInfo(
        parent_info = depset(),
        remote_metadata = None,
        dependencies = depset([layer]),
        layer_data = layer,
        config = None,
    )]

container_layer = rule(
    attrs = {
        "_build_tar": attr.label(
            default = Label("@//minidock/container_data_tools:build_tar"),
            cfg = "host",
            executable = True,
        ),
        "data_path": attr.string(
            doc = """Root path of the files.

        The directory structure from the files is preserved inside the
        Docker image, but a prefix path determined by `data_path`
        is removed from the directory structure. This path can
        be absolute from the workspace root if starting with a `/` or
        relative to the rule's directory. A relative path may starts with "./"
        (or be ".") but cannot use go up with "..". By default, the
        `data_path` attribute is unused, and all files should have no prefix.
        """,
        ),
        "directory": attr.string(
            default = "/",
            doc = """Target directory.

        The directory in which to expand the specified files, defaulting to '/'.
        Only makes sense accompanying one of files/tars/debs.""",
        ),
        "empty_dirs": attr.string_list(),
        "empty_files": attr.string_list(),
        "files": attr.label_list(
            allow_files = True,
            doc = """File to add to the layer.

        A list of files that should be included in the Docker image.""",
        ),
        "mode": attr.string(
            default = "0o555",  # 0o555 == a+rx
            doc = "Set the mode of files added by the `files` attribute.",
        ),
        "symlinks": attr.string_dict(
            doc = """Symlinks to create in the Docker image.

        For example,

            symlinks = {
                "/path/to/link": "/path/to/target",
                ...
            },
        """,
        ),
        "tars": attr.label_list(
            allow_files = [".tar", ".tar.gz", ".tgz"],
            doc = """Tar file to extract in the layer.

        A list of tar files whose content should be in the Docker image.""",
        ),
    },
    implementation = __container_data_impl,
)
