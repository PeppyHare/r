---
title: "Absolute Stability"
weight: 70
---

# Absolute Stability

In [Accuracy](../05-accuracy/) we introduced convergence and numerical accuracy. A convergent algorithm is the minimum we need for it to be useful: eventually, with enough computing power (small \\( \Delta t \\)), it gives a good approximation to the truth. An order of convergence makes this much stronger, since it tells us exactly how fast the error decays. But accuracy alone isn't quite sufficient to make a method useful, and there's a tension between accuracy and *stability*.

## Absolute Stability on the Test ODE

Recall the test ODE

{{< katex display >}}
\dv{u}{t} = \lambda u \qquad u(0) = c
{{< /katex >}}

and the [experiment](../03-euler-methods/#comparing-forward-and-backward-euler-on-the-test-ode) where forward Euler oscillated wildly for large \\( \Delta t \\) while backward Euler stayed stable. This behavior is so fundamental that the mathematical definition of stability is usually built around the test ODE itself.

The exact solution is \\( u(t) = c e^{\lambda t} \\), so if \\( \text{Re}(\lambda) < 0 \\) the solution decays to zero as \\( t \to \infty \\). Applying forward Euler,

{{< katex display >}}
u_n = u_{n-1} + \Delta t \lambda u_{n-1} = (1 + \Delta t \lambda) u_{n-1}
{{< /katex >}}

and substituting recursively,

{{< katex display >}}
u_n = (1 + \Delta t \lambda)^n u_0
{{< /katex >}}

So the numerical solution decays to zero if and only if

{{< katex display >}}
|1 + \Delta t \lambda| < 1
{{< /katex >}}

If \\( \lambda \\) is real and negative, this is

{{< katex display >}}
-1 < 1 + \Delta t \lambda < 1 \quad \Rightarrow \quad \Delta t < \frac{2}{-\lambda} = \frac{2}{|\lambda|} \equiv \Delta t_{\max}
{{< /katex >}}

So there's a limit on the size of \\( \Delta t \\) if we want the numerical solution to decay like the true one. For complex \\( \lambda \\), the condition says \\( \Delta t \lambda \\) has to lie inside the disk of radius 1 centered at \\( -1 \\).

<p align="center"> <img alt="img/amath581/forward_euler_stability_region.svg" src="/r/img/amath581/forward_euler_stability_region.svg" width="49%" style="min-width: 0" /> <img alt="img/amath581/backward_euler_stability_region.svg" src="/r/img/amath581/backward_euler_stability_region.svg" width="49%" style="min-width: 0" /> </p>

<p align="center"><em>Regions of absolute stability (shaded) in the \( z = \lambda \Delta t \) plane. Left: forward Euler. Right: backward Euler.</em></p>

### Why the Test ODE?

Why do we care about this particular problem decaying to zero? Suppose we've computed {{< katex >}} \{u_n\}_{n=0}^{N-k} {{< /katex >}} with forward Euler, and a small perturbation gets into the last estimate, {{< katex >}} u_{N-k} \leftarrow u_{N-k} + \epsilon {{< /katex >}}. This happens all the time due to round-off error. Forward Euler then continues with

{{< katex display >}}
u_{\epsilon, N-k+j} = (1 + \Delta t \lambda)^j (u_{N-k} + \epsilon) \qquad j = 1, 2, \ldots, k
{{< /katex >}}

so the error {{< katex >}} \delta u_{N-k+j} = u_{\epsilon, N-k+j} - u_{N-k+j} {{< /katex >}} satisfies

{{< katex display >}}
\delta u_{N-k+j} = (1 + \Delta t \lambda)^j \epsilon \qquad j = 1, 2, \ldots, k
{{< /katex >}}

We'd prefer this perturbation not grow. The amplification factor \\( (1 + \Delta t \lambda) \\) is the same one that governs the solution itself.

### Why Only the Linear ODE?

How does this relate to stability for nonlinear problems? Consider

{{< katex display >}}
\dv{u}{t} = f(u) \qquad u(0) = c
{{< /katex >}}

with true solution \\( u(t) \\). Suppose we make small errors, in the initial condition or in evaluating \\( f \\), giving a perturbed solution \\( v(t) = u(t) + \epsilon(t) \\). Substituting into the ODE,

{{< katex display >}}
\dv{\epsilon}{t} = f(u + \epsilon) - f(u) = \pdv{f}{u}(u) \, \epsilon + \text{higher order terms}
{{< /katex >}}

So, roughly, the perturbation solves a linear ODE like the test ODE, except the coefficient \\( \lambda \to \partial f / \partial u (u(t)) \\) depends on time. At least over short time intervals, the perturbation stays controlled if

{{< katex display >}}
\left| 1 + \Delta t \pdv{f}{u}(u) \right| \leq 1
{{< /katex >}}

## Formal Definitions

> [!NOTE]
>
> ### Definition: **Absolute stability**
>
> Consider the test ODE with \\( \lambda \in \mathbb{C} \\), \\( \text{Re}(\lambda) < 0 \\). Suppose {{< katex >}} \{u_n\}_{n=0}^{\infty} {{< /katex >}} is a numerical solution produced by an ODE solver. The solution is **absolutely stable** if
>
> {{< katex display >}}
|u_n| \leq |u_{n-1}| \qquad n = 1, 2, \ldots
{{< /katex >}}

> [!NOTE]
>
> ### Definition: **Region of absolute stability**
>
> For a given method, the **region of absolute stability** is the set of all \\( z = \lambda \Delta t \in \mathbb{C} \\) for which the numerical solution of the test ODE is absolutely stable.

For forward Euler this region is {{< katex >}} \{ z \in \mathbb{C} : |1 + z| \leq 1 \} {{< /katex >}}, and for backward Euler (below) it's {{< katex >}} \{ z \in \mathbb{C} : |1 - z| \geq 1 \} {{< /katex >}}.

> [!NOTE]
>
> ### Definition: **A-stability**
>
> A method is **A-stable** if its region of absolute stability contains the entire left half of the complex plane, \\( \text{Re}(z) < 0 \\).

So forward Euler is *not* A-stable, while backward Euler is.

## Stability of Backward Euler

We can finally make sense of the difference we saw between forward and backward Euler. Applying backward Euler to the test ODE,

{{< katex display >}}
u_n = u_{n-1} + \Delta t \lambda u_n
\quad \to \quad
u_n = (1 - \Delta t \lambda)^{-1} u_{n-1}
{{< /katex >}}

so

{{< katex display >}}
|u_n| = \left| (1 - \Delta t \lambda)^{-1} \right| |u_{n-1}|
{{< /katex >}}

If \\( \text{Re}(\lambda) < 0 \\), then {{< katex >}} |1 - \Delta t \lambda| \geq \text{Re}(1 - \Delta t \lambda) = 1 - \Delta t \, \text{Re}(\lambda) > 1 {{< /katex >}}, so the amplification factor is less than 1. Backward Euler is absolutely stable for *any* \\( \Delta t > 0 \\) whenever \\( \text{Re}(\lambda) < 0 \\). Its region of absolute stability is the whole complex plane minus the open disk of radius 1 centered at \\( +1 \\).

This has profound practical implications: we can take as large a step as we want without worrying about instabilities.

> [!WARNING]
>
> Stability does not mean accuracy! Large time steps still give larger errors. Stability only ensures that perturbations don't grow uncontrollably.
