---
title: "WARPXM 102 - Code Structure"
bookToc: true
---

{{< katex display >}}
{{< /katex >}}

# What Happens When You Press Go?

Following the sequence of events that take place in a WARPXM simulation by stepping through in the debugger has helped me to understand the code structure and concepts. I would highly recommend going through the process at least once. I have tried to explain what happens in plain English in the hopes that it will help me (and maybe someone else) to better understand how things are structured and what to expect when working with WARPXM.

There are some code listings (as they appear in the WARPXM code base) included for context that can be expanded by clicking on them.

## Entrypoint

{{< details title="`warpxm.cc: int main(int argc, char** argv)`" open=false >}}

```c++
int main(int argc, char** argv)
{
    if (!warpxm_init(argc, argv)) { exit(-1); }
    int res = 0;
    // run top level warpxm main
    res = warpxm_main(argc, argv);
    warpxm_finalize();

    return res;
}
```

{{< /details >}}

The entrypoint for `warpxm` is simple, there are just three calls: `warpxm_init()`, `warpxm_main()`, and `warpxm_finalize()`. We don't need to pay much attention to `warpxm_init`, since it just initializes the MPI and PETSc frameworks. MPI is the message-passing framework that allows for massive parallelization. PETSc is a toolkit that helps us use MPI, parse command-line options, create meshes, and other things.

`warpxm_main` is similarly high level:

{{< details title="`warpxm.cc: int warpxm_main(int argc, char** argv)`" open=false >}}

```c++
int warpxm_main(int argc, char** argv)
{
    // ...

    // create new WARPXM simulation using the command line args
    WmSimulation sim;

    // Parse the input command
    bool res = sim.parseCmdLine();
    if (res) { return 0; }

    // Read in the input file
    std::ifstream inp(sim.getInpFileName().c_str());
    // ... error checking ...

    // Convert input file to a string
    std::string inputStr((std::istreambuf_iterator<char>(inp)),
                         std::istreambuf_iterator<char>());
    inp.seekg(0);

    // Store the input file in the simulation
    sim.setInputFileText(inputStr);

    // create cryptset for simulation
    WxCryptSet inputSet(inp);

    // Step one - setup the simulation
    sim.setup(inputSet);

    // Step two - run the simulation
    sim.simulate();

    // Step three - drink to your success

    return 0;
}
```

{{< /details >}}

- Initialize our `WmSimulation` object. Nothing much happens when we init this other than creating a message-passing client (`WxMpiMsg`) and HDF5 i/o client (`WxHdf5Io`) that will be used to read/write data.
- Parse the command-line options, simply reading the values of command-line flags.
  - `-input-file`/`-i` populates `inpFileName` with the input file contents, for parsing
  - `-run-name`/`-n` populates `sim.runName`
  - `-restart-from-frame`/`-f` or `-restart-auto`/`-r` will populate `sim.restartFrame`
  - If `-debug` was passed, the process waits for a debugger like `gdb` or `lldb` to attach to the process and allow things to continue.
- Turn the input file into a proper `WxCryptSet`, which is an immutable, nested map of name-value pairs for which each name is a string and each value is a native-type object, array of native objects, or another nested `WxCrypt`. I like to think about `WxCryptSet` as a thread-safe place to look up values which are global across the whole sim and which do not ever change, similar to the `Context` [objects used in Python's multiprocessing module](https://docs.python.org/3/library/multiprocessing.html#multiprocessing-managers).
  - This step involves parsing the full text of the input file, as described in https://faculty.washington.edu/shumlak/WARPX/html/warpxm_input.html
- Then, we do `sim.setup` and `sim.simulate` which cover the entire simulation

## Setup

{{< details title="`wmsimulation.cc: void WmSimulation::setup(const WxCryptSet& wxc)`" open=false >}}

```c++

void WmSimulation::setup(const WxCryptSet& wxc)
{

    // determine run name
    if (wxc.has("RunName"))
    {
        std::string possibleRunName = wxc.get<std::string>("RunName");
        if (possibleRunName[0] == '/')
        {
            // This is a filename from root
            runName = possibleRunName;
        }
        else
        {
            // This is a filename in the current directory
            size_t trnc = inpFileName.find_last_of("/");
            if (trnc != std::string::npos)
            {
                runName = inpFileName.substr(0, trnc) + "/" + possibleRunName;
            }
            else
            {
                runName = possibleRunName;
            }
        }
    }
    else if (runName == "")
    {
        runName = stripName(inpFileName);
    }

    // create WarpX root logger
    WxLogger* wr = WxLogger::get("warpx-root");

    // set root logger's verbosity level
    std::string level;
    if (wxc.has("GlobalVerbosity"))
        level = wxc.get<std::string>("GlobalVerbosity");
    else
        level = "debug";
    wr->setLevel(level);

    // add file handler to root logger
    std::ostringstream fn;
    fn << runName << "_" << this->getMsg().rank() << ".log";
    WxLogRecordHandler* wrfhndl = new WxFileHandler(fn.str());
    wr->addHandler(wrfhndl);

    // create WarpX console logger
    WxLogger* wrc = WxLogger::get("warpx-root.console");

    // set console logger's verbosity level
    if (wxc.has("Verbosity"))
        level = wxc.get<std::string>("Verbosity");
    else
        level = "debug";
    wrc->setLevel(level);

    // add stream handler to console
    WxLogRecordHandler* wrshndl = new WxStreamHandler();
    if (this->getMsg().rank() == 0)
        // add console stream only on rank 0
        wrc->addHandler(wrshndl);

    // get output streams from newly created loggers
    WxLogStream debStrm = wrc->getDebugStream();
    WxLogStream infoStrm = wrc->getInfoStream();
    WxLogStream errStrm = wrc->getErrorStream();
    WxLogStream wrnStrm = wrc->getWarningStream();

    //////////////////////////////

    // now setup top level solver
    debStrm << "Setting up WARPXM simulation..." << std::endl;
    std::string simName;
    // name of simulation to run
    if (wxc.has("Simulation"))
    {
        simName = wxc.get<std::string>("Simulation");
    }
    else
    {
        // no simulation specified, so throw exception
        WxExcept wxe("No Simulation key found in ");
        wxe << inpFileName << std::endl;
        throw wxe;
    }

    if (!wxc.hasSet(simName))
    {
        // solver not found
        WxExcept wxe("ERROR: Solver set ");
        wxe << simName << " not found" << std::endl;
        throw wxe;
    }

    // get hold of solver's cryptset
    const WxCryptSet& solverCrypt = wxc.getSet(simName);
    debStrm << "Simulation name is " << simName << std::endl;
    // while the general class structure is setup to handle registration and WxCreator
    // process for getting new instances of WmSolverBase types
    // as is done elsewhere in the code for WmVariables, and WmHostActions, for example,
    // we have not implemented this functionality because
    // there has only ever been one class implementation, WmSolver.
    // To mimick the formatting at other levels of the crypt set, we at least check that
    // the Type and Kind fields match what they should be.
    if (solverCrypt.has("Type"))
    {
        std::string solverTypeStr = solverCrypt.get<std::string>("Type");
        if (solverTypeStr != "WmSolverBase")
        {
            WxExcept wxe("Unrecognized Type field in input file for Simulation ");
            wxe << simName << ".  Only 'WmSolverBase' currently supported.";
            throw wxe;
        }
    }
    else
        throw WxExcept("Simulation 'Type' field missing in input file.");

    if (solverCrypt.has("Kind"))
    {
        std::string solverKindStr = solverCrypt.get<std::string>("Kind");
        if (solverKindStr != "WmSolver")
        {
            WxExcept wxe("Unrecognized Kind field in input file for Simulation ");
            wxe << simName << ". Only 'WmSolver' currently supported.";
            throw wxe;
        }
    }
    else
        throw WxExcept("Simulation 'Kind' field missing in input file.");

    // create new solver
    solver = new WmSolver(this);

    // set I/O for use in solver
    solver->setIo(this->getIo());
    // set msg for use in solver
    solver->setMsg(this->getMsg());
    // setup solver
    solver->setup(solverCrypt);
}
```

{{< /details >}}

A lot of things going on in `WmSimulation::setup`!

- Less important initialization: Ensure we have a `runName`, initialize the `WxLogger` loggers
- Create a `WmSolver` and give it the same i/o and message clients as the `sim`
- Run `WmSolver.setup` with the `<sim>` node of the input file as input
  - Sets the start and end times of the sim.
  - If the sim is being restarted (one of the restart command-line flags was passed), figure out the appropriate frame we should start at.
  - Set up the simulation domain
  - Create any variables defined in the input file
  - Initialize all host actions

### Domain Setup

- Create a `WmDomain` object and run `WmDomain.setup`
  - Figure out how many different MPI processes are relevant, based on the `NumPartitions` field in the input file
  - Create a `mesh` from the `<mesh>` node of the input file
    - If the sim is being restarted, look for the appropriate mesh `.h5` file in the working directory, and error if not found
    - Generate the appropriate type of mesh. This is usually a block mesh (`block_mesh`) which just contains equally-spaced cells, but can also be an arbitrary mesh.
    - Write the generated mesh definition to a file, e.g. `block_mesh_abd3712ea51f965c.inp`
    - Break the mesh up into `WmUnstructuredPatch` patches so that it can be distributed across however many MPI processes we have.
    - Generate the appropriate geometry for each patch. For any local patches (patches which should be managed by the current MPI process), we generate the full mesh geometry as a `WmUnstructuredGeometry`, which is the basic structure we use to represent the geometric nodes for the mesh. Once the mesh is generated, we dump the mesh for each patch as an h5 file (`restartMesh...`) so that we may restart the simulation at a later time without needing to re-generate the geometry.
    - We use DG basis elements to represent the mesh, so we also export the basis decomposition for the patch domain as an h5 file (`plotMesh...`), so that it is possible to reconstruct the physical geometry for later plotting and analysis

### Variable Setup

- For each variable defined in the input file (everything of `Type = variable`) we initialize that variable setting its basis according the domain we computed above
- For the hybrid kinetic solver, we additionally compute bases for the velocity space elements here.
- Variables are not set to their initial values yet; that is done by a variable adjuster host action (`va_runner`) next

### Host Action Initialization

- Each host action (`Type = WmHostAction|host_action|subsolver`) gets setup and inserted into the hostActions map. Different types of host action have different setup steps and effects. There are <a href="/r/img/research/warpxm/classdiagram-hostaction.png">a lot</a> of different types that directly extend `WmHostAction` in WARPXM, but the top-level ones relevant to most sims are:
  - **Time Integrator**: The time integrator that moves the state forward in time. This will almost always be the explicit Runge-Kutta temporal solver.
  - **Patch Processors**: This coordinates patch processes across the domain. Patch processes are any process which can be evaluated locally within a single patch. For example, the spatial solver is a patch process which is called by the time integrator host action to compute \\( \pdv{q}{t} \\) (by implementing the nodal discontinuous Galerkin method). Variable adjusters which set/modify the value of variables across the domain are another common example, and are used to set initial conditions as we'll see later.
  - **Writers**: Two types of writer: frame writers and diagnostic writers. A frame writer dumps the current variables to disk in HDF5 format each frame. The frame writer only needs to write the current data for the local patch, as opposed to diagnostic writers which are typically used to integrate variables across the global domain. Diagnostics can be `Probe`s (simply retrieve the current value of variables) or `WmIntegrator`s (integrate an expression over the domain or a subdomain). At pre-defined time intervals, the diagnostics writer evaluates each defined diagnostic and writes the result to a CSV file.
  - **Synchronizer** When we require data that spans patches hosted on different MPI processes, an asynchronous process is required to manage the requesting and copying of that data.

## Solve

This is where the real work happens, so we need to pay extra attention here

{{< details title="`wmsolver.cc: void WmSolver::solve()`" open=false >}}

```c++

void WmSolver::solve()
{
    WxLogger* log = WxLogger::get("warpx-root.console");
    WxLogStream infStrm = log->getInfoStream();
    WxLogStream debStrm = log->getDebugStream();
    WxLogStream errStrm = log->getErrorStream();
    presolve();

    real frame_time = (_tend - _tstart) / _nout;
    auto start_time = getCurrentTime();
    auto start_frame = getCurrentFrame();

    wxm::timer::TIMER.start(wxm::timer::ROOT_TIMING_SCOPE);

    for (size_t i = getCurrentFrame(); i < _nout; ++i)
    {
        auto frame_stop_time = start_time + (i + 1 - start_frame) * frame_time;
        infStrm << "Advancing solution starting at time " << getCurrentTime() << " to "
                << frame_stop_time << "...\n";

        // Instantiate a new timer and most restrictive timestep constraint
        WxTimer advTimer;
        TimestepConstraint most_restrictive_tc;

        // Perform frame advance, catch any exception.
        advTimer.startTimer();
        try
        {
            most_restrictive_tc = advance(frame_stop_time);
        }
        catch (WxExcept wxe)
        {
            infStrm << "Exception caught, simulation exiting. See error log for details." << std::endl << std::endl;

            errStrm << "\nException caught in wxm::wmsolver::solve() at t = " << getCurrentTime() << std::endl;
            errStrm << wxe.what() << std::endl << std::endl;
            exit(EXIT_FAILURE);
        }
        advTimer.stopTimer();

        // Report on frame advance
        infStrm << "Advanced from frame " << getCurrentFrame() << " to "
                << getCurrentFrame() + 1 << " in " << advTimer.timeElapsedAsString()
                << ". ";
        infStrm << "Current dt = " << getDt() << "\n";

        // Report the most restrictive tc among each frame
        infStrm << "Most restrictive timestep constraint this period was:\n";
        infStrm << "\t{dt = " << most_restrictive_tc.getDt() << ", "
                << "physics = '" << *most_restrictive_tc.getPhysics() << "', "
                << "x = (" << most_restrictive_tc.getX()[0] << ", "
                << most_restrictive_tc.getX()[1] << ", " << most_restrictive_tc.getX()[2]
                << ")}\n\n";

        // Walltime report in the debug stream
        wxm::timer::TIMER.print_timings(debStrm);

        incrementCurrentFrame();
    }

    // upon completing the all specified simulation, run EndOnly steps
    debStrm << "\nRunning EndOnly steps...\n" << std::endl;
    endOnly();

    // Walltime report
    wxm::timer::TIMER.print_timings(infStrm);
}

```

{{< /details >}}

### Pre-solve Actions

- First, we run through the `presolve` steps:
  {{< details title="`wmsolver.cc: void WmSolver::presolve()`" open=false >}}
```c++
void WmSolver::presolve()
{
    // fetch stream for logging messages
    WxLogger* log = WxLogger::get("warpx-root.console");
    WxLogStream infStrm = log->getInfoStream();
    WxLogStream debStrm = log->getDebugStream();

    const bool fromRestart = (getCurrentFrame() != 0);

    // initialize hostactions
    for (auto& ha : _hostActions)
    {
        ha.second->init();
    }

    // initialize subsolvers
    for (auto& ss : _subSolvers)
    {
        ss.second->init();
    }

    // Run the initialization steps
    if (fromRestart)
    {
        // run startOnly subsolvers
        debStrm << "Running Restart steps...\n" << std::endl;
        restart();
    }
    else
    {
        // run startOnly subsolvers
        debStrm << "Running StartOnly steps...\n" << std::endl;
        startOnly();
    }
}
```
  {{< /details >}}
  - Call the optional `init()` function for each defined host action and sub-solver
  - Then, we perform a single `ha->step()` for each host action in the sim's `start_only_group` list. Per the definition in the parent `WxStepper` class, the `step()` method for a host action must advance the state of the object by the assigned time step dt, getDt(). This is where we set the initial conditions for each defined variable. In warpy, these are defined by supplying a list of variable adjusters to the `initial_conditions` parameter of a `warpy.dg_sim` object.
    - For a `va_runner` host action, `step()` means:
      - For each variable adjuster in the host action, call `va->solve(time, variables_)` to update `variables_` as appropriate for the current time. In doing so, we need to look up the local patch arrays for the variables being adjusted, loading the physical geometry (e.g. `(x,y,z)`, `(dx, dy, dz)`) from the basis for element in the patch, and evaluating each `WmApplication` in the application list for this variable adjuster on each element in the patch.

### Main Loop

- In the main loop, we try to advance the solution from the current frame (0 at the start) to the next frame until we reach the end of the time interval (the last frame). The total number of frames we need to advance is the total number of write-out steps specified in the input file. For example, if our input file has `Time = [0, 10.0]` and `Out = 100` in the top-level `<sim>` block, we will have 100 frames that correspond with `t = [0.0, 0.1, 0.2, ..., 10.0]`. Each pass of the `for (size_t i = getCurrentFrame(); i < _nout; ++i)` loop calls `WmSolver::advance()` to advance to the next frame.
- In between each frame, we write out informational log messages (that show the amount of actual time we took to advance to the next frame and the value of the most restrictive timestep) to provide some feedback while the sim is running.

  {{< details title="`wmsolver.cc: TimestepConstraint WmSolver::advance()`" open=false >}}
```c++

TimestepConstraint WmSolver::advance(real tend)
{
    WxLogger* log = WxLogger::get("warpx-root.console");
    WxLogStream debStrm = log->getDebugStream();
    WxLogStream infStrm = log->getInfoStream();

    unsigned nstep = 1;
    auto tstart = getCurrentTime();
    // This says to not set the timestep below this limit
    const real limit_dt = std::max(std::fabs(tend), std::fabs(tstart)) * 100.0 *
                          std::numeric_limits<real>::epsilon();

    const real limit_t = tend * (1 - 5 * std::numeric_limits<real>::epsilon());

    WxMsgBase& msg = getMsg();

    TimestepConstraint most_restrictive_tc = TimestepConstraint();

    // loop advancing solution using adaptive time-stepping
    while (getCurrentTime() < limit_t)
    {
        auto t = getCurrentTime();
        auto dt = getDt();
        if (!flexible_writeout)
        {
            dt = std::min<real>(dt, limit_t - t);
        }

        // Instantiate new iterations total and timestep constraint
        int iters;
        std::shared_ptr<TimestepConstraint> tc;

        // Take time step
        auto tmp = step_dt(dt, limit_dt);
        iters = tmp.first;
        tc = tmp.second.get_tc();

        // Let user know that the step has ended
        debStrm << " Ending Step " << nstep << " after " << iters + 1
                << " attempts for t = " << t << " -> " << getCurrentTime()
                << " using dt = " << tc->getDt() << std::endl;

        // Report the physics and location that restrict the time step dt
        debStrm << "\t tc = {dt = " << tc->getDt() << ", "
                << "physics = '" << *(tc->getPhysics()) << ", "
                << "x = (" << tc->getX()[0] << ", " << tc->getX()[1] << ", "
                << tc->getX()[2] << ")}\n\n";

        setDt(tc->getDt());
        most_restrictive_tc = TimestepConstraint::minDt(*tc, most_restrictive_tc);

        ++nstep;
    }

    return most_restrictive_tc;
}

```
  {{< /details >}}

- Note that within `advance()`, we have a `while (getCurrentTime() < limit_t)` loop to increment forwards in time. We continue stepping until we have reached the next frame, which could require many many individual `dt` timesteps.
- On the first step, the solver attempts to advance time by the `dt_controller`'s initial `dt`. Subsequent steps may try to advance by a larger or smaller `dt` if the `dt_controller` provided in the input file is not a `time_stepper.fixed_dt`.
- For each host action in the per-step group, we tick forward with `host_action->step()`
  - We can peek at `tools/warpy/dg_sim.py` to see what host actions should be the per-step group for a DG sim. With some abbreviation, we see:
    {{< details title="`tools/warpy/dg_sim.py: dg_sim.__init__()`" open=false >}}

```python
# w_group is the group of writer host actions provided in the warpy input file
w_group = solver_sequence.sequence_group(name='write_group', actions=writers)
# ps_group contains the temporal solvers provided in the warpy input file,
# sandwiched between any optional pre- or post-time-integration actions
ps_group = solver_sequence.sequence_group(
  name='perstep_group',
  actions=pre_ti_host_actions + temporal_solvers + post_ti_host_actions
)
# swap_group
swapper = host_actions.swapper(
  name='swapper',
  srcs=[v.name(0) for v in evolve_vars],
  dsts=[v.name(v.output_stage if (hasattr(v, 'output_stage')) else None) for v in evolve_vars]
)
swap_group = solver_sequence.sequence_group(name='swap_group', actions=[swapper])
# So per-step host actions are the writers, followed by the temporal solvers, followed by swappers
ps_step = [w_group, ps_group, swap_group]
ss = solver_sequence.solver_sequence(
  start_only=so_step,
  per_step=ps_step,
  per_redo_per_step=r_step,
  end_only=eo_step,
  restart=res_step
)
super(dg_sim, self).__init__(solver_sequence=ss, ...)
```
      {{< /details >}}
    - The big one is of course the temporal solver. For pretty much everything we're using WARPXM for, that's going to be a `Kind = explicit_runge_kutta` host action (the implicit solver still exists but is rarely used), which maps to a `WmTemporalSolver_RK`.

      {{< details title="`src/dfem/temporal_solvers/wmtemporalsolver_rk.h: WxStepperStatus WmTemporalSolver_RK::step()`" open=false >}}

```c++
WxStepperStatus WmTemporalSolver_RK::step()
{
    wxm::timer::TIMER.start("rk_solver/step");
    time_t time = getCurrentTime();
    time_t dt = getDt();
	std::shared_ptr<TimestepConstraint> sugg_tc = std::make_shared<TimestepConstraint>();
    for (int rk_stage = 0; rk_stage < scheme_->getNumStages(); rk_stage++)
    {
        const real current_time = time + scheme_->getTimeUpdate(rk_stage) * dt;
        variables_type& q_n = variables_[rk_stage];
        variables_type& q_p = variables_[rk_stage + 1];

        // zero out q_p which are temporal vars
        fill_local(rk_stage + 1);
        // TODO: this is only here until zero_fluxes is implemented with scopes
        for (auto& ss : spatial_solvers_)
        {
            ss->zero_fluxes();
        }
        // run all variable adjusters
        {
            size_t idx = 0;
            for (size_t i = min_priority; i <= max_priority; ++i)
            {
                while (idx < va_priorities.size() && va_priorities[idx] <= i)
                {
                    adjusters_[idx]->solve(current_time, q_n);
                    adjusters_[idx]->Barrier(getMsg(), current_time, q_n);
                    ++idx;
                }
                wxm::timer::TIMER.start("rk_sync");
                // Initiate syncing on every MPI rank
                start_sync(rk_stage);
                // Wait for syncing to finish
                finish_sync(rk_stage);
                wxm::timer::TIMER.stop();
            }
        }

        // run the spatial solvers
        for (auto& ss : spatial_solvers_)
        {
			std::shared_ptr<TimestepConstraint> tc = ss->solve(current_time, q_n, q_p);
            // Comparing spatial_solver's suggested time step with current minimum suggested time step.
            // Updating sugg_tc if new minimum
            *sugg_tc = TimestepConstraint::minDt(*sugg_tc, *tc);

            ss->Barrier(getMsg(), current_time, q_p);
        }
        // rhs is now in q_p; need to accumulate with previous q's to get actual q_p
        scheme_->calc_stage(rk_stage, temporal_vars_, variables_, dt);

        wxm::timer::TIMER.start("rk_sync");
        // Initiate syncing on every MPI rank
        start_sync(rk_stage + 1);
        // Wait for syncing to finish
        finish_sync(rk_stage + 1);
        wxm::timer::TIMER.stop();
    }

    wxm::timer::TIMER.stop(); // for "rk_solver/step"

    // TODO: how to get time step limit to take into account sources/diffusion/advection?
    return WxStepperStatus(dt <= sugg_tc->getDt(), sugg_tc);
}
```
{{< /details >}}

The Runge-Kutta temporal solver has multiple "stages", depending on the temporal order specified in the input file. These stages are the standard Runge-Kutta intermediate approximations of the solution in between `t` and `t + dt` which are combined in a weighted average to advance the solution. For each stage:
- Run any variable adjusters associated with the temporal solver. In the case of the `advection.py` example, we use a shock-capturing limiter (`warpy.variable_adjusters.limiters.dg_moe_rossmanith`) which enforces local bounds on variables by damping the high-order corrections.
- The DG spatial solver comes next, and this is where the really heavy lifting happens. The actual flux calculations are up to the `WmApplication`(s) that we've defined in our input file. To express the physics of the problem in the language of DG, an application can define:
    - `numerical_flux()`: Compute boundary flux over the surface of a DG element
    - `internal_flux()`: Compute volume flux within a DG element
    - `source()`: Contribute a source/sink term
    - `bc_q()`: Set the value of "ghost" nodes on the domain boundary
    - `bcNumericalFlux()`: Conpute boundary flux for element faces on the domain boundary

I don't pretend to fully understand the DG implementation in WARPXM just yet, so I may get some things slightly wrong here. As far as I can tell, the calculation of $\pdv{q}{t}$ has been intentionally broken up into three separate "kernel" methods: `in_kernel`, `ex_kernel`, and `rhs_kernel`. In this case, use of the word "[kernel](https://en.wikipedia.org/wiki/Compute_kernel)" is meant to indicate that these are the inner-most methods where the real number crunching happens.
1. `in_kernel`: Compute the internal flux within each DG element
    - If there are apps with sources that require computing Gaussian quadrature, we compute those quadrature points and call `app->source()` to allow the app to do its thing and compute the source flux on the element.
    - After loading the variables and node geometry for the current patch, the internal flux computation is all up to the application when we call `app->internal_flux()` for each app to compute the internal flux on the element.
2. `ex_kernel`: Compute the flux across each face of the element. For each app we call `app->numerical_flux()` to get the flux for each element face. Then, for the boundary conditions, we collect the set of boundary faces in the patch and for each one we find applications that supply a `bcNumericalFlux()` function and call it, summing up the results.
3. `rhs_kernel`: This is basically just combining the individual terms together into the right-hand-side of eq. 3.3.21 from [Iman's dissertation](https://www.proquest.com/dissertations-theses/domain-hybridized-plasma-model-using/docview/2594528326/se-2?accountid=14784):
{{< katex display >}}
\underbrace{\pdv{}{t} q_{ij} ^ \lambda}_{\text{rhs\_kernel}} = \underbrace{J_ {ml} ^\lambda \Upsilon _{jlk} f^ \lambda _{imk}}_{\text{in\_kernel}} - \underbrace{\sum_{\gamma \in \tilde{\Gamma} _\lambda} G_{\lambda \gamma} \Xi _{jk} ^{\lambda \gamma} F_{ik} ^{\lambda \gamma} + \Psi _{jk} s_{ik} ^{\lambda}}_{\text{ex\_kernel}}
{{< /katex >}}
where $f^\lambda _{imk}$ is the internal flux computed above, $F _{ik} ^{\lambda \gamma}$ is the external flux computed above, $s _ {ik} ^{\lambda}$ is the source flux, and $ J _ {ml} ^\lambda \Upsilon _ {jlk} $, $ G _ {\lambda \gamma} \Xi _ {jk} ^{\lambda \gamma}$, and $\Psi _ {jk}$ are computed directly from the geometry and nodal basis for each element.

- Each of these flux calculations and patch processes results may produce a timestep constraint, which gives the minimum allowable `dt` for the next step based on e.g. CFL condition. We always take the smallest constraint before moving forward.

- Finally, once we've (hopefully) stepped all the way to the final frame, each host action in the end-only-group (typically just the writers) gets a `step()` to write out the final frame's data, and the sim is done!


### Class diagrams

When trying to visualize how the different classes in the WARPXM codebase interact, I found it useful at some points to refer to class hierarchy diagrams. These diagrams can ge benerated to show the inheritance hierarchy of all classes in the C++ code from top (parent) to bottom (child). These diagrams can be generated as part of the Doxygen documentation by setting `CLASS_DIAGRAMS = true` and `HAVE_DOT = true` in the [doxygen input file](https://github.com/UW-Computational-Plasma-Group/warpxm/blob/master/doxyfile.in) and re-building the documentation. Need to make sure that [graphviz](https://www.graphviz.org/) is installed locally in order to draw the generated diagrams.

Class diagrams generated by Doxygen showing all the different implementations of patch processes we've currently got:

<p align="center"> <img alt="img/research/warpxm/classdiagram-WmPatchProcess.png" src="/r/img/research/warpxm/classdiagram-WmPatchProcess.png" /> </p>
<p align="center"> <img alt="img/research/warpxm/classdiagram-variable_adjuster_t.png" src="/r/img/research/warpxm/classdiagram-variable_adjuster_t.png" /> </p>


## Let's try to go through the same exercise, but for the ndg_kinetic solver

I'm interested in the kinetic solver in particular. It would be useful to follow the same steps for an input file that uses the `dg_kinetic` solver.

## Setup

The first difference is in the `WmSolver::setup` step that comes within `WmSimulation::setup` as previously discussed. The kinetic spatial solver is a patch action, 