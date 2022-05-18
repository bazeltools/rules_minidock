build_file_template = """
load("@com_github_bazeltools_rules_minidock//minidock/remote_tools:wrap_executable.bzl", "wrap_executable")
exports_files(["exe"])
wrap_executable(
    name = "{name}",
    executable_path = "{executable_path}",
    visibility = ["//visibility:public"],
)
"""

# Taken from rules go, modified
def _detect_host_platform(ctx):
    if ctx.os.name == "linux":
        os, arch = "linux", "x86_64"
        res = ctx.execute(["uname", "-p"])
        if res.return_code == 0:
            uname = res.stdout.strip()
            if uname == "s390x":
                arch = "s390x"
            elif uname == "i686":
                arch = "386"

        # uname -p is not working on Aarch64 boards
        # or for ppc64le on some distros
        res = ctx.execute(["uname", "-m"])
        if res.return_code == 0:
            uname = res.stdout.strip()
            if uname == "aarch64":
                arch = "arm64"
            elif uname == "armv6l":
                arch = "arm"
            elif uname == "armv7l":
                arch = "arm"
            elif uname == "ppc64le":
                arch = "ppc64le"

        # Default to amd64 when uname doesn't return a known value.

    elif ctx.os.name == "mac os x":
        os, arch = "macos", "x86_64"

        res = ctx.execute(["uname", "-m"])
        if res.return_code == 0:
            uname = res.stdout.strip()
            if uname == "arm64":
                arch = "aarch64"

    else:
        fail("Unsupported operating system: " + ctx.os.name)
    return os, arch


def _repo_rule_load_tool_impl(ctx):
    """Implementation of the repo_rule_load_tool rule."""

    os, arch = _detect_host_platform(ctx)
    data_map = ctx.attr.platform_to_sha_pairs


    map_key = "%s__%s" % (os, arch)

    if map_key not in data_map:
        fail("Unable to find entry in configuration map for os: %s, and arch: %s -- key: %s", os, arch, map_key)

    cur_platform = data_map[map_key]

    if len(cur_platform) < 2:
        fail("Not enough entries in platform config, need a sha256 and at least 1 url")

    sha256 = cur_platform[0]
    urls = cur_platform[1:]

    ctx.file("WORKSPACE", "workspace(name = \"{name}\")\n".format(name = ctx.name))

    target_file_name = "exe"
    ctx.file("BUILD.bazel", build_file_template.format(name = "bin", executable_path = target_file_name))

    ctx.download(
        url = urls,
        output = target_file_name,
        sha256 = sha256,
        executable = True,
    )


repo_rule_load_tool = repository_rule(
    implementation = _repo_rule_load_tool_impl,
    attrs = {
    "platform_to_sha_pairs": attr.string_list_dict(allow_empty=False, doc = 'This is to pass through a map of os:arch -> [sha256,urls]')
    },
)
