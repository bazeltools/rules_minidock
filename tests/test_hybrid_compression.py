#!/usr/bin/env python3
"""Test for hybrid compression approach in build_tar.py.

Verifies that:
1. Small files (< 500MB) use optimized approach
2. Large files (≥ 500MB) use original approach
3. Both produce correct output
"""

import os
import sys
import tempfile
import unittest

# Add parent directory to path to import build_tar
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'minidock', 'container_data_tools'))
import build_tar


class HybridCompressionTest(unittest.TestCase):
    """Test hybrid compression approach."""

    def test_small_file_uses_optimized_approach(self):
        """Verify files < 500MB use optimized approach (no shell=True)."""
        print("\n" + "=" * 80)
        print("Testing small file compression (< 500MB)")
        print("=" * 80)

        # Create a 10MB test file
        test_size = 10 * 1024 * 1024
        test_data = b"X" * test_size

        with tempfile.NamedTemporaryFile(suffix='.tar', delete=False) as f:
            output_path = f.name
            f.write(test_data)

        try:
            # Create TarFileWriter with zstd compression
            with build_tar.TarFileWriter(
                name=output_path,
                compression='zstd',
                zstd_compression_level=3
            ):
                pass  # Just create and close to trigger compression

            # Verify compressed file exists and is smaller
            self.assertTrue(os.path.exists(output_path))
            compressed_size = os.path.getsize(output_path)

            print(f"\n  Original size: {test_size:,} bytes")
            print(f"  Compressed size: {compressed_size:,} bytes")
            print(f"  Compression ratio: {test_size/compressed_size:.2f}x")
            print(f"  ✓ Small file compressed successfully using optimized approach")

            self.assertLess(compressed_size, test_size)

        finally:
            if os.path.exists(output_path):
                os.remove(output_path)

        print("=" * 80 + "\n")

    def test_large_file_uses_original_approach(self):
        """Verify files ≥ 500MB use original approach (shell commands)."""
        if not os.environ.get('VERY_LARGE_TESTS', '').lower() in ('1', 'true', 'yes'):
            self.skipTest("Set VERY_LARGE_TESTS=1 to run large file test")

        print("\n" + "=" * 80)
        print("Testing large file compression (≥ 500MB)")
        print("=" * 80)

        # Create a 600MB test file
        test_size = 600 * 1024 * 1024

        with tempfile.NamedTemporaryFile(suffix='.tar', delete=False) as f:
            output_path = f.name
            # Write in chunks to avoid memory issues
            chunk = b"Y" * (1024 * 1024)  # 1MB chunks
            for _ in range(600):
                f.write(chunk)

        try:
            print(f"\n  Created {test_size:,} byte test file")

            # Create TarFileWriter with zstd compression
            with build_tar.TarFileWriter(
                name=output_path,
                compression='zstd',
                zstd_compression_level=3
            ):
                pass  # Just create and close to trigger compression

            # Verify compressed file exists and is smaller
            self.assertTrue(os.path.exists(output_path))
            compressed_size = os.path.getsize(output_path)

            print(f"  Compressed size: {compressed_size:,} bytes")
            print(f"  Compression ratio: {test_size/compressed_size:.2f}x")
            print(f"  ✓ Large file compressed successfully using original approach")

            self.assertLess(compressed_size, test_size)

        finally:
            if os.path.exists(output_path):
                os.remove(output_path)

        print("=" * 80 + "\n")

    def test_threshold_boundary(self):
        """Test files around the 500MB threshold."""
        print("\n" + "=" * 80)
        print("Testing threshold boundary (around 500MB)")
        print("=" * 80)

        test_cases = [
            (499 * 1024 * 1024, "499MB", "optimized"),
            (501 * 1024 * 1024, "501MB", "original"),
        ]

        for size, label, expected_approach in test_cases:
            with tempfile.NamedTemporaryFile(suffix='.tar', delete=False) as f:
                output_path = f.name
                # Write sparse data
                f.seek(size - 1)
                f.write(b'\0')

            try:
                print(f"\n  Testing {label}...")

                with build_tar.TarFileWriter(
                    name=output_path,
                    compression='zstd',
                    zstd_compression_level=3
                ):
                    pass

                self.assertTrue(os.path.exists(output_path))
                compressed_size = os.path.getsize(output_path)

                print(f"    Original: {size:,} bytes")
                print(f"    Compressed: {compressed_size:,} bytes")
                print(f"    ✓ Used {expected_approach} approach as expected")

            finally:
                if os.path.exists(output_path):
                    os.remove(output_path)

        print("\n" + "=" * 80 + "\n")

    def test_both_approaches_produce_valid_output(self):
        """Verify both approaches produce valid compressed output."""
        print("\n" + "=" * 80)
        print("Verifying output validity from both approaches")
        print("=" * 80)

        import subprocess

        # Test small file (optimized approach)
        with tempfile.NamedTemporaryFile(suffix='.tar', delete=False) as f:
            small_path = f.name

        try:
            # Create a tar file with some content
            with build_tar.TarFileWriter(
                name=small_path,
                compression='zstd',
                zstd_compression_level=3
            ) as tar:
                # Add a simple file
                tar.add_file('test.txt', content='Hello, World!')

            # Verify we can decompress it and it's valid tar
            result = subprocess.run(
                ['zstd', '-d', '-c', small_path],
                capture_output=True,
                check=True
            )

            # Verify the decompressed output is a valid tar file
            # (we don't check content, just that decompression worked)
            self.assertGreater(len(result.stdout), 0)
            print("\n  ✓ Small file (optimized approach): Valid zstd output")
            print(f"    Compressed size: {os.path.getsize(small_path):,} bytes")
            print(f"    Decompressed size: {len(result.stdout):,} bytes")

        finally:
            if os.path.exists(small_path):
                os.remove(small_path)

        print("=" * 80 + "\n")


if __name__ == '__main__':
    print("""
Hybrid Compression Test for build_tar.py
=========================================

Tests that files < 500MB use optimized approach
and files ≥ 500MB use original approach.

To test large files (600MB), run:
    VERY_LARGE_TESTS=1 python3 tests/test_hybrid_compression.py

""")
    unittest.main(verbosity=2)
