---
title: "Motivating Numerical Methods for BVPs"
weight: 120
---

# Motivating Numerical Methods for BVPs

So far we've focused on IVPs: ODEs with initial conditions at a given time, solved with time-marching methods. IVPs have a natural interpretation as dynamic phenomena simulated forward in time. Now we turn to [BVPs](../02-ivps-and-bvps/#general-form-of-a-bvp), problems of the form

{{< katex display >}}
\frac{\dd^n u}{\dd t^n} = f\left(t, u, \dv{u}{t}, \ldots, \frac{\dd^{n-1} u}{\dd t^{n-1}}\right) \qquad a < t < b
{{< /katex >}}

subject to boundary conditions

{{< katex display >}}
\vec{g}(u, a, b) = 0
{{< /katex >}}

BVPs are different in nature from IVPs, and their analytic solutions are generally hard to write down. There's no sense of "marching forward in time", since boundary conditions can be imposed at several points.

## Poisson's Equation

As a prototypical BVP, take Poisson's equation in 1D

{{< katex display >}}
\frac{\dd^2 u}{\dd t^2} = f(t) \qquad t \in (0, 1)
{{< /katex >}}

with Dirichlet boundary conditions

{{< katex display >}}
u(0) = c_0 \qquad u(1) = c_1
{{< /katex >}}

This models many physical phenomena, e.g. the steady-state distribution of heat in a long beam. Proceeding as we did for IVPs, we could rewrite it as a first-order system

{{< katex display >}}
\dv{u}{t} = z \qquad \dv{z}{t} = f(t)
{{< /katex >}}

but we quickly realize we have no initial condition for \\( z \\), and it's unclear how to impose \\( u(1) = c_1 \\). Our IVP methods no longer apply.

The *idea* behind IVP solvers still works, though: approximate derivatives to get algebraic equations we can solve. Use the centered difference

{{< katex display >}}
\frac{\dd^2 u}{\dd t^2}(t) \approx \frac{u(t - \Delta t) - 2u(t) + u(t + \Delta t)}{\Delta t^2} = \frac{u_{n-1} - 2u_n + u_{n+1}}{\Delta t^2}
{{< /katex >}}

with {{< katex >}} t_n = n \Delta t {{< /katex >}}, {{< katex >}} f_n = f(t_n) {{< /katex >}}, and \\( N \\) grid intervals (\\( \Delta t = 1/N \\)). Substituting into Poisson's equation, together with the boundary conditions, gives

{{< katex display >}}
\begin{aligned}
u_0 &= c_0 \\
\frac{u_{n-1} - 2u_n + u_{n+1}}{\Delta t^2} &= f_n \qquad n = 1, \ldots, N-1 \\
u_N &= c_1
\end{aligned}
{{< /katex >}}

This is a *linear system of algebraic equations*: \\( N + 1 \\) equations in \\( N + 1 \\) unknowns, so it's square and may be uniquely solvable. Write

{{< katex display >}}
A = \begin{bmatrix}
1 & 0 & 0 & 0 & \cdots & 0 \\
\frac{1}{\Delta t^2} & -\frac{2}{\Delta t^2} & \frac{1}{\Delta t^2} & 0 & \cdots & 0 \\
0 & \frac{1}{\Delta t^2} & -\frac{2}{\Delta t^2} & \frac{1}{\Delta t^2} & \cdots & 0 \\
 & & \ddots & \ddots & \ddots & \\
0 & \cdots & 0 & \frac{1}{\Delta t^2} & -\frac{2}{\Delta t^2} & \frac{1}{\Delta t^2} \\
0 & \cdots & 0 & 0 & 0 & 1
\end{bmatrix} \in \mathbb{R}^{(N+1) \times (N+1)}
\qquad
\vec{f} = \begin{bmatrix} c_0 \\ f_1 \\ f_2 \\ \vdots \\ f_{N-1} \\ c_1 \end{bmatrix} \in \mathbb{R}^{N+1}
{{< /katex >}}

and {{< katex >}} \vec{u} = (u_0, \ldots, u_N) \in \mathbb{R}^{N+1} {{< /katex >}}. Then we just solve

{{< katex display >}}
A \vec{u} = \vec{f}
{{< /katex >}}

A direct calculation shows \\( A \\) is invertible, so \\( \vec{u} \\) can be computed uniquely with standard linear algebra: Gaussian elimination, LU or QR factorization, iterative methods, etc.

This reveals the fundamental difference between IVPs and BVPs. For IVPs we compute {{< katex >}} u_{n+1} {{< /katex >}} from {{< katex >}} u_n {{< /katex >}} (or more broadly from {{< katex >}} u_0, \ldots, u_n {{< /katex >}}). Here we compute the **entire solution vector \\( \vec{u} \\) at once**, with no marching forward in time.

## Second-Order BVPs and Boundary Conditions

For this part of the course we mainly focus on second-order BVPs

{{< katex display >}}
\frac{\dd^2 u}{\dd t^2} = f\left(t, u, \dv{u}{t}\right) \qquad t \in (a, b)
{{< /katex >}}

with four types of boundary conditions:

- **Dirichlet** (Peter Dirichlet): the value is prescribed

{{< katex display >}}
u(a) = c_a \qquad u(b) = c_b
{{< /katex >}}

- **Neumann** (Carl Neumann): the derivative is prescribed

{{< katex display >}}
u'(a) = c_a \qquad u'(b) = c_b
{{< /katex >}}

- **Robin** (Victor Robin): a linear combination of value and derivative

{{< katex display >}}
u'(a) = \alpha_a u(a) + \beta_a \qquad u'(b) = \alpha_b u(b) + \beta_b
{{< /katex >}}

- **Periodic**:

{{< katex display >}}
u(a) = u(b) \qquad u'(a) = u'(b)
{{< /katex >}}

Dirichlet, Neumann, and Robin conditions can be mixed and matched, e.g. Dirichlet at \\( a \\) and Robin at \\( b \\).

> [!NOTE]
>
> **Goal:** construct algorithms that compute consistent approximations to the true solution, {{< katex >}} u_n \to u(t_n) {{< /katex >}} as \\( \Delta t \to 0 \\), and find their rates of convergence, just as we did for IVPs.
