---
title: "Installation tricks"
bookToc: true
---

{{< katex display >}}
{{< /katex >}}


# AdaptiveCPP

[AdaptiveCPP](https://adaptivecpp.github.io/AdaptiveCpp/) is an extremely useful compiler once it's installed properly, but man is it a pain to get working in the first place. Here's what I've done in the past:


{{< tabs >}}
{{% tab "MacOS" %}}
**MacOS**

Just use the homebrew formula. It works great on the latest Apple hardware and you don't need to do anything extra

```
brew install adaptivecpp
```

{{% /tab %}}

{{% tab "Ubuntu Linux / WSL" %}}
**Ubuntu Linux**

To be able to use the most useful "generic" backend, you really need to build `acpp` with a recent, compatible version of LLVM, and it needs to have been built with lld and openmp enabled (which most distribution versions don't have). On a HPC system, the version of LLVM needs to be compatible with the CUDA/ROCm version, but on a personal machine this is pretty easy. Just go with LLVM 20:

```
# Grab the LLVM source
mkdir -p $HOME/tools/src && cd $HOME/tools/src
git clone https://github.com/llvm/llvm-project -b release/20.x
cd llvm-project
mkdir build
cd build

export INSTALL_PREFIX=$HOME/tools/llvm-20
mkdir -p $INSTALL_PREFIX

# Configure with CMake
cmake -DCMAKE_C_COMPILER=`which gcc` -DCMAKE_CXX_COMPILER=`which g++` \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX \
      -DLLVM_ENABLE_PROJECTS="clang;compiler-rt;lld;openmp" \
      -DOPENMP_ENABLE_LIBOMPTARGET=OFF \
      -DCMAKE_BUILD_TYPE=Release \
      -DLLVM_ENABLE_ASSERTIONS=OFF \
      -DLLVM_TARGETS_TO_BUILD="AMDGPU;NVPTX;X86" \
      -DCLANG_ANALYZER_ENABLE_Z3_SOLVER=0 \
      -DLLVM_INCLUDE_BENCHMARKS=0 \
      -DLLVM_INCLUDE_EXAMPLES=0 \
      -DLLVM_INCLUDE_TESTS=0 \
      -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
      -DCMAKE_INSTALL_RPATH=$INSTALL_PREFIX/lib \
      -DLLVM_ENABLE_OCAMLDOC=OFF \
      -DLLVM_ENABLE_BINDINGS=OFF \
      -DLLVM_TEMPORARILY_ALLOW_OLD_TOOLCHAIN=OFF \
      -DLLVM_BUILD_LLVM_DYLIB=ON \
      -DLLVM_ENABLE_DUMP=OFF  ../llvm

# Build and install
make -j install
```

Now you need to also install Boost:

```
mkdir -p $HOME/tools/src && cd $HOME/tools/src
export PATH=$HOME/tools/llvm-20/bin:$PATH
wget https://archives.boost.io/release/1.88.0/source/boost_1_88_0.tar.gz
tar -xzf boost_1_88_0.tar.gz
cd boost_1_88_0
./bootstrap.sh --with-toolset=clang
./b2
./b2 install --prefix=$HOME/tools/boostlib
```

Finally we can check out the adaptivecpp source and build it:

```
cd $HOME/tools/src
git clone https://github.com/AdaptiveCpp/AdaptiveCpp.git
cd AdaptiveCpp
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$HOME/tools/acpp-25 \
  -DCMAKE_C_COMPILER=$HOME/tools/llvm-20/bin/clang \
  -DCMAKE_CXX_COMPILER=$HOME/tools/llvm-20/bin/clang++ \
  -DBOOST_ROOT=$HOME/tools/boostlib ..
make -j install
```

That should do it! Now `acpp` is available at `$HOME/tools/acpp-25/bin/acpp`. If your linker is giving you trouble, try explicitly telling it about the library paths for the dependencies:

```
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SCRATCH/tools/boostlib/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SCRATCH/tools/llvm-20/lib
```

{{% /tab %}}

{{% tab "Perlmutter" %}}

**NERSC Perlmutter**

On Perlmutter, I built adaptiveCPP from source to use as my SYCL compiler. To do that, we need Boost and we need LLVM (to use the generic backend for CPU-only runs).

First thing, build LLVM! Version 20 gave me the best results with the current acpp release.

```
# Grab the LLVM source
mkdir -p $SCRATCH/code && cd $SCRATCH/code
git clone https://github.com/llvm/llvm-project -b release/20.x
cd llvm-project
mkdir build
cd build

export INSTALL_PREFIX=$SCRATCH/tools/llvm-20
mkdir -p $INSTALL_PREFIX

# Configure with CMake
cmake -DCMAKE_C_COMPILER=`which gcc` -DCMAKE_CXX_COMPILER=`which g++` \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX \
      -DLLVM_ENABLE_PROJECTS="clang;compiler-rt;lld;openmp" \
      -DOPENMP_ENABLE_LIBOMPTARGET=OFF \
      -DCMAKE_BUILD_TYPE=Release \
      -DLLVM_ENABLE_ASSERTIONS=OFF \
      -DLLVM_TARGETS_TO_BUILD="AMDGPU;NVPTX;X86" \
      -DCLANG_ANALYZER_ENABLE_Z3_SOLVER=0 \
      -DLLVM_INCLUDE_BENCHMARKS=0 \
      -DLLVM_INCLUDE_EXAMPLES=0 \
      -DLLVM_INCLUDE_TESTS=0 \
      -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
      -DCMAKE_INSTALL_RPATH=$INSTALL_PREFIX/lib \
      -DLLVM_ENABLE_OCAMLDOC=OFF \
      -DLLVM_ENABLE_BINDINGS=OFF \
      -DLLVM_TEMPORARILY_ALLOW_OLD_TOOLCHAIN=OFF \
      -DLLVM_BUILD_LLVM_DYLIB=ON \
      -DLLVM_ENABLE_DUMP=OFF  ../llvm

# Build and install
make -j 24  # don't be too rude on the login nodes :)
make install
```

Now we've got LLVM available at `$SCRATCH/tools/llvm-20`. Also build Boost with our new LLVM:

```
module load python
mkdir -p $SCRATCH/code && cd $SCRATCH/code
export PATH=$SCRATCH/tools/llvm-20/bin:$PATH
wget https://archives.boost.io/release/1.88.0/source/boost_1_88_0.tar.gz
tar -xzf boost_1_88_0.tar.gz
cd boost_1_88_0
./bootstrap.sh --with-toolset=clang
./b2
./b2 install --prefix=$SCRATCH/tools/boostlib
```

With all that done, we can build adaptivecpp:

```
cd $SCRATCH/code
git clone https://github.com/AdaptiveCpp/AdaptiveCpp.git
cd AdaptiveCpp
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$SCRATCH/tools/acpp-25 -DCMAKE_C_COMPILER=$SCRATCH/tools/llvm-20/bin/clang -DCMAKE_CXX_COMPILER=$SCRATCH/tools/llvm-20/bin/clang++ -DBOOST_ROOT=$SCRATCH/tools/boostlib ..
```

That should work! If not, try explicitly adding boost/llvm libraries to the system path

```
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SCRATCH/tools/boostlib/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SCRATCH/tools/llvm-20/lib
```

Now we've got adaptivecpp available! Add it to your path in your ~/.bashrc to make it always available

```
export PATH=$SCRATCH/tools/acpp-25/bin:$PATH
```

{{% /tab %}}

{{% tab "Frontier" %}}

**Frontier**

On Frontier I had a lot of trouble getting the provided `icpx` to play nicely with the device-aware MPI, so I ended up building adaptivecpp again. I'm sure there was some way to make it work, but I got too lost in the weeds trying to match library versions and this was easier for me. This time I needed to use LLVM version 18 because I'm not allowed to use a newer version than what the ROCm installation uses.

To get the device-aware MPI playing nicely, I ended up using the newest combination listed in https://docs.olcf.ornl.gov/systems/frontier_user_guide.html#compatible-rocm-cray-mpich-versions:

```
module load cray-mpich/8.1.31 rocm/6.2.4
```

```
# Grab the LLVM source
mkdir -p $MEMBERWORK/code && cd $MEMBERWORK/code
git clone https://github.com/llvm/llvm-project -b release/18.x
cd llvm-project
mkdir build
cd build

export INSTALL_PREFIX=$MEMBERWORK/tools/llvm-18
mkdir -p $INSTALL_PREFIX

# Configure with CMake
cmake -DCMAKE_C_COMPILER=`which gcc` -DCMAKE_CXX_COMPILER=`which g++` \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX \
      -DLLVM_ENABLE_PROJECTS="clang;compiler-rt;lld;openmp" \
      -DOPENMP_ENABLE_LIBOMPTARGET=OFF \
      -DCMAKE_BUILD_TYPE=Release \
      -DLLVM_ENABLE_ASSERTIONS=OFF \
      -DLLVM_TARGETS_TO_BUILD="AMDGPU;NVPTX;X86" \
      -DCLANG_ANALYZER_ENABLE_Z3_SOLVER=0 \
      -DLLVM_INCLUDE_BENCHMARKS=0 \
      -DLLVM_INCLUDE_EXAMPLES=0 \
      -DLLVM_INCLUDE_TESTS=0 \
      -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
      -DCMAKE_INSTALL_RPATH=$INSTALL_PREFIX/lib \
      -DLLVM_ENABLE_OCAMLDOC=OFF \
      -DLLVM_ENABLE_BINDINGS=OFF \
      -DLLVM_TEMPORARILY_ALLOW_OLD_TOOLCHAIN=OFF \
      -DLLVM_BUILD_LLVM_DYLIB=ON \
      -DLLVM_ENABLE_DUMP=OFF  ../llvm

# Build and install
make -j 24  # don't be too rude on the login nodes :)
make install
```

Once again I needed to build Boost from scratch because the module available on Frontier doesn't include the `fiber` or `context` modules.

```
module load python
cd $MEMBERWORK/tools/source
wget https://archives.boost.io/release/1.88.0/source/boost_1_88_0.tar.gz
tar -xzf boost_1_88_0.tar.gz
cd boost_1_88_0
export PATH=$MEMBERWORK/tools/llvm-18/bin:$PATH
./bootstrap.sh --with-python=$OLCF_PYTHON_ROOT/bin/python --with-toolset=clang
./b2 && ./b2 install --prefix=$MEMBERWORK/tools/boost-1-88
```

Now we can build acpp

```
cd $MEMBERWORK/source
git clone https://github.com/AdaptiveCpp/AdaptiveCpp.git
cd AdaptiveCpp/
rm -rf build
mkdir build
cd build
cmake -DBOOST_ROOT=$MEMBERWORK/tools/boost-1-88 -DCMAKE_INSTALL_PREFIX=$MEMBERWORK/tools/acpp-25 -DCMAKE_C_COMPILER=$MEMBERWORK/tools/llvm-18/bin/clang -DCMAKE_CXX_COMPILER=$MEMBERWORK/tools/llvm-18/bin/clang++ -DLLVM_DIR=$MEMBERWORK/tools/llvm-18/lib/cmake/llvm -DWITH_ROCM_BACKEND=ON -DROCM_PATH=/opt/rocm-6.2.4 ..
make -j64
make install
```

{{% /tab %}}

{{% tab "Aurora" %}}

**Aurora**

Aurora has first-class support for the Intel DPCPP compiler, so just use `icpx` instead of `acpp` and it'll be fine.

{{% /tab %}}


{{< /tabs >}}


# Kokkos

{{< tabs >}}

{{% tab "MacOS" %}}

I don't have a mac with a proper GPU any more (most people don't!), so I'm just building for the OpenMP backend here. Performance isn't very good, but at least it runs.

1. Grab the Kokkos source from a [GitHub release](https://github.com/kokkos/kokkos/releases) (latest is probably good)
2. Install `llvm` with homebrew, so that we can use the OpenMP target
    ```
    brew install llvm
    ```
3. Build it! We build with `-fPIC` so that we can load it as a shared library when building both WARPXM and ADIOS2
    ```bash
    mkdir build
    cd build && \
    cmake \
      -DCMAKE_CXX_COMPILER=/opt/homebrew/opt/llvm/bin/clang++ \
      -DCMAKE_INSTALL_PREFIX=/Users/evan/tools/kokkos \
      -DKokkos_ENABLE_OPENMP=ON \
      -DKokkos_ENABLE_SERIAL=ON \
      -DKokkos_ENABLE_TUNING=ON \
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON .. \
    && make -j6 install
    ```

{{% /tab %}}

{{% tab "Hyak" %}}

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
      -DKokkos_ENABLE_OPENMP=OFF -DKokkos_ENABLE_SERIAL=ON \
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON
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

{{% /tab %}}

{{< /tabs >}}



# ADIOS2


{{< tabs >}}

{{% tab "Hyak" %}}

For my purposes, I want ADIOS2 with the Kokkos backend enabled so that I can get direct GPU I/O with the WARPXM writer host action. So we build ADIOS2 from source and point it at an existing Kokkos installation:

1. Check out the ADIOS2 source repo
    ```
     git clone https://github.com/ornladios/ADIOS2.git
    ```
2. Create a build script for submitting to a job queue
    ```bash
    # build_adios.sh
    module purge
    module load cuda/12.9.1 ompi/4.1.6-2 gcc/13.2.0
    rm -rf build
    mkdir -p build
    cmake -B build/ \
      -DADIOS2_USE_MPI=ON \
      -DADIOS2_USE_Kokkos=ON \
      -DADIOS2_USE_Python=OFF\
      -DADIOS2_BUILD_EXAMPLES=OFF\
      -DKokkos_ROOT=/gscratch/aaplasma/embluhm/tools/kokkos-cuda12.9.1\
      -DCUDAToolkit_ROOT=/sw/cuda/12.9.1\
      -DCMAKE_INSTALL_PREFIX=/gscratch/aaplasma/embluhm/tools/ADIOS2
    cd build && make -j20 install
    ```
3. Submit the build:
    ```
    salloc -A aaplasma -c 40 --mem=24G --time=2:00:00 srun bash ./build_adios.sh
    ```


{{% /tab %}}

{{% tab "MacOS" %}}

I'm not sure how useful it will be on a macos system, but I'd still like to test out the Kokkos backend for WARPXM on a mac, and I might as well exercise the adios writer while I'm at it. This seems to work, with the Kokkos I've already installed at /Users/evan/tools/kokkos

```bash
BUILD_DIR="$(cd "$(dirname "$0")" && pwd)/build"
INSTALL_PREFIX="/Users/evan/tools/ADIOS2"
KOKKOS_ROOT="/Users/evan/tools/kokkos"
OPENMPI_PREFIX="$(brew --prefix open-mpi)"
LIBOMP_PREFIX="$(brew --prefix libomp)"

rm -rf "$BUILD_DIR"

cmake -B "$BUILD_DIR" \
  -DCMAKE_C_COMPILER=/usr/bin/clang \
  -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
  -DADIOS2_USE_MPI=ON \
  -DADIOS2_USE_Kokkos=ON \
  -DADIOS2_USE_Python=OFF \
  -DADIOS2_BUILD_EXAMPLES=OFF \
  -DBUILD_SHARED_LIBS=OFF \
  -DKokkos_ROOT="$KOKKOS_ROOT" \
  -DCMAKE_PREFIX_PATH="$OPENMPI_PREFIX" \
  -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" \
  -DOpenMP_CXX_FLAGS="-Xclang -fopenmp" \
  -DOpenMP_CXX_LIB_NAMES="omp" \
  -DOpenMP_omp_LIBRARY="$LIBOMP_PREFIX/lib/libomp.dylib" \
  -DOpenMP_C_FLAGS="-Xclang -fopenmp" \
  -DOpenMP_C_LIB_NAMES="omp" \
  -DCMAKE_CXX_FLAGS="-I$LIBOMP_PREFIX/include" \
  -DCMAKE_C_FLAGS="-I$LIBOMP_PREFIX/include"

cmake --build "$BUILD_DIR" -j"$(sysctl -n hw.ncpu)"

export CMAKE_PREFIX_PATH="$KOKKOS_ROOT:${CMAKE_PREFIX_PATH:-}"
cmake --install "$BUILD_DIR"

```

{{% /tab %}}


{{< /tabs >}}
