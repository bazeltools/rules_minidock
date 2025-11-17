#!/usr/bin/env python3
"""Performance test for build_tar.py gzip streaming improvements.

This test measures the performance difference between:
1. Old approach: Loading entire gzipped data into memory
2. New approach: Streaming gzip decompression with shutil.copyfileobj
"""

import gzip
import io
import os
import shutil
import sys
import tempfile
import time
import unittest
from contextlib import contextmanager

# Add parent directory to path to import build_tar
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'minidock', 'container_data_tools'))
import build_tar


class GzipPerformanceTest(unittest.TestCase):
    """Test performance improvements of streaming gzip decompression."""

    def setUp(self):
        """Create test data of various sizes."""
        self.test_data_sizes = [
            (1024 * 1024, "1MB"),      # 1 MB
            (10 * 1024 * 1024, "10MB"), # 10 MB
            (50 * 1024 * 1024, "50MB"), # 50 MB
        ]

        # Add 1GB test if LARGE_TESTS environment variable is set
        if os.environ.get('LARGE_TESTS', '').lower() in ('1', 'true', 'yes'):
            self.test_data_sizes.append((1024 * 1024 * 1024, "1GB"))
            print("\n[INFO] Including 1GB test (LARGE_TESTS enabled)")

        self.test_data = {}

        # Generate test data and compress it
        for size, label in self.test_data_sizes:
            # Create compressible test data (repeated patterns compress well)
            data = (b"A" * 100 + b"B" * 100 + b"C" * 100) * (size // 300 + 1)
            data = data[:size]

            # Compress with gzip
            compressed = io.BytesIO()
            with gzip.GzipFile(fileobj=compressed, mode='wb') as gz:
                gz.write(data)

            self.test_data[label] = {
                'original_size': len(data),
                'compressed_size': len(compressed.getvalue()),
                'compressed_data': compressed.getvalue(),
                'original_data': data
            }

    @contextmanager
    def write_temp_file_old_approach(self, data, suffix='tar', mode='wb'):
        """Old implementation: loads entire decompressed data into memory."""
        if suffix.endswith('.gz'):
            with gzip.GzipFile(fileobj=io.BytesIO(data)) as f:
                data = f.read()
            suffix = suffix[:-3]

        (_, tmpfile) = tempfile.mkstemp(suffix=suffix)
        try:
            with open(tmpfile, mode=mode) as f:
                f.write(data)
            yield tmpfile
        finally:
            os.remove(tmpfile)

    @contextmanager
    def write_temp_file_new_approach(self, data, suffix='tar', mode='wb'):
        """New implementation: streams decompression with shutil.copyfileobj."""
        if suffix.endswith('.gz'):
            suffix = suffix[:-3]
            (_, tmpfile) = tempfile.mkstemp(suffix=suffix)
            with gzip.GzipFile(fileobj=io.BytesIO(data)) as gz, open(tmpfile, mode=mode) as out:
                shutil.copyfileobj(gz, out)
            yield tmpfile
            os.remove(tmpfile)
            return

    def measure_performance(self, approach_func, data, suffix, iterations=5, size_label=""):
        """Measure time and verify correctness for a given approach."""
        # Use fewer iterations for very large files
        if size_label == "1GB":
            iterations = 3

        times = []

        for _ in range(iterations):
            start = time.perf_counter()
            with approach_func(data, suffix=suffix) as tmpfile:
                # Verify file was created and has correct size
                self.assertTrue(os.path.exists(tmpfile))
                file_size = os.path.getsize(tmpfile)
            end = time.perf_counter()
            times.append(end - start)

        avg_time = sum(times) / len(times)
        min_time = min(times)
        max_time = max(times)

        return {
            'avg_time': avg_time,
            'min_time': min_time,
            'max_time': max_time,
            'file_size': file_size
        }

    def test_gzip_streaming_performance(self):
        """Compare performance of old vs new gzip decompression approach."""
        print("\n" + "=" * 80)
        print("GZIP STREAMING PERFORMANCE TEST")
        print("=" * 80)

        results = {}

        # Test all available sizes (including 1GB if enabled)
        for size_label in self.test_data.keys():
            test_case = self.test_data[size_label]
            compressed_data = test_case['compressed_data']
            original_size = test_case['original_size']
            compressed_size = test_case['compressed_size']

            print(f"\n{size_label} Test Data:")
            print(f"  Original size: {original_size:,} bytes")
            print(f"  Compressed size: {compressed_size:,} bytes")
            print(f"  Compression ratio: {original_size/compressed_size:.2f}x")

            # Test old approach
            print("\n  Old approach (load into memory):")
            old_results = self.measure_performance(
                self.write_temp_file_old_approach,
                compressed_data,
                suffix='tar.gz',
                size_label=size_label
            )
            print(f"    Avg time: {old_results['avg_time']*1000:.2f}ms")
            print(f"    Min time: {old_results['min_time']*1000:.2f}ms")
            print(f"    Max time: {old_results['max_time']*1000:.2f}ms")

            # Test new approach
            print("\n  New approach (streaming):")
            new_results = self.measure_performance(
                self.write_temp_file_new_approach,
                compressed_data,
                suffix='tar.gz',
                size_label=size_label
            )
            print(f"    Avg time: {new_results['avg_time']*1000:.2f}ms")
            print(f"    Min time: {new_results['min_time']*1000:.2f}ms")
            print(f"    Max time: {new_results['max_time']*1000:.2f}ms")

            # Calculate improvement
            improvement = ((old_results['avg_time'] - new_results['avg_time'])
                          / old_results['avg_time'] * 100)
            speedup = old_results['avg_time'] / new_results['avg_time']

            print(f"\n  Performance improvement: {improvement:.1f}%")
            print(f"  Speedup: {speedup:.2f}x")

            results[size_label] = {
                'old': old_results,
                'new': new_results,
                'improvement_pct': improvement,
                'speedup': speedup
            }

            # Verify file sizes match
            self.assertEqual(old_results['file_size'], new_results['file_size'])
            self.assertEqual(old_results['file_size'], original_size)

        print("\n" + "=" * 80)
        print("SUMMARY")
        print("=" * 80)
        for size_label, result in results.items():
            print(f"{size_label}: {result['improvement_pct']:.1f}% faster "
                  f"({result['speedup']:.2f}x speedup)")
        print("=" * 80 + "\n")

    def test_correctness_verification(self):
        """Verify that both approaches produce identical output."""
        print("\n" + "=" * 80)
        print("CORRECTNESS VERIFICATION TEST")
        print("=" * 80)

        # Only verify correctness on smaller files (1GB would be slow)
        test_sizes = [label for label in self.test_data.keys() if label != "1GB"][:2]

        for size_label in test_sizes:
            test_case = self.test_data[size_label]
            compressed_data = test_case['compressed_data']
            original_data = test_case['original_data']

            print(f"\nVerifying {size_label}...")

            # Get output from old approach
            with self.write_temp_file_old_approach(compressed_data, suffix='tar.gz') as tmpfile:
                with open(tmpfile, 'rb') as f:
                    old_output = f.read()

            # Get output from new approach
            with self.write_temp_file_new_approach(compressed_data, suffix='tar.gz') as tmpfile:
                with open(tmpfile, 'rb') as f:
                    new_output = f.read()

            # Verify both match original
            self.assertEqual(old_output, original_data,
                           f"Old approach output doesn't match original for {size_label}")
            self.assertEqual(new_output, original_data,
                           f"New approach output doesn't match original for {size_label}")
            self.assertEqual(old_output, new_output,
                           f"Old and new approaches produce different output for {size_label}")

            print(f"  ✓ Both approaches produce identical {len(original_data):,} byte output")

        print("\n" + "=" * 80 + "\n")

    def test_actual_tarfile_write_temp_file(self):
        """Test the actual TarFile.write_temp_file method implementation."""
        print("\n" + "=" * 80)
        print("TESTING ACTUAL TarFile.write_temp_file METHOD")
        print("=" * 80)

        # Create a TarFile instance
        with tempfile.NamedTemporaryFile(suffix='.tar.gz', delete=False) as output_file:
            output_path = output_file.name

        try:
            tar_file = build_tar.TarFile(
                output=output_path,
                directory='/',
                root_directory='./',
                default_mtime=0,
                enable_mtime_preservation=False,
                force_posixpath=True,
                gzip_compression_level=9,
                compression='gz'
            )

            # Test with 10MB compressed data (.gz suffix)
            test_case = self.test_data['10MB']
            compressed_data = test_case['compressed_data']
            original_data = test_case['original_data']

            print("\nTesting with 10MB compressed data (.gz suffix)...")

            start = time.perf_counter()
            with tar_file.write_temp_file(compressed_data, suffix='tar.gz') as tmpfile:
                with open(tmpfile, 'rb') as f:
                    output = f.read()
            end = time.perf_counter()

            # Verify correctness
            self.assertEqual(output, original_data)
            print(f"  ✓ Decompressed {len(compressed_data):,} bytes to {len(output):,} bytes")
            print(f"  ✓ Time taken: {(end-start)*1000:.2f}ms")
            print(f"  ✓ Output matches original data")

            # Test with non-compressed data (no .gz suffix)
            test_data = b"Hello, World! " * 1000
            print("\nTesting with non-compressed data (no .gz suffix)...")

            start = time.perf_counter()
            with tar_file.write_temp_file(test_data, suffix='tar') as tmpfile:
                with open(tmpfile, 'rb') as f:
                    output = f.read()
            end = time.perf_counter()

            # Verify correctness
            self.assertEqual(output, test_data)
            print(f"  ✓ Wrote {len(test_data):,} bytes directly to temp file")
            print(f"  ✓ Time taken: {(end-start)*1000:.2f}ms")
            print(f"  ✓ Output matches input data")
            print(f"  ✓ Non-gz case works correctly!")

        finally:
            if os.path.exists(output_path):
                os.remove(output_path)

        print("\n" + "=" * 80 + "\n")


if __name__ == '__main__':
    print("""
Performance Test for build_tar.py Gzip Streaming
==================================================

Running standard tests (1MB, 10MB, 50MB)...

To include 1GB test, run:
    LARGE_TESTS=1 python3 tests/test_build_tar_performance.py

""")
    # Run with verbose output
    unittest.main(verbosity=2)
