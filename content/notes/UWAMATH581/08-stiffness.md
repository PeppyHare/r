---
title: "Stability for Systems and Stiffness"
weight: 80
---

# Stability for Systems and Stiffness

Two more topics: extending absolute stability to systems of ODEs, and stiffness, which sits at the intersection of stability and accuracy.

## Stability for Systems

We extend absolute stability to systems by considering the test problem

{{< katex display >}}
\dv{\vec{u}}{t} = A \vec{u} \qquad \vec{u}(0) = \vec{c}
{{< /katex >}}

where we assume \\( A \\) is diagonalizable, so

{{< katex display >}}
A = Q \Lambda Q^{-1}
{{< /katex >}}

with {{< katex >}} Q \in \mathbb{C}^{d \times d} {{< /katex >}} the matrix of eigenvectors and {{< katex >}} \Lambda \in \mathbb{C}^{d \times d} {{< /katex >}} the diagonal matrix of eigenvalues. Multiplying the ODE by \\( Q^{-1} \\) and letting \\( \vec{z}(t) = Q^{-1} \vec{u}(t) \\),

{{< katex display >}}
\dv{\vec{z}}{t} = \Lambda \vec{z} \qquad \vec{z}(0) = Q^{-1} \vec{c}
{{< /katex >}}

Since \\( \Lambda \\) is diagonal, the system decouples into \\( d \\) independent scalar test ODEs

{{< katex display >}}
\dv{z_i}{t} = \lambda_i z_i \qquad z_i(0) = (Q^{-1} \vec{c})_i
{{< /katex >}}

so everything we know about absolute stability for scalar ODEs applies to each mode. (This works for forward and backward Euler because both commute with the change of variables: e.g. {{< katex >}} \vec{u}_n = (I + \Delta t A)\vec{u}_{n-1} {{< /katex >}} becomes {{< katex >}} \vec{z}_n = (I + \Delta t \Lambda)\vec{z}_{n-1} {{< /katex >}}.)

For forward Euler, we need {{< katex >}} |1 + \Delta t \lambda_i| \leq 1 {{< /katex >}} for every \\( i = 1, \ldots, d \\). When the {{< katex >}} \lambda_i {{< /katex >}} are real and negative,

{{< katex display >}}
0 < \Delta t \leq \frac{2}{\max_i |\lambda_i|}
{{< /katex >}}

so the stability restriction is dictated by the eigenvalue of \\( A \\) with the largest magnitude.

For backward Euler we need {{< katex >}} |1 - \Delta t \lambda_i|^{-1} \leq 1 {{< /katex >}}, i.e. {{< katex >}} |1 - \Delta t \lambda_i| \geq 1 {{< /katex >}}, for every \\( i \\), which holds for any \\( \Delta t > 0 \\) whenever all {{< katex >}} \text{Re}(\lambda_i) < 0 {{< /katex >}}. So backward Euler is still A-stable for systems.

## Stiffness

Stiffness reveals a tension between stability and accuracy. It's somewhat qualitative, so it's best described by example.

### Example: A Stiff Scalar ODE

{{< katex display >}}
\dv{u}{t} = -100 \left( u - \sin(t) \right) \qquad u(0) = 1 \qquad t \geq 0
{{< /katex >}}

Because of the \\( -100 \\), the solution initially decays very rapidly toward \\( \sin(t) \\), which is near zero for small \\( t \\). After this transient, the sinusoid dominates the behavior of the solution.

<p align="center"> <img alt="img/amath581/stiff_backward_euler.svg" src="/r/img/amath581/stiff_backward_euler.svg" width="49%" style="min-width: 0" /> <img alt="img/amath581/stiff_forward_euler.svg" src="/r/img/amath581/stiff_forward_euler.svg" width="49%" style="min-width: 0" /> </p>

<p align="center"><em>The stiff ODE solved with backward Euler (left) and forward Euler (right), against \( \sin(t) \), the dominant mode after the initial transient.</em></p>

Backward Euler stays stable, as expected, even for large \\( \Delta t \\). Forward Euler goes unstable roughly when \\( \Delta t > 2/100 = 0.02 \\), the limit set by \\( \lambda = -100 \\) (the Jacobian \\( \partial f / \partial u \\)).

This is the typical picture of a stiff problem: a severe restriction is imposed on explicit methods like forward Euler, but the fast dynamics responsible only matter for a brief period. Once the transient has passed, the solution could be approximated well with much larger time steps, but the explicit method is still stuck with the small \\( \Delta t \\) for stability. Implicit methods like backward Euler are unconditionally stable, so they handle the stiff phase without excessively small time steps.

### Example: A Stiff Linear System

Stiffness also shows up in systems, where some coordinates have large eigenvalues (fast dynamics) and others have small eigenvalues (slow dynamics). The fast coordinates impose a severe time-step restriction on explicit methods, even though the slow coordinates could be advanced with much larger steps.

{{< katex display >}}
\dv{u_1}{t} = -u_1 \qquad \dv{u_2}{t} = -\lambda (u_2 - u_1) \qquad \left(u_1(0), u_2(0)\right) = (c_1, c_2)
{{< /katex >}}

In matrix form,

{{< katex display >}}
\dv{}{t} \begin{bmatrix} u_1 \\ u_2 \end{bmatrix} = \underbrace{\begin{bmatrix} -1 & 0 \\ \lambda & -\lambda \end{bmatrix}}_{A} \begin{bmatrix} u_1 \\ u_2 \end{bmatrix}
{{< /katex >}}

\\( A \\) is lower triangular, so its eigenvalues are \\( -1 \\) and \\( -\lambda \\). If \\( \lambda \gg 1 \\), the second equation has a much faster timescale than the first and the system is stiff. Solving analytically,

{{< katex display >}}
u_1(t) = c_1 e^{-t} \qquad u_2(t) = \frac{\lambda c_1}{\lambda - 1} e^{-t} + \left( c_2 - \frac{\lambda c_1}{\lambda - 1} \right) e^{-\lambda t}
{{< /katex >}}

For \\( \lambda \gg 1 \\), {{< katex >}} u_2 {{< /katex >}} is pulled toward {{< katex >}} u_1 {{< /katex >}} very quickly (the \\( e^{-\lambda t} \\) transient), while {{< katex >}} u_1 {{< /katex >}} itself evolves slowly. Forward Euler still needs \\( \Delta t \leq 2/\lambda \\) for the entire simulation, even after the fast mode has died out.

### Stiffness Ratio

For a linear system, stiffness can be characterized by the **stiffness ratio**: the ratio of the largest to the smallest eigenvalue magnitude of the system matrix,

{{< katex display >}}
\frac{\max_i |\lambda_i|}{\min_i |\lambda_i|}
{{< /katex >}}

A large stiffness ratio means the system has widely varying timescales. For nonlinear ODEs, we look at the eigenvalues of the Jacobian {{< katex >}} D_{\vec{u}}\vec{f} {{< /katex >}} in the same way, keeping in mind that the Jacobian changes as the solution evolves.

> [!IMPORTANT]
>
> The practical message: if a problem is stiff, it's worth paying the extra computational cost of an implicit method like backward Euler, or another solver specialized for stiffness.
