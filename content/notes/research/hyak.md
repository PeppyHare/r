---
title: "Hyak HPC"
bookToc: true
---

{{< katex display >}}
{{< /katex >}}

# Hyak HPC

Just keeping any useful tips/tricks/hard-fought successful build scripts I find for working with UW's compute clusters Klone and Tillicum

## GPU Klone Nodes

In the `aaplasma` account we don't have direct access to any GPU-enabled partitions, but there's always the checkpoint partition. To simply get an interactive session for a single node with a GPU attached, we can:

```
salloc -A aaplasma --partition=ckpt-all --gpus-per-node=1  --mem=24G --time=2:00:00
```

Sort of unfortunately, the nodes are a real mix of different GPU architectures, so you can't really tell what sort of device you're going to get that way. As of January 2026, these seem to be the different flavors available:

| GPU | Architecture | CUDA compute capability | Klone restriction ID |  Memory |
| --- |  ---         |  ---                    |         ---          | --- |
| P100 | Pascal | 6.0  | p100 |  16GB of HBM2 memory per GPU card |
| 2080 Ti | Turing | 7.5 | 2080ti | 11GB of GDDR6 memory per GPU card |
| RTX 6000 | Turing | 7.5 | rtx6k |  48GB of GDDR6 memory per GPU card |
| A40 | Ampere | 8.6 | a40 | 48GB of GDDR6 memory per GPU card |
| A100 | Ampere | 8.0 | a100 | 40GB of HBM2 memory per GPU card |
| L40 / L40s | Lovelace | 8.9 | l40 / l40s | 48GB of GDDR6 memory per GPU card |
| H200 | Hopper | 9.0 | h200 | 141 GB memory (but not allowed on checkpoint partition) |

To get a sense of just what these cards can do, I've used this exceptionally useful OpenCL benchmark demo: https://github.com/ProjectPhysX/OpenCL-Benchmark


|                             |     P100 |  2080 Ti | RTX 6000 |      A40 |     A100 |      L40 |
| --------------------------- | -------: | -------: | -------: | -------: | -------: | -------: |
| Compute Units               |       56 |       68 |       72 |       84 |      108 |      142 |
| Clock (MHz)                 |     1328 |     1545 |     1770 |     1740 |     1410 |     2490 |
| Cores                       |     3584 |     4352 |     4608 |    10752 |     6912 |    18176 |
| VRAM (MB)                   |    16269 |    10820 |    24021 |    45488 |    81151 |    45457 |
| Global Cache (KB)           |     1344 |     2176 |     2304 |     2352 |     3024 |     3976 |
| FP64 (TFLOPs/s)             |    3.508 |    0.490 |    0.561 |    0.575 |    9.557 |    1.391 |
| FP32 (TFLOPs/s)             |    8.634 |   15.753 |   17.944 |   35.403 |   19.234 |   84.753 |
| FP64/FP32                   |      1/3 |     1/32 |     1/32 |     1/64 |      1/2 |     1/64 |
| FP16 (TFLOPs/s)             |   17.573 |   31.114 |   35.632 |   36.845 |   72.486 |   88.687 |
| INT64 (TIOPs/s)             |    1.199 |    3.400 |    3.588 |    2.848 |    2.652 |    3.696 |
| INT32 (TIOPs/s)             |    3.119 |   15.274 |   17.475 |   18.467 |   19.416 |   44.439 |
| INT16 (TIOPs/s)             |    8.871 |   12.920 |   14.607 |   16.685 |   17.616 |   35.483 |
| INT8 (TIOPs/s)              |    1.765 |   53.973 |   60.096 |   64.745 |   71.156 |  103.977 |
| Mem Read coalesced (GB/s)   |   544.50 |   535.62 |   557.27 |   581.17 |  1514.39 |   713.57 |
| Mem Write coalesced (GB/s)  |   595.68 |   538.19 |   594.67 |   549.21 |  1804.67 |   474.25 |
| Mem Read misaligned (GB/s)  |   303.00 |   491.31 |   559.38 |   568.02 |  1219.07 |   725.41 |
| Mem Write misaligned (GB/s) |    90.52 |   149.62 |   170.52 |   177.77 |   209.38 |   240.57 |
| PCIe Send (GB/s)            |    10.97 |     4.97 |     4.85 |     4.57 |     5.70 |    21.92 |
| PCIe Receive (GB/s)         |     8.96 |     5.04 |     5.27 |     4.56 |     8.24 |    21.94 |
| PCIe Bidirectional (GB/s)   |     9.59 |     4.82 |     4.96 |     7.10 |     6.54 |    20.65 |
| PCIe Generation             | Gen4 x16 | Gen3 x16 | Gen3 x16 | Gen3 x16 | Gen3 x16 | Gen4 x16 |


## Kokkos/RAJA on Klone

### Requesting Nodes

The CUDA installation is available on each node by loading the lmod module `module load cuda`.

RAJA and Kokkos are happy to compile GPU kernels for whatever CUDA architectures are supported by the cuda module. AFAICT Kokkos only lets you pick one, while RAJA lets you specify multiple architectures. We should build for the highest version that is supported by every device we might need to run on. Unfortunately, there are parts of RAJA/Kokkos that require 7.0+, so we can't target the old P100 cards. To work around this, we can supply a constraint to our slurm command to tell it which GPUs we are willing to work with:

```
salloc -A aaplasma --partition=ckpt-all --gpus-per-node=1 --constraint="2080ti|a40|a100|l40|l40s|rtx6k" --mem=24G --time=2:00:00
```

This puts us on a node that does not have a P100 card. That way we can target CUDA 7.5 and it should work for all of the other cards.

To build RAJA on Klone, I've used this set of commands after cloning the RAJA repo (with --recurse-submodules):

```bash
module purge
module load cuda gcc/13.2.0
cd /gscratch/aaplasma/embluhm/tools/src/RAJA
mkdir -p build
cmake -B build/ -DCMAKE_INSTALL_PREFIX=/gscratch/aaplasma/embluhm/tools/RAJA -DRAJA_ENABLE_CUDA=ON -DENABLE_CUDA=ON -DCUDA_TOOLKIT_ROOT_DIR=/sw/cuda/12.4.1 -DCMAKE_CUDA_COMPILER=/sw/cuda/12.4.1/bin/nvcc -DCMAKE_CUDA_ARCHITECTURES="75" -DRAJA_ENABLE_EXAMPLES=ON -DRAJA_ENABLE_TESTS=ON -DRAJA_ENABLE_BENCHMARKS=ON -DENABLE_BENCHMARKS=ON .
cmake --build build/ -j12
```

That seems to be working so far! The full build took about 30 minutes. I'm using the `gcc/13.2.0` compiler module because that's the one used for the latest CUDA-aware OpenMPI module on Klone. Gotta make sure all the versions match up if we don't want to be chasing down the most annoying linking problems imaginable.

## Building METIS

When linking with the latest CUDA and OpenMP modules, I want a METIS built with the same gcc that was used for OpenMPI. That means building METIS from scratch.

Building METIS is pretty easy, but by default it does not statically link in the GKlib dependencies. To create a static libmetis.a library that WARPXM can use without also needing to link in a GKlib installation, we can manually combine GKlib into the libmetis.a:

```
module load gcc/13.2.0
git clone https://github.com/KarypisLab/METIS.git
git clone https://github.com/KarypisLab/GKlib.git
cd GKlib
make config prefix=/gscratch/aaplasma/embluhm/tools/GKlib
make install
cd ../METIS
make config gklib_path=/mmfs1/gscratch/aaplasma/embluhm/tools/GKlib prefix=/mmfs1/gscratch/aaplasma/embluhm/tools/METIS
make install

# Create a combined static libmesh.a, and copy it over top of the old libmetis.a
mkdir /tmp/metis_combined && cd /tmp/metis_combined
ar -x /mmfs1/gscratch/aaplasma/embluhm/tools/GKlib/lib64/libGKlib.a
ar -x /mmfs1/gscratch/aaplasma/embluhm/tools/METIS/lib/libmetis.a
ar -rcs /mmfs1/gscratch/aaplasma/embluhm/tools/METIS/lib/libmetis.a *.o
cd && rm -rf /tmp/metis_combined
```

## Building HDF5-parallel

With no HDF5 module to rely on, we can just build it ourselves. It's not too bad, as long as we get lucky :)

```bash
salloc -A aaplasma -c 20 --mem=24G --time=2:00:00
module purge
module load ompi/4.1.6-2 gcc/13.2.0
wget https://github.com/HDFGroup/hdf5/releases/download/hdf5_1.14.6/hdf5-1.14.6.tar.gz
tar -zxvf hdf5-1.14.6.tar.gz
cd hdf5-1.14.6/
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release  -DHDF5_ENABLE_PARALLEL=ON  -DBUILD_SHARED_LIBS=ON  -DBUILD_TESTING=ON  -DCMAKE_INSTALL_PREFIX=/gscratch/aaplasma/embluhm/tools/hdf5-mpi-1.14.6 -DCMAKE_C_COMPILER=/sw/ompi/4.1.6-2/bin/mpicc -DMPI_HOME=/sw/ompi/4.1.6-2 -DMPIEXEC_MAX_NUMPROCS=4 ..
make -j20 install
```

## Building Kokkos

1. Grab the Kokkos source from a [GitHub release](https://github.com/kokkos/kokkos/releases) (latest is probably good)
2. Create a build script (e.g. build_kokkos.sh). I've chosen to only enable the CUDA backend and not the OpenMP backend, because I'm not using OpenMP thread parallelism and I don't want to have to deal with setting OpenMP environment variables every time I run something just to avoid it spinning up OpenMP threads to do nothing. If you want OpenMP enabled, just turn on that option. I've picked CUDA arch 7.5 as the minimum version to use. 
    ```
    #!/bin/bash -ex
    
    module purge
    module load cuda/12.9.1 ompi/4.1.6-2 gcc/13.2.0
    
    rm -rf build
    mkdir -p build
    cmake -B build/ \
      -DCMAKE_INSTALL_PREFIX=/gscratch/aaplasma/embluhm/tools/kokkos-cuda12.9.1 \
      -DCMAKE_BUILD_TYPE=Release \
      -DKokkos_ENABLE_CUDA=ON -DCUDA_ROOT=/sw/cuda/12.9.1 -DKokkos_ARCH_TURING75=ON \
      -DKokkos_ENABLE_OPENMP=OFF \
      -DKokkos_ENABLE_SERIAL=ON  
    cmake --build build/ -j20
    cd build
    make install
    ln -s /gscratch/aaplasma/embluhm/tools/kokkos-cuda12.9.1/lib64 /gscratch/aaplasma/embluhm/tools/kokkos-cuda12.9.1/lib
    ```
3. Make it executable
    ```
    chmod +x build_kokkos.sh
     ```
4. Submit a job to build Kokkos using the build script. This will take a little while. Afterwards, Kokkos will be installed at the location specified by CMAKE_INSTALL_PREFIX in the build script (can be wherever you want)
    ```
    salloc -A aaplasma -c 20 --mem=24G --time=2:00:00 srun ./build_kokkos.sh
    ```

## Building Kokkos-enabled WARPXM

Now that I've added a whole bunch of Kokkos-related dependencies to WARPXM, I can't just use the existing PETSc-based modules for all of the other dependencies. At present, the dependencies required to build all of the WARPXM features (other than the old PETSc-based implicit solver) are:
- MPI implementation (OpenMPI)
- CMake
- METIS
- HDF5 (linked against MPI)
- Kokkos (with CUDA)

There are modules for CUDA-aware OpenMPI, so we don't have to worry about that. We just

```
module load cuda/12.9.1 ompi/4.1.6-2 gcc/13.2.0
```

We do need HDF5 and METIS, so let's go ahead and build them first, following the instructions above.

The script that I'm using to put all of this together and build WARPXM looks like this:

```bash
#!/bin/bash -ex
module purge
module load cuda/12.9.1 ompi/4.1.6-2 gcc/13.2.0
export HDF5_DIR=/gscratch/aaplasma/embluhm/tools/hdf5-mpi-1.14.6/cmake
export OMPI_CXX=/gscratch/aaplasma/embluhm/tools/kokkos-cuda12.9.1/bin/nvcc_wrapper
export PKG_CONFIG_PATH=/sw/ompi/4.1.6-2/lib/pkgconfig:$PKG_CONFIG_PATH
cd /gscratch/aaplasma/embluhm/code/warpxm || return 1

if [ ! -d build ]; then
    mkdir build || return 1
else
    rm -f build/CMakeCache.txt
fi

# RelWithDebInfo
cmake -B build/ \
    -DWXM_ENABLE_KOKKOS=ON \
    -DHDF5_ROOT=/gscratch/aaplasma/embluhm/tools/hdf5-mpi-1.14.6 \
    -DMetis_ROOT=/gscratch/aaplasma/embluhm/tools/METIS \
    -DKokkos_ROOT=/gscratch/aaplasma/embluhm/tools/kokkos-cuda12.9.1 \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_C_COMPILER=/sw/ompi/4.1.6-2/bin/mpicc \
    -DCMAKE_CXX_COMPILER=/sw/ompi/4.1.6-2/bin/mpicxx \
    -DWXM_ENABLE_TRACY= \
    -DCUDAToolkit_ROOT=/sw/cuda/12.9.1 \
    -DPython_EXECUTABLE=/gscratch/aaplasma/embluhm/conda/python3-11/bin/python3 \
    -DMPI_HOME=/sw/ompi/4.1.6-2 \
    . || return 1

cmake --build build/ -j20 || return 1

cd build || return 1
ctest -j20 --output-on-failure --label-regex "Unit" || return 1
```

I put all of this into a `klone_build_script.sh`, and then kick off a build with:

```bash
salloc -A aaplasma -c 20 --mem=24G --time=2:00:00 srun ./klone_build_script.sh
```

