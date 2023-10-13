AssembledData = provider(fields = [
    # a file
    "manifest",
    # File with the sha256 of the manifest
    "manifest_sha256",
    # a file
    "config",
    # a file
    "upload_metadata",
    #a depset
    "dependencies"
])


ManifestResult = provider(fields = [
    # depset of manifest
    "manifest",
])

ContainerInfo = provider(fields = [
    # For a given layer of content, this exposes in the information about that generated content
    "layer_data",
    # List of the parent infos
    "parent_info",
    # If this a remote metadata, specifically the info we store for those
    "remote_metadata",
    # A depset of all of the file/taret dependencies needed by this stack
    "dependencies",
    # Config deltas to be stacked onto the image and merged
    "config",
])

ExternalContainerConfig = provider(fields = [
    # A target to an external config file that we can merge with
    # all other config layers
    "config"
])

def container_info_struct(container_info):
    # Building a struct of both our rule-provided info and the parent info
    # to pass to the merger app

    # Linearize
    infos = [container_info]
    infos.extend(container_info.parent_info)
    remote_info = None
    for info in infos:
        if info.remote_metadata != None:
            remote_info = struct(
                config = struct(
                    path = info.remote_metadata.config.path,
                    short_path = info.remote_metadata.config.short_path,
                ),
                manifest = struct(
                    path = info.remote_metadata.manifest.path,
                    short_path = info.remote_metadata.manifest.short_path,
                ),
                registry = info.remote_metadata.registry,
                repository = info.remote_metadata.repository,
                digest = info.remote_metadata.digest,
            )
            break

    result = []

    for info in infos:
        if info.layer_data != None:
            result.append(
                struct(data = struct(path = info.layer_data.path,
                                     short_path = info.layer_data.short_path,
            )))
        elif info.config != None:
            result.append(struct(
                config = info.config,
            ))
        elif info.remote_metadata != None:
            # Ignoring remote metadata
            pass
        else:
            fail("Do not know how to process container info for: %s " % info)

    return struct(
        remote_metadata = remote_info,
        infos = result,
    )
