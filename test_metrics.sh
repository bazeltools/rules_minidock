#!/bin/bash
# Simple script to demonstrate BUILD_TAR_METRICS functionality

set -e

echo "======================================"
echo "Build Tar Metrics Demo"
echo "======================================"
echo

# Create a temp directory for test files
TMPDIR=$(mktemp -d)
echo "Creating test files in: $TMPDIR"

# Create some test files
echo "Test content 1" > "$TMPDIR/test1.txt"
echo "Test content 2" > "$TMPDIR/test2.txt"
mkdir -p "$TMPDIR/subdir"
echo "Test content 3" > "$TMPDIR/subdir/test3.txt"

OUTPUT_TAR="$TMPDIR/output.tar.gz"

echo
echo "Running build_tar.py WITHOUT metrics..."
echo "--------------------------------------"
python minidock/container_data_tools/build_tar.py \
  --output="$OUTPUT_TAR" \
  --file="$TMPDIR/test1.txt=/app/test1.txt" \
  --file="$TMPDIR/test2.txt=/app/test2.txt" \
  --compression=gz \
  2>&1 | head -5

echo
echo "Build completed. Output size:"
ls -lh "$OUTPUT_TAR"
rm "$OUTPUT_TAR"

echo
echo "======================================"
echo "Now running WITH metrics to stderr..."
echo "======================================"
echo

BUILD_TAR_METRICS=1 python minidock/container_data_tools/build_tar.py \
  --output="$OUTPUT_TAR" \
  --file="$TMPDIR/test1.txt=/app/test1.txt" \
  --file="$TMPDIR/test2.txt=/app/test2.txt" \
  --file="$TMPDIR/subdir/test3.txt=/app/test3.txt" \
  --compression=gz \
  2>&1

echo
echo "Build completed with metrics. Output size:"
ls -lh "$OUTPUT_TAR"
rm "$OUTPUT_TAR"

echo
echo "======================================"
echo "Now running WITH metrics to file..."
echo "======================================"
echo

METRICS_FILE="$TMPDIR/metrics.log"
BUILD_TAR_METRICS=1 python minidock/container_data_tools/build_tar.py \
  --output="$OUTPUT_TAR" \
  --file="$TMPDIR/test1.txt=/app/test1.txt" \
  --file="$TMPDIR/test2.txt=/app/test2.txt" \
  --file="$TMPDIR/subdir/test3.txt=/app/test3.txt" \
  --compression=gz \
  --metrics_output="$METRICS_FILE"

echo
echo "Build completed. Metrics written to file:"
echo "--------------------------------------"
cat "$METRICS_FILE"
echo "--------------------------------------"
echo
echo "Output tar size:"
ls -lh "$OUTPUT_TAR"

# Cleanup
echo
echo "Cleaning up..."
rm -rf "$TMPDIR"

echo
echo "======================================"
echo "Demo complete!"
echo "======================================"
echo
echo "To enable metrics in your builds:"
echo "  export BUILD_TAR_METRICS=1"
echo
echo "Or inline:"
echo "  BUILD_TAR_METRICS=1 bazel build //your:target"

