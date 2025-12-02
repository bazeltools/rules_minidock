# Build Tar Performance Metrics

## Overview

Performance monitoring has been added to `build_tar.py` to help identify bottlenecks and understand where time is being spent during tar file creation.

## Usage

To enable metrics collection, set the `BUILD_TAR_METRICS` environment variable to `1` before running the script:

```bash
export BUILD_TAR_METRICS=1
python minidock/container_data_tools/build_tar.py [your arguments...]
```

Or inline:

```bash
BUILD_TAR_METRICS=1 python minidock/container_data_tools/build_tar.py [your arguments...]
```

### Output Location

By default (when `--metrics_output` is not specified), metrics are written to **stderr**. To write metrics to a dedicated file instead, use the `--metrics_output` parameter:

```bash
BUILD_TAR_METRICS=1 python minidock/container_data_tools/build_tar.py \
  --output=out.tar.gz \
  --file=myfile.txt=/dest/path.txt \
  --metrics_output=metrics.log
```

When `--metrics_output` is specified, all metrics are written exclusively to the specified file (not stderr). This is useful when:
- You want to separate metrics from regular stderr output
- You need to parse metrics programmatically
- You're running in a Bazel build and want to preserve metrics logs as build artifacts

### Using with Bazel (`container_data` rule)

When using the `container_data` rule, you can enable metrics collection by setting the `build_tar_metrics` attribute:

```python
container_data(
    name = "my_layer",
    files = ["file.txt"],
    build_tar_metrics = True,  # Enable performance metrics
)
```

When enabled, the rule will automatically:
- Set the `BUILD_TAR_METRICS=1` environment variable
- Create a `{name}-layer.metrics` output file
- Include the metrics file as a build artifact

To view the metrics after building:

```bash
bazel build //your:my_layer
cat bazel-bin/your/my_layer-layer.metrics
```

**Note:** `build_tar_metrics` defaults to `False`, so metrics are only collected when explicitly enabled for specific targets.

## What Gets Measured

The metrics system tracks timing for:

### Method-level Metrics
- `TarFileWriter.__init__` - Initialization of tar writer
- `TarFileWriter.add_file` - Adding individual files
- `TarFileWriter.add_dir` - Adding directories recursively
- `TarFileWriter.add_tar` - Merging tar files
- `TarFileWriter._addfile` - Internal file addition
- `TarFileWriter.close` - Closing and finalizing tar file
- `TarFile.__init__` - Initialization of TarFile wrapper
- `TarFile.add_file` - Adding files through TarFile wrapper
- `TarFile.add_tar` - Merging tars through TarFile wrapper
- `TarFile.add_empty_file` - Creating empty files
- `TarFile.add_deb` - Adding debian packages
- `TarFile.add_pkg_metadata` - Adding package metadata

### Operation-level Metrics
- `zstd_compression` - Time spent in zstd compression
- `xz_compression` - Time spent in xz compression
- `process_manifest` - Time spent processing manifest files
- `process_files` - Time spent processing individual files
- `process_tars` - Time spent processing tar files

## Output Format

When `BUILD_TAR_METRICS=1` is set, metrics are logged in real-time as operations complete. The output destination depends on whether `--metrics_output` is specified:
- **Without `--metrics_output`**: Metrics are written to stderr
- **With `--metrics_output`**: Metrics are written to the specified file

Example output format:

```
[BUILD_TAR_METRIC] TarFile.__init__: 0.0023s
[BUILD_TAR_METRIC] TarFile.add_file: 0.0145s
[BUILD_TAR_METRIC] TarFileWriter.add_file: 0.0142s
...
```

At the end of execution, a summary table is printed:

```
[BUILD_TAR_METRIC] ================================================================================
[BUILD_TAR_METRIC] PERFORMANCE SUMMARY
[BUILD_TAR_METRIC] ================================================================================
[BUILD_TAR_METRIC] Operation                                              Count   Total(s)     Avg(s)     Min(s)     Max(s)
[BUILD_TAR_METRIC] --------------------------------------------------------------------------------
[BUILD_TAR_METRIC] zstd_compression                                           1     5.2341     5.2341     5.2341     5.2341
[BUILD_TAR_METRIC] TarFileWriter.close                                        1     5.2456     5.2456     5.2456     5.2456
[BUILD_TAR_METRIC] TarFileWriter.add_tar                                      3     1.2345     0.4115     0.2100     0.6200
[BUILD_TAR_METRIC] TarFile.add_file                                          42     0.5234     0.0125     0.0010     0.0450
[BUILD_TAR_METRIC] Total execution time: 7.1234s
[BUILD_TAR_METRIC] ================================================================================
```

## Interpreting Results

- **Count**: Number of times the operation was called
- **Total(s)**: Total cumulative time spent in that operation
- **Avg(s)**: Average time per call
- **Min(s)**: Fastest call
- **Max(s)**: Slowest call

The summary is sorted by total time (descending), so the most expensive operations appear first.

## Example

```bash
# Run with metrics enabled (output to stderr by default)
BUILD_TAR_METRICS=1 bazel build //your:target 2>&1 | grep BUILD_TAR_METRIC

# Or if running the script directly with stderr output
BUILD_TAR_METRICS=1 python minidock/container_data_tools/build_tar.py \
  --output=out.tar.gz \
  --file=myfile.txt=/dest/path.txt \
  --compression=gz \
  2>&1 | tee metrics.log

# Run with metrics output to a dedicated file (not stderr)
BUILD_TAR_METRICS=1 python minidock/container_data_tools/build_tar.py \
  --output=out.tar.gz \
  --file=myfile.txt=/dest/path.txt \
  --compression=gz \
  --metrics_output=build_metrics.log

# Then view the metrics file
cat build_metrics.log
```

## Tips for Performance Analysis

1. **Look at Total Time First**: The operations with the highest total time are your main bottlenecks
2. **Check Call Counts**: High call counts with low individual times can add up
3. **Compression**: If compression times dominate, consider:
   - Using lower compression levels (`--zstd_compression_level` or `--gzip_compression_level`)
   - Using faster compression (gz is faster than zstd, which is faster than xz)
4. **File Operations**: If `add_file` operations dominate, you may have many small files that could be batched differently

## Performance Overhead

The timing decorators add minimal overhead (microseconds per call). The metrics are only collected when `BUILD_TAR_METRICS=1` is set, so there's no performance impact in production use.

