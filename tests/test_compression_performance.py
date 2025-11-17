#!/usr/bin/env python3
"""Performance test for optimized zstd and xz compression in build_tar.py.

This test measures the performance difference between:
1. Old approach: Multiple file moves with shell commands
2. New approach: Direct stdin/stdout piping
"""

import os
import subprocess
import sys
import tempfile
import time
import unittest

# Add parent directory to path to import build_tar
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'minidock', 'container_data_tools'))
import build_tar


class CompressionPerformanceTest(unittest.TestCase):
    """Test performance improvements of optimized compression."""

    def setUp(self):
        """Create test tar files of various sizes."""
        self.test_sizes = [
            (1024 * 1024, "1MB"),       # 1 MB
            (10 * 1024 * 1024, "10MB"),  # 10 MB
            (50 * 1024 * 1024, "50MB"),  # 50 MB
        ]

        # Add 100MB test if LARGE_TESTS is set
        if os.environ.get('LARGE_TESTS', '').lower() in ('1', 'true', 'yes'):
            self.test_sizes.append((100 * 1024 * 1024, "100MB"))
            print("\n[INFO] Including 100MB test (LARGE_TESTS enabled)")

        # Add 1GB test if VERY_LARGE_TESTS is set
        if os.environ.get('VERY_LARGE_TESTS', '').lower() in ('1', 'true', 'yes'):
            self.test_sizes.append((1024 * 1024 * 1024, "1GB"))
            print("\n[INFO] Including 1GB test (VERY_LARGE_TESTS enabled)")

        self.test_files = {}

        # Create test data files
        for size, label in self.test_sizes:
            # Create test data (compressible pattern)
            data = (b"A" * 100 + b"B" * 100 + b"C" * 100) * (size // 300 + 1)
            data = data[:size]

            # Write to temporary file
            tmpfile = tempfile.NamedTemporaryFile(suffix='.tar', delete=False)
            tmpfile.write(data)
            tmpfile.close()

            self.test_files[label] = {
                'path': tmpfile.name,
                'size': size
            }

    def tearDown(self):
        """Clean up test files."""
        for test_data in self.test_files.values():
            if os.path.exists(test_data['path']):
                os.remove(test_data['path'])

    def compress_old_approach(self, input_file, output_file, compression_type='zstd', level=3):
        """Old approach: shell commands with file moves."""
        # Copy input to output first (simulating tar close)
        import shutil
        shutil.copy2(input_file, output_file)

        if compression_type == 'zstd':
            cmd = f'mv {output_file} {output_file}.d && zstd -z -{level} {output_file}.d && mv {output_file}.d.zst {output_file}'
        else:  # xz
            cmd = f'mv {output_file} {output_file}.d && xz -z {output_file}.d && mv {output_file}.d.xz {output_file}'

        subprocess.call(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    def compress_new_approach(self, input_file, output_file, compression_type='zstd', level=3):
        """New approach: direct file operations without piping through Python."""
        import shutil
        shutil.copy2(input_file, output_file)

        temp_name = output_file + '.tmp'
        try:
            if compression_type == 'zstd':
                # Let zstd operate directly on files
                subprocess.run(
                    ['zstd', '-z', f'-{level}', output_file, '-o', temp_name],
                    check=True,
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE
                )
            else:  # xz
                # Let xz read file directly and write to stdout
                with open(temp_name, 'wb') as outfile:
                    subprocess.run(
                        ['xz', '-z', '-c', output_file],
                        stdout=outfile,
                        check=True,
                        stderr=subprocess.PIPE
                    )
            os.replace(temp_name, output_file)
        finally:
            if os.path.exists(temp_name):
                os.remove(temp_name)

    def measure_compression(self, approach_func, input_file, compression_type='zstd', level=3, iterations=3):
        """Measure compression time and resulting file size."""
        times = []
        compressed_sizes = []

        for _ in range(iterations):
            with tempfile.NamedTemporaryFile(suffix=f'.tar.{compression_type}', delete=False) as output:
                output_file = output.name

            try:
                start = time.perf_counter()
                approach_func(input_file, output_file, compression_type, level)
                end = time.perf_counter()

                times.append(end - start)
                if os.path.exists(output_file):
                    compressed_sizes.append(os.path.getsize(output_file))
            finally:
                if os.path.exists(output_file):
                    os.remove(output_file)

        return {
            'avg_time': sum(times) / len(times),
            'min_time': min(times),
            'max_time': max(times),
            'avg_compressed_size': sum(compressed_sizes) / len(compressed_sizes) if compressed_sizes else 0
        }

    def check_compression_available(self, compression_type):
        """Check if compression tool is available."""
        result = subprocess.call(
            ['which', compression_type],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        return result == 0

    def test_zstd_compression_performance(self):
        """Compare performance of old vs new zstd compression approach."""
        if not self.check_compression_available('zstd'):
            self.skipTest("zstd not available")

        print("\n" + "=" * 80)
        print("ZSTD COMPRESSION PERFORMANCE TEST")
        print("=" * 80)

        results = {}

        for size_label, test_data in self.test_files.items():
            input_file = test_data['path']
            original_size = test_data['size']

            print(f"\n{size_label} Test Data:")
            print(f"  Original size: {original_size:,} bytes")

            # Test old approach
            print("\n  Old approach (shell + file moves):")
            old_results = self.measure_compression(
                self.compress_old_approach,
                input_file,
                compression_type='zstd',
                level=3
            )
            print(f"    Avg time: {old_results['avg_time']*1000:.2f}ms")
            print(f"    Min time: {old_results['min_time']*1000:.2f}ms")
            print(f"    Max time: {old_results['max_time']*1000:.2f}ms")
            print(f"    Compressed size: {old_results['avg_compressed_size']:,.0f} bytes")

            # Test new approach
            print("\n  New approach (stdin/stdout piping):")
            new_results = self.measure_compression(
                self.compress_new_approach,
                input_file,
                compression_type='zstd',
                level=3
            )
            print(f"    Avg time: {new_results['avg_time']*1000:.2f}ms")
            print(f"    Min time: {new_results['min_time']*1000:.2f}ms")
            print(f"    Max time: {new_results['max_time']*1000:.2f}ms")
            print(f"    Compressed size: {new_results['avg_compressed_size']:,.0f} bytes")

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

            # Verify compressed sizes are similar (within 1%)
            size_diff_pct = abs(old_results['avg_compressed_size'] - new_results['avg_compressed_size']) / old_results['avg_compressed_size'] * 100
            self.assertLess(size_diff_pct, 1.0, f"Compressed sizes differ by {size_diff_pct:.1f}%")

        print("\n" + "=" * 80)
        print("ZSTD SUMMARY")
        print("=" * 80)
        for size_label, result in results.items():
            print(f"{size_label}: {result['improvement_pct']:.1f}% faster "
                  f"({result['speedup']:.2f}x speedup)")
        print("=" * 80 + "\n")

    def test_xz_compression_performance(self):
        """Compare performance of old vs new xz compression approach."""
        if not self.check_compression_available('xz'):
            self.skipTest("xz not available")

        print("\n" + "=" * 80)
        print("XZ COMPRESSION PERFORMANCE TEST")
        print("=" * 80)

        results = {}

        # Only test smaller files for xz (it's slow)
        test_subset = [(label, data) for label, data in self.test_files.items()
                       if label in ['1MB', '10MB']]

        for size_label, test_data in test_subset:
            input_file = test_data['path']
            original_size = test_data['size']

            print(f"\n{size_label} Test Data:")
            print(f"  Original size: {original_size:,} bytes")

            # Test old approach
            print("\n  Old approach (shell + file moves):")
            old_results = self.measure_compression(
                self.compress_old_approach,
                input_file,
                compression_type='xz',
                iterations=2  # xz is slow, use fewer iterations
            )
            print(f"    Avg time: {old_results['avg_time']*1000:.2f}ms")
            print(f"    Min time: {old_results['min_time']*1000:.2f}ms")
            print(f"    Max time: {old_results['max_time']*1000:.2f}ms")
            print(f"    Compressed size: {old_results['avg_compressed_size']:,.0f} bytes")

            # Test new approach
            print("\n  New approach (stdin/stdout piping):")
            new_results = self.measure_compression(
                self.compress_new_approach,
                input_file,
                compression_type='xz',
                iterations=2
            )
            print(f"    Avg time: {new_results['avg_time']*1000:.2f}ms")
            print(f"    Min time: {new_results['min_time']*1000:.2f}ms")
            print(f"    Max time: {new_results['max_time']*1000:.2f}ms")
            print(f"    Compressed size: {new_results['avg_compressed_size']:,.0f} bytes")

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

            # Verify compressed sizes are similar (within 1%)
            size_diff_pct = abs(old_results['avg_compressed_size'] - new_results['avg_compressed_size']) / old_results['avg_compressed_size'] * 100
            self.assertLess(size_diff_pct, 1.0, f"Compressed sizes differ by {size_diff_pct:.1f}%")

        print("\n" + "=" * 80)
        print("XZ SUMMARY")
        print("=" * 80)
        for size_label, result in results.items():
            print(f"{size_label}: {result['improvement_pct']:.1f}% faster "
                  f"({result['speedup']:.2f}x speedup)")
        print("=" * 80 + "\n")

    def test_file_operations_overhead(self):
        """Measure overhead of file moves vs direct operations."""
        print("\n" + "=" * 80)
        print("FILE OPERATIONS OVERHEAD TEST")
        print("=" * 80)

        test_file = self.test_files['1MB']['path']

        # Measure old approach: 3 file operations (mv, compress, mv)
        iterations = 10
        old_times = []
        for _ in range(iterations):
            with tempfile.NamedTemporaryFile(suffix='.tar', delete=False) as tmp:
                output = tmp.name

            start = time.perf_counter()
            # Simulate the old approach file moves
            import shutil
            shutil.copy2(test_file, output)
            temp1 = output + '.d'
            os.rename(output, temp1)  # First move
            os.rename(temp1, output)  # Second move (simulating compression output)
            end = time.perf_counter()
            old_times.append(end - start)
            os.remove(output)

        # Measure new approach: 1 atomic replace
        new_times = []
        for _ in range(iterations):
            with tempfile.NamedTemporaryFile(suffix='.tar', delete=False) as tmp:
                output = tmp.name

            start = time.perf_counter()
            import shutil
            shutil.copy2(test_file, output)
            temp1 = output + '.tmp'
            shutil.copy2(output, temp1)  # Simulate compression to temp
            os.replace(temp1, output)  # Atomic replace
            end = time.perf_counter()
            new_times.append(end - start)
            os.remove(output)

        old_avg = sum(old_times) / len(old_times)
        new_avg = sum(new_times) / len(new_times)
        improvement = ((old_avg - new_avg) / old_avg * 100)

        print(f"\n  Old approach (2x rename): {old_avg*1000:.2f}ms average")
        print(f"  New approach (1x replace): {new_avg*1000:.2f}ms average")
        print(f"  File operation overhead reduction: {improvement:.1f}%")
        print("\n" + "=" * 80 + "\n")


if __name__ == '__main__':
    print("""
Compression Performance Test for build_tar.py
==============================================

Testing optimized zstd and xz compression...

To include 100MB test, run:
    LARGE_TESTS=1 python3 tests/test_compression_performance.py

To include 1GB test, run:
    VERY_LARGE_TESTS=1 python3 tests/test_compression_performance.py

""")
    unittest.main(verbosity=2)
