---
title: "Valgrind"
bookToc: true
---

{{< katex display >}}
{{< /katex >}}

# Valgrind

[Valgrind](https://valgrind.org/) is an instrumentation framework which supplies several very useful debugging and profiling tools. Among these are the popular `memcheck`, which thoroughly checks for incorrect memory access, and `cachegrind`, which profiles the CPU usage of a program. I have found this to be a really well-designed, useful tool to measure the performance of a WARPXM run, without the need to add any custom instrumentation to the code.


## How it works

Valgrind adds instrumentation to any existing executable by intercepting all instructions from the unmodified code and emulating the CPU, adding instrumentation code in the middle. There is no need to modify the existing code to obtain profiling measurements, just run `valgrind` directly against the executable, for example:

```
valgrind --tool=callgrind /path/to/target/release/warpxm -i input.inp
```

Simple as that!

## Cachegrind vs. Callgrind

Callgrind and cachegrind are two Valgrind profiling tools that serve very similar functions. Both attempt to profile the runtime cost of your program, giving you a breakdown of how much "cost" was associated with each function call. The exact meaning of "cost" differs by tool, as described below. The profiling data is written to a file named e.g `cachegrind.out.<pid>
` where `<pid>` is the process ID of the userspace process.

### Cachegrind

Cachegrind is a profiling tool that is meant to be **reproducible**. Rather than measuring the execution time of the program, it attempts to measure the exact number of CPU instructions executed by the program. This provides an extremely precise measurement of the best-case performance of the program which is identical from run to run, and is not subject to the usual noisy measurement problems that time-based profilers face.

### Callgrind

Callgrind is a profiling tool that records call history events (data reads, cache misses, etc.) and attributes the cost of each event to the relevant function (and its parents, up the call stack).


## Reading Cachegrind output

