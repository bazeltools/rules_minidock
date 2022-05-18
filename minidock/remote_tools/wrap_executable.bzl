# When bazel fetches/downloads binaries pre-built elsewhere it won't natively think of them as a binary to itself.
# This rule simply copies things from the input to the output only, but then the output has the runfiles setup to call this an executable.

def _wrap_executable_test_impl(ctx):
    bin_file = ctx.actions.declare_file("bin")
    input_file = ctx.files.executable_path[0]

    ctx.actions.run_shell(
        inputs = depset([input_file]),
        outputs = [bin_file],
        command = "cp {} {} && chmod +x {}".format(input_file.path, bin_file.path, bin_file.path),
        mnemonic = "WrapExecutable",
        progress_message = "WrapExecutable {}".format(ctx.label),
    )

    return [DefaultInfo(
        executable = bin_file,
        files = depset([bin_file]),
        runfiles = ctx.runfiles(files = [bin_file]),
    )]

wrap_executable = rule(
    attrs = {
        "executable_path": attr.label(allow_single_file = True),
    },
    doc = "Wrap a single executable.",
    executable = True,
    implementation = _wrap_executable_test_impl,
)
