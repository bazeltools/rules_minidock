load("@com_github_bazeltools_rules_minidock//minidock:providers.bzl", "ContainerInfo", "ExternalContainerConfig")


def __copy_provider_with(current, parent):
    if parent == None:
        return current
    else:
        base_lst = [parent]
        base_lst.extend(current.parent_info)
        base_lst.extend(parent.parent_info)

        return struct(
            layer_data = current.layer_data,
            parent_info = base_lst,
            remote_metadata = current.remote_metadata,
            dependencies = depset(transitive = [current.dependencies, parent.dependencies]),
            config = current.config,
        )

def __inner_align_parents(upstream, remaining):
    prev = None
    for nxt in remaining:
        prev = __copy_provider_with(nxt, prev or upstream)
    return prev

def __align_parents(upstream, layers):
    if len(layers) == 0:
        fail("Tried to align an empty list?")
    outer_struct = __inner_align_parents(upstream, layers)
    return ContainerInfo(
        layer_data = outer_struct.layer_data,
        parent_info = outer_struct.parent_info,
        remote_metadata = outer_struct.remote_metadata,
        dependencies = outer_struct.dependencies,
        config = outer_struct.config,
    )

def __container_compose_impl(
        ctx):
    layers = [provider[ContainerInfo] for provider in ctx.attr.layers]
    base_info = ctx.attr.base[ContainerInfo] if ctx.attr.base != None else None
    return [
        __align_parents(base_info, layers),
        ExternalContainerConfig(config = ctx.attr.external_config)
    ]

container_compose = rule(
    attrs = {
        "base": attr.label(
            providers = [ContainerInfo],
            mandatory = False,
            doc = "The base layer for this image, this will override any base configuration set in the layers dependend on if set.",
        ),
        "layers": attr.label_list(
            providers = [ContainerInfo],
        ),
        "external_config": attr.label_list(
            doc = "External config file to be merged with this composition",
            mandatory = False,
            allow_files = True
        )
    },
    implementation = __container_compose_impl,
)
