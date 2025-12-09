# Bazel Mini Container Image Rules


These rules may not be suitable for you, they are not setup/designed to cover a huge set of use cases. Pull requests to add new features, especially those well factored to keep the core small will be accepted. For a far more broad set of support, and if in doubt, generally use: https://github.com/bazelbuild/rules_docker

## Setup

**Note:** This repository requires Bazel 6.0+ with Bzlmod enabled.

Add the following to your `MODULE.bazel` file:

```python
bazel_dep(name = "rules_minidock", version = "0.1.0")

# Load the minidock tools
minidock_tools = use_extension("@rules_minidock//minidock/remote_tools:extensions.bzl", "minidock_tools")
use_repo(
    minidock_tools,
    "rules_minidock__merge_app_linux_x86_64",
    "rules_minidock__merge_app_macos_aarch64",
    "rules_minidock__merge_app_macos_x86_64",
    "rules_minidock__puller_app",
    "rules_minidock__pusher_app_linux_x86_64",
    "rules_minidock__pusher_app_macos_aarch64",
    "rules_minidock__pusher_app_macos_x86_64",
)
```


### Why these rules?
Less dependencies, there is no need of any other support java/go/rust to use these rules. All tools are pre-built in the `rules_minidock_tools` repo, and are supplied for a few platforms. Generally if these tools don't meet your needs, we aim to have these rules setup so that it should be easy and reasonable to swap out these tools for others as you see fit. That is, primary tooling covers:

1) Fetching metadata about a given upstream tag. We expect to download and expose information from the OCI distribution spec as the starting point
2) Producing compatible compressed gzip data (a python file, using from rules_docker here).
3) Taking the outputs from the structs/providers built up during the build and emitting the OCI manifest, config, and layer information.
4) An uploader which will take the information composed in (3) and upload this to your registry. The implementation today does not support authentication, non-critical features. It is built to aim to copy the layer blobs from (1) if necessary from the source repo to the destination repo.


If you have custom needs, or desires to use internal technology for your company, replacing the tools for (1) and (4) would allow you to drop in anything else here. If some off the shelf application can meet the needs of (4) to limit data transfer then we should move to it instead.


# Future questions, possibilities
- Integration with bazel remote cache technologies so large local layers could be built on a remote server and pushed into the docker registry from there
- Delay/do not fetch any metadata in (1), use this tool (or a user supplied replacement) to run (1), (3) and (4) all as part of the run operation. This will stop the build validating the external state/accuracy of source digests (could change anyway?), but it would mean tools could be built/delivered without repository rules.
- Support local docker daemon building + images into.
- Right now platform + architecture is all limited to linux/amd64. For simplicity and our use case, would accept PR's if anyone wants to increase the coverage here.
- Replace build_tar.py with a pre-built app to not rely on python.
- improve stamping support

## Link to rules_docker
While a lot of the code here has been rewritten for this narrower use case, some code is taken from (Apache Licenced) `rules_docker`. The API's are in no small part inspired from that project also.



# Rules

The dependency configuration in these rules to align containers vs bazel,  has the caveat that overrides occur in the depset order. So the depset of actions will be linearized, and then applied as a stack. With the special carve out that we will only apply one `base` configuration, so we find that first, and apply everything ontop of it.

## external_container_repo
This is the entry point for declaring an external repo, it will fetch the metadata about a remote registry


## container_config
These hooks to allow setting of configuration options such as `CMD`, `ENTRYPOINT` and `ENV`

## container_data
This rule allows you to specify data which should be available as a layer. It allows including tar's, setting permissions on files, and placing files in particular locations in the resulting data.

## container_compose
This allows you to compose several `container_config`, and `container_data` and optionally one `external_container_repo`. These can be then composed by further `container_compose` calls as necessary.

## container_push
This is the rule to exit bazel again. It takes a `container_compose` as an input to describe the computation. It will emit at build time the oci container manfiest, and configuration. If it is invoked with `bazel run` , it will upload it to to the specified registry.