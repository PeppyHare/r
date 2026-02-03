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
