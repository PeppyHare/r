---
title: "Getting Started with WARPXM"
bookToc: false
---

# What is WARPXM

WARPXM is a _framework_ for solving hyperbolic systems. Here "framework" means that it is not a single tool for solving a particular system, but rather it contains a large number of applications, solvers, and other tools which can be combined to simulate a wide variety of systems.

# Installation

## Prerequisites: WARPXM

Building the `warpxm` executable itself is the most important part. It is a C++ project which uses CMake as the build system. The main dependencies required to build `warpxm` are:

- PETSc: A sort of toolkit / package manager for scientific computing packages. It is the underlying framework which `warpxm` is built on top of. It can also be used to install compatible versions of most of the other dependencies, like OpenMPI, METIS, HDF5, BLAS/LAPACK, and CMake.
- OpenMPI: Message-passing interface used to parallelize simulations across independent compute cores.
- HDF5: Library used to read & write HDF5-formatted simulation data to disk.
- METIS: Graph and mesh partitioning library.

{{< hint info >}}
**Mac OS**

In my experience, the simplest way to install the required dependencies is to simply use the pre-packaged [Homebrew](https://brew.sh/) formulas:

```
brew install petsc hdf5-mpi cmake gcc metis openblas scalapack
```

> If installing C++ compilers for the first time on a new Mac, need to run `xcode-select --install` to accept the XCode license and enable installing compilers provided by Apple. One of the above homebrew formulae will probably prompt you do to so when it is installed.

This should install all of the libraries required to build the project.

{{< /hint >}}

## Prerequisites: Warpy

The `warpy` Python module under `tools/warpy` contains helpful classes and functions that can be used to build and run input files for `warpxm`. You need to install a few additional Python modules to make use of `warpy`:

```
pip install numpy matplotlib h5py
```

## Build - VSCode

I like to use [VS Code](https://code.visualstudio.com/) as my development environment, since it is cross-platform, has a very large feature set, and adequate performance. The C++ and CMake extensions can help make building and debugging `warpxm` much easier.

- Install the [ms-vscode.cpptools extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
- Install the [ms-vscode.cmake-tools extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
- Create a new workspace at the root of the `warpxm` repository. The CMake extension will create a `warpxm/build` directory for "in-source" builds, which should work fine as long as you don't need to test many different build configurations simultaneously.
- Using the command pallette, run the "Cmake: Select Variant` command to select either "Release" (for optimized execution) or "Debug" (for additional assertions and debug symbols)
- Run the "Cmake: Configure" command to tell CMake to locate all of the required dependencies and generate linux Makefiles in the build directory.
- Run the "Cmake: Build" command to compile the whole project into the build directory. This can take several minutes the first time around, but compiled objects will be cached in between builds so small changes will re-compile quickly.

Congratulations, you've built it! To check that the compiled executable actually works, navigate to the `warpxm/build` directory and run `make test`.

## Build - Command-line

The [install instructions on the wiki](http://faculty.washington.edu/shumlak/WARPX/html/install.html) are great for building at the command-line. Broadly speaking, you will run `cmake` to locate dependencies and generate linux Makefiles for the project in a build directory, then run `make` to actually compile the project in the build directory.


# Basic Example

The most basic example provided in the repo solves the 1-dimensional advection 


```xml
<warpxm>
  Simulation = sim
  NumericPrecision = double
  RunName = data/advection
  GlobalVerbosity = info
  Verbosity = info
  <sim>
    Type = WmSolverBase
    Kind = WmSolver
    Time = [0, 2.0]
    Out = 100
    EnableFPE = 1
    FlexibleWriteout = 0
    NumPartitions = 1
    <mesh>
      Type = mesh
      Kind = block
      NumLayers = 1
      OutputMeshPrefix = meshes/restartMesh
      Bounds = [-0.5, 0.5]
      NumCells = [128]
      NodeSets = [Left, Right]
      PeriodicBoundaries = [Left, Right]
      NodalMeshPrefix = meshes/plotMesh
      BasisArraySet = thirdOrder
    </mesh>
    <dt_controller>
      Type = WmHostAction
      Kind = time_stepper.fixed_dt
      InitDt = 0.0001
      CheckCFL = 1
    </dt_controller>
    <fluid>
      Type = variable
      Kind = distributed
      ComponentNames = [rho]
      BasisArraySet = thirdOrder
    </fluid>
    <fluid_1>
      Type = variable
      Kind = distributed
      ComponentNames = [rho]
      BasisArraySet = thirdOrder
    </fluid_1>
    <fluid_2>
      Type = variable
      Kind = distributed
      ComponentNames = [rho]
      BasisArraySet = thirdOrder
    </fluid_2>
    <fluid_3>
      Type = variable
      Kind = distributed
      ComponentNames = [rho]
      BasisArraySet = thirdOrder
    </fluid_3>
    <diagnostics>
      Type = WmHostAction
      Kind = diagnostics_writer
      WriteInterval = 0.001
      OutputFile = diagnostics.csv
      mass_integrator_SampleNames = [integral_rho]
      <mass_integrator>
        Type = WmHostAction
        Kind = integrator
        QOld = [fluid.rho]
        QStorage0 = [fluid_1.rho]
        QStorage1 = [fluid_2.rho]
        QStorage2 = [fluid_3.rho]
        <integrator>
          Process = dg_integrator
          Type = WmHostAction
          Kind = patchProcessor
          BasisArraySet = thirdOrder
          <int_q_dv>
            Type = application
            Kind = int_q_dv
            Stage = 0
            Vars = [0]
          </int_q_dv>
        </integrator>
      </mass_integrator>
    </diagnostics>
    <rk>
      Type = WmHostAction
      Kind = explicit_runge_kutta
      Scheme = SSPRK3
      QOld = [fluid.rho]
      QStorage0 = [fluid_1.rho]
      QStorage1 = [fluid_2.rho]
      QStorage2 = [fluid_3.rho]
      <dg>
        Process = spatial_solver.dg
        Type = WmHostAction
        Kind = patchProcessor
        BasisArraySet = thirdOrder
        SourceQuadratureStyle = LGL
        OnSubdomains = [all]
        <advection>
          Type = application
          Kind = advection
          Velocity = [1.0, 0.0, 0.0]
          Density = [0]
        </advection>
      </dg>
    </rk>
    <gsync>
      Type = WmHostAction
      Kind = synchronizer
      WriteVars = [fluid]
    </gsync>
    <swapper>
      Type = WmHostAction
      Kind = variableSwapper
      WriteVars = [fluid, fluid_3]
    </swapper>
    <vloader>
      Type = WmHostAction
      Kind = variableLoader
      SourceFilePrefix = data/advection
      WriteVars = [fluid]
    </vloader>
    <writer>
      Type = WmHostAction
      Kind = writeOut
      ReadVars = [fluid]
      WriteInterval = 1
    </writer>
    <ic_ha>
      Type = WmHostAction
      Kind = va_runner
      Vars = [fluid.rho]
      <ic_va>
        Process = function_evaluator
        Type = WmHostAction
        Kind = patchProcessor
        BasisArraySet = thirdOrder
        Priority = 0
        OnSubdomains = [all]
        <fluid_ic>
          Type = application
          Kind = heaviside_app
          LeftValue = 0.1
          RightValue = 0.6
          OutputVariables = [0]
        </fluid_ic>
      </ic_va>
    </ic_ha>
    <start_only_group>
      Type = WmSequencedGroup
      Kind = hostSequencedGroup
      HostActions = [ic_ha, gsync]
    </start_only_group>
    <write_group>
      Type = WmSequencedGroup
      Kind = hostSequencedGroup
      HostActions = [writer, diagnostics]
    </write_group>
    <swap_group>
      Type = WmSequencedGroup
      Kind = hostSequencedGroup
      HostActions = [swapper]
    </swap_group>
    <vload_group>
      Type = WmSequencedGroup
      Kind = hostSequencedGroup
      HostActions = [vloader, gsync]
    </vload_group>
    <perstep_group>
      Type = WmSequencedGroup
      Kind = hostSequencedGroup
      HostActions = [rk]
    </perstep_group>
    <SolverSequence>
      Type = WmSolverSequence
      StartOnly = [start_only_group]
      PerStep = [write_group, perstep_group, swap_group]
      PreRedoPerStep = [swap_group]
      EndOnly = [write_group]
      Restart = [vload_group]
    </SolverSequence>
  </sim>
</warpxm>
```