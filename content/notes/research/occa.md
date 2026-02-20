---
title: "OCCA"
bookToc: true
---

# OCCA

While reading "Implementing Multi-GPU Scientific Computing Miniapps Across Performance Portable Frameworks" the OCCA framework caught my attention. It was not particularly performant in their comparison, but one thing that stands out is their support for the Metal backend. Metal is Apple's proprietary graphics API, and it is (as far as I know) the only API supported by the GPU on Apple silicon (e.g. M1 macs). So I wanted to see if it actually worked.

## OCCA

OCCA is a single-source library with support for a wide variety of backends (including CUDA, OpenMP, OpenCL, and others). They define a domain-specific kernel language (an extension to C). Users provide computational kernels in this kernel language (OCL), and kernels are just-in-time compiled to the appropriate backend. This is a pretty neat concept, and is pretty different from the frameworks I've been using that all try their best to look like standard ISO C++. It reminds me of Firedrake, which is a library with a similar goal.

## Metal backend

I checked out OCCA on my 2020 M1 macbook air to see what it could do. With a lot of help from Claude and from https://github.com/libocca/occa/pull/766 I was able to get it working properly. The demo kernel I was working with is a 2D Laplacian stencil. Here's the demo application that uses the kernel and computes a rough estimate of the memory bandwidth:

<details>
<summary><code>laplacian.okl</code></summary>

```
// laplacian.okl

@kernel void laplacian(const int N, const float * in, float * out) {
  for (int bj = 0; bj < N; bj += BLOCK_Y; @outer(1)) {
    for (int bi = 0; bi < N; bi += BLOCK_X; @outer(0)) {
      for (int j = bj; j < bj + BLOCK_Y; ++j; @inner(1)) {
        for (int i = bi; i < bi + BLOCK_X; ++i; @inner(0)) {
          if (i > 0 && i < (N - 1) && j > 0 && j < (N - 1)) {
            const int id = j * N + i;
            out[id] = -4.0f * in[id]
                      + in[id - 1]     // left
                      + in[id + 1]     // right
                      + in[id - N]     // up
                      + in[id + N];    // down
          }
        }
      }
    }
  }
}
```

</details>

<details>
<summary><code>benchmark.cpp</code></summary>

```cpp
// benchmark.cpp
#include <iostream>
#include <iomanip>
#include <cmath>
#include <chrono>
#include <string>

#include <occa.hpp>

struct BenchResult {
  std::string mode;
  double setupTime;
  double kernelTime;
  double bandwidth;
  double gflops;
  double maxError;
};

BenchResult runBenchmark(const std::string &modeJson, int N, int iterations) {
  BenchResult result;
  result.mode = modeJson;

  auto t0 = std::chrono::high_resolution_clock::now();

  // --- Device & kernel setup ---
  occa::device device;
  device.setup(modeJson);

  occa::json kernelProps;
  kernelProps["defines/BLOCK_X"] = 16;
  kernelProps["defines/BLOCK_Y"] = 16;

  occa::kernel laplacian = device.buildKernel(
    "laplacian.okl", "laplacian", kernelProps
  );

  // --- Allocate and initialize ---
  float *h_in  = new float[N * N];
  float *h_out = new float[N * N];
  float *h_ref = new float[N * N];

  for (int j = 0; j < N; ++j) {
    for (int i = 0; i < N; ++i) {
      float x = (float)i / (N - 1);
      float y = (float)j / (N - 1);
      h_in[j * N + i] = sinf(M_PI * x) * sinf(M_PI * y);
      h_out[j * N + i] = 0.0f;
    }
  }

  occa::memory o_in  = device.malloc<float>(N * N);
  occa::memory o_out = device.malloc<float>(N * N);

  o_in.copyFrom(h_in);
  o_out.copyFrom(h_out);

  auto t1 = std::chrono::high_resolution_clock::now();
  result.setupTime = std::chrono::duration<double, std::milli>(t1 - t0).count();

  // --- Warmup ---
  laplacian(N, o_in, o_out);
  device.finish();

  // --- Timed iterations ---
  auto t2 = std::chrono::high_resolution_clock::now();

  for (int iter = 0; iter < iterations; ++iter) {
    laplacian(N, o_in, o_out);
  }
  device.finish();

  auto t3 = std::chrono::high_resolution_clock::now();
  double elapsed = std::chrono::duration<double, std::milli>(t3 - t2).count();
  result.kernelTime = elapsed / iterations;

  // --- Compute bandwidth and GFLOPS ---
  // Each interior point: 1 read of out, 5 reads of in, 1 write = 7 memory ops
  // (approximate: borders are skipped but negligible for large N)
  long long interiorPoints = (long long)(N - 2) * (N - 2);
  double bytesPerIter = interiorPoints * 7.0 * sizeof(float);
  result.bandwidth = (bytesPerIter / (result.kernelTime * 1e-3)) / 1e9; // GB/s

  // Each interior point: 4 adds + 1 multiply = 5 flops
  double flopsPerIter = interiorPoints * 5.0;
  result.gflops = (flopsPerIter / (result.kernelTime * 1e-3)) / 1e9;

  // --- Verify correctness ---
  o_out.copyTo(h_out);

  // Compute reference on CPU
  for (int j = 1; j < N - 1; ++j) {
    for (int i = 1; i < N - 1; ++i) {
      int id = j * N + i;
      h_ref[id] = -4.0f * h_in[id]
                  + h_in[id - 1] + h_in[id + 1]
                  + h_in[id - N] + h_in[id + N];
    }
  }

  result.maxError = 0.0;
  for (int j = 1; j < N - 1; ++j) {
    for (int i = 1; i < N - 1; ++i) {
      double err = fabs(h_out[j * N + i] - h_ref[j * N + i]);
      if (err > result.maxError) result.maxError = err;
    }
  }

  delete[] h_in;
  delete[] h_out;
  delete[] h_ref;

  return result;
}

void printResult(const BenchResult &r, const std::string &label) {
  std::cout << std::left << std::setw(12) << label
            << " | Setup: " << std::right << std::setw(8) << std::fixed
            << std::setprecision(1) << r.setupTime << " ms"
            << " | Kernel: " << std::setw(8) << std::setprecision(3)
            << r.kernelTime << " ms"
            << " | BW: " << std::setw(6) << std::setprecision(1)
            << r.bandwidth << " GB/s"
            << " | GFLOPS: " << std::setw(6) << std::setprecision(2)
            << r.gflops
            << " | MaxErr: " << std::scientific << std::setprecision(2)
            << r.maxError
            << std::endl;
}

int main(int argc, const char **argv) {
  const int N = 8192;
  const int iterations = 400;

  std::cout << "============================================================\n";
  std::cout << "  OCCA 2D Laplacian Stencil Benchmark\n";
  std::cout << "  Grid: " << N << " x " << N
            << " (" << (N * N * sizeof(float)) / (1024.0 * 1024.0)
            << " MB per field)\n";
  std::cout << "  Iterations: " << iterations << "\n";
  std::cout << "============================================================\n\n";

  // Serial
  auto serial = runBenchmark("{mode: 'Serial'}", N, iterations);
  printResult(serial, "Serial");

  // Metal
  auto metal = runBenchmark("{mode: 'Metal', device_id: 0}", N, iterations);
  printResult(metal, "Metal");

  // OpenCL
  auto opencl = runBenchmark("{mode: 'OpenCL', platform_id: 0, device_id: 0}", N, iterations);
  printResult(opencl, "OpenCL");

  // Summary
  std::cout << "\n--- Speedup over Serial ---\n";
  std::cout << "  Metal  : " << std::fixed << std::setprecision(1)
            << serial.kernelTime / metal.kernelTime << "x\n";
  std::cout << "  OpenCL : " << std::fixed << std::setprecision(1)
            << serial.kernelTime / opencl.kernelTime << "x\n";

  return 0;
}
```

</details>

Now, to get this to build, I need to first build OCCA with the Metal backend enabled. This ended up being a lot trickier than I expected. Trying to use it out of the box, the cmake build was successful but there were segfaults all over the place. Looking at /github.com/libocca/occa/pull/766 and getting Claude to try a bunch of different things, I ended up with these modifications

```diff
diff --git a/cmake/FindMETAL.cmake b/cmake/FindMETAL.cmake
index cfbdcfb3..e6f80aa1 100644
--- a/cmake/FindMETAL.cmake
+++ b/cmake/FindMETAL.cmake
@@ -3,24 +3,24 @@
 # This Find module is also distributed alongside the occa package config file!
 ###############################################################################

+find_library(FOUNDATION_LIBRARY Foundation)
 find_library(METAL_LIBRARY Metal)
-find_library(CORE_SERVICES CoreServices)
-find_library(APP_KIT AppKit)
+find_library(METAL_KIT_LIBRARY MetalKit)

 include(FindPackageHandleStandardArgs)
 find_package_handle_standard_args(
     METAL
     REQUIRED_VARS
+    FOUNDATION_LIBRARY
     METAL_LIBRARY
-    CORE_SERVICES
-    APP_KIT
-    )
+    METAL_KIT_LIBRARY
+)

 if(METAL_FOUND AND NOT TARGET OCCA::depends::METAL)
   # Create our wrapper imported target
   # Put it in the OCCA namespace to make it clear that we created it.
   add_library(OCCA::depends::METAL INTERFACE IMPORTED)
-  set_target_properties(OCCA::depends::METAL PROPERTIES
-    INTERFACE_LINK_LIBRARIES "${METAL_LIBRARY} ${CORE_SERVICES} ${APP_KIT}"
+  target_link_libraries(OCCA::depends::METAL INTERFACE
+    ${FOUNDATION_LIBRARY} ${METAL_LIBRARY} ${METAL_KIT_LIBRARY}
   )
-endif()
+endif()
\ No newline at end of file
diff --git a/scripts/codegen/setup_kernel_operators.py b/scripts/codegen/setup_kernel_operators.py
index 41ec7f8e..8dacbc18 100755
--- a/scripts/codegen/setup_kernel_operators.py
+++ b/scripts/codegen/setup_kernel_operators.py
@@ -89,9 +89,17 @@ def run_function_from_arguments(N):

 def run_function_from_argument(N):
     content  = '  case {N}:\n'.format(N=N)
-    content += '    f('
-    indent = ' ' * 6  # '    f('

+    # Cast function pointer to a non-variadic type with the correct
+    # number of void* parameters. This is required on ARM64 (Apple
+    # Silicon) where the calling convention for variadic functions
+    # differs from non-variadic ones.
+    param_types = ', '.join(['void*'] * N) if N > 0 else 'void'
+    cast = '(void (*)({params}))'.format(params=param_types)
+    call_prefix = '    ({cast}f)('.format(cast=cast)
+    indent = ' ' * len(call_prefix)
+
+    content += call_prefix
     for n in range(N):
         content += 'args[{n}]'.format(n=n)
         if n < (N - 1):
```

With that, the demo app actually compiles and runs correctly:

```bash
cmake -S /Users/evan/GitHub/occa \
  -B /Users/evan/GitHub/occa/build \
  -DOCCA_ENABLE_EXAMPLES=ON \
  -DCMAKE_BUILD_TYPE=Release 2>&1 \
  | tail -5 && cmake --build /Users/evan/GitHub/occa/build \
    --parallel $(sysctl -n hw.ncpu) 2>&1 \
  | tail -15
-- METAL core services:
-- METAL app kit:
-- Configuring done (0.6s)
-- Generating done (0.1s)
-- Build files have been written to: /Users/evan/GitHub/occa/build
[ 91%] Built target examples_c_generic_inline_kernel
[ 91%] Built target examples_c_add_vector
[ 92%] Built target examples_cpp_add_vectors
[ 92%] Built target examples_cpp_arrays
[ 93%] Built target examples_cpp_generic_inline_kernel
[ 93%] Built target examples_cpp_for_loops
[ 94%] Built target examples_cpp_custom_types
[ 94%] Built target examples_cpp_shared_memory
[ 94%] Built target examples_cpp_native_c_kernels
[ 95%] Built target examples_cpp_memory_pool
[ 96%] Built target examples_cpp_native_cpp_kernels
[ 97%] Built target examples_cpp_nonblocking_streams
[ 98%] Built target examples_cpp_streams
[ 99%] Built target examples_cpp_device_function
[100%] Built target occa
```

```bash
cd /Users/evan/GitHub/occa/build/benchmark && c++ -std=c++17 -O3 \
          -I/Users/evan/GitHub/occa/include \
          -I/Users/evan/GitHub/occa/build/include \
          benchmark.cpp \
          -L/Users/evan/GitHub/occa/build/lib -locca \
          -Wl,-rpath,/Users/evan/GitHub/occa/build/lib \
          -o benchmark 2>&1 && ./benchmark
============================================================
  OCCA 2D Laplacian Stencil Benchmark
  Grid: 8192 x 8192 (256 MB per field)
  Iterations: 400
============================================================

Serial       | Setup:    631.2 ms | Kernel:   77.993 ms | BW:   24.1 GB/s | GFLOPS:   4.30 | MaxErr: 0.00e+00
Metal        | Setup:    434.7 ms | Kernel:    9.535 ms | BW:  197.0 GB/s | GFLOPS:  35.17 | MaxErr: 0.00e+00
OpenCL       | Setup:    268.3 ms | Kernel:    9.220 ms | BW:  203.7 GB/s | GFLOPS:  36.37 | MaxErr: 0.00e+00

--- Speedup over Serial ---
  Metal  : 8.2x
  OpenCL : 8.5x
```

That's pretty cool! It's not like any HPC environments will be needing the Metal backend, so there's not much real benefit to it, but it's nice to know that there's a framework that's better than OpenCL that makes it possible to get some reasonably good accelerator performance on a modern Macbook :)
