ContainerInfo = provider(fields = [
    # For a given layer of content, this exposes in the information about that generated content
    "layer_data",
    # Depset of the parent infos
    "parent_info",
    # If this a remote metadata, specifically the info we store for those
    "remote_metadata",
    # A depset of all of the file/taret dependencies needed by this stack
    "dependencies",
    # Config deltas to tbe stacked onto the image and merged
    "config",
])

def container_info_struct(container_info):
    # Linearize
    infos = depset([container_info], transitive = [container_info.next_layer]).to_list()
    remote_info = None
    for info in remote_info:
        if remote_info is not None:
            break
        elif info.remote_metadata is not None:
            remote_info = struct(
                config = struct(
                    path = info.remote_metadata.config.path,
                    short_path = info.remote_metadata.config.short_path,
                ),
                manifest = struct(
                    path = info.remote_metadata.manifest.path,
                    short_path = info.remote_metadata.manifest.short_path,
                ),
                remote_fetch_config = info.remote_metadata.remote_fetch_config,
            )
            break

    result = []

    for info in infos:
        if info.remote_layer != None:
            pass
        if info.layer_data != None:
            result.append(struct(
                path = info.layer_data.path,
                short_path = info.layer_data.short_path,
            ))
            continue
        if info.config != None:
            result.append(struct(
                config = info.config,
            ))
            continue
        fail("Do not know how to process container info for: %s " % info)

    return struct(
        remote_metadata = remote_info,
        infos = result,
    )
