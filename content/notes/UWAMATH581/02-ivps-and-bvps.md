---
title: "IVPs and BVPs"
weight: 20
---

# IVPs and BVPs

In this class we first focus on two types of ODE problems: initial value problems (IVPs) and boundary value problems (BVPs). Back to our basic example, the harmonic oscillator

{{< katex display >}}
\frac{\dd^2 u}{\dd t^2} + u = 0 \quad \to \quad u(t) = A\cos(t) + B\sin(t)
{{< /katex >}}

By itself this ODE is not well-posed: any \\( A, B \\) give a solution. For the problem to be well-posed, we need to supply side information that constrains the general solution to a unique one. The general system is

{{< katex display >}}
\frac{\dd^n u}{\dd t^n} = f\left(t, u, \dv{u}{t}, \ldots, \frac{\dd^{n-1} u}{\dd t^{n-1}}\right)
{{< /katex >}}

- **Initial value problems** supply the data at a fixed point in time, typically the initial time {{< katex >}} t_0 {{< /katex >}}: the value of all arguments of \\( f \\) at that point. E.g. {{< katex >}} u(0) = u_0 {{< /katex >}}, {{< katex >}} u'(0) = v_0 {{< /katex >}} gives

{{< katex display >}}
u(t) = u_0 \cos(t) + v_0 \sin(t)
{{< /katex >}}

- **Boundary value problems** supply data at the boundaries of the domain, typically two different points in time {{< katex >}} t_0 {{< /katex >}} and {{< katex >}} t_1 {{< /katex >}}. E.g. {{< katex >}} u(0) = u_0 {{< /katex >}}, {{< katex >}} u(\pi/2) = u_1 {{< /katex >}} gives

{{< katex display >}}
u(t) = u_0 \cos(t) + u_1 \sin(t)
{{< /katex >}}

Thinking about how this distinction affects us: for an IVP we are given enough information to push the initial solution infinitesimally forward in time, and the IVP above always has the unique solution {{< katex >}} A = u_0 {{< /katex >}}, {{< katex >}} B = v_0 {{< /katex >}}. For a BVP we need to find the entire solution at once, and it is more difficult to guarantee that it is well-posed. A BVP may have infinitely many solutions, or none. Consider

{{< katex display >}}
u(0) = c_1 \qquad u(\pi) = c_2
{{< /katex >}}

The coefficients must satisfy

{{< katex display >}}
\begin{aligned}
A \cdot (1) + B \cdot (0) &= c_1 \\
A \cdot (-1) + B \cdot (0) &= c_2
\end{aligned}
\quad \Leftrightarrow \quad
\begin{bmatrix} 1 & 0 \\ -1 & 0 \end{bmatrix}
\begin{bmatrix} A \\ B \end{bmatrix}
=
\begin{bmatrix} c_1 \\ c_2 \end{bmatrix}
{{< /katex >}}

The matrix is singular, so

- If {{< katex >}} c_1 = c_2 = 0 {{< /katex >}}, there are infinitely many solutions \\( u(t) = B \sin(t) \\): these boundary conditions are insufficient.
- If {{< katex >}} c_2 \neq -c_1 {{< /katex >}}, there is no solution at all.

Intuitively, IVPs are dynamic problems: start with initial data and march forward in time. BVPs are static problems: the solution must satisfy conditions at multiple points, and there's no inherent direction of "marching".

## General Form of an IVP

> [!NOTE]
>
> ### Definition: **IVP**
>
> The general form of a first-order IVP is a system of ODEs
>
> {{< katex display >}}
\dv{\vec{u}}{t} = \vec{f}(t, \vec{u}) \qquad \vec{u}(t_0) = \vec{u}_0
{{< /katex >}}
>
> where {{< katex >}} \vec{u} : [t_0, t_1] \to \mathbb{R}^d {{< /katex >}} is the unknown solution, {{< katex >}} \vec{f} : [t_0, t_1] \times \mathbb{R}^d \to \mathbb{R}^d {{< /katex >}} is the RHS, and {{< katex >}} \vec{u}_0 \in \mathbb{R}^d {{< /katex >}} is the given initial condition.

All the examples from [Lecture 1](../01-intro/) are IVPs. It is sufficient to only consider first-order systems, because any higher-order system can be converted into a first-order one. Given

{{< katex display >}}
\frac{\dd^n u}{\dd t^n} = f\left(t, u, \dv{u}{t}, \ldots, \frac{\dd^{n-1} u}{\dd t^{n-1}}\right)
{{< /katex >}}

define auxiliary variables

{{< katex display >}}
\begin{aligned}
u_1(t) &= u(t) \\
u_2(t) &= \dv{u}{t}(t) \\
&\;\;\vdots \\
u_n(t) &= \frac{\dd^{n-1} u}{\dd t^{n-1}}(t)
\end{aligned}
\qquad \qquad
\vec{u} = \begin{bmatrix} u_1 \\ u_2 \\ \vdots \\ u_n \end{bmatrix}
{{< /katex >}}

Then the \\( n^{\text{th}} \\)-order ODE is equivalent to the first-order system

{{< katex display >}}
\dv{}{t} \begin{bmatrix} u_1 \\ u_2 \\ \vdots \\ u_{n-1} \\ u_n \end{bmatrix} = \begin{bmatrix} u_2 \\ u_3 \\ \vdots \\ u_n \\ f(t, u_1, u_2, \ldots, u_n) \end{bmatrix}
{{< /katex >}}

## General Form of a BVP

> [!NOTE]
>
> ### Definition: **BVP**
>
> The general form of a BVP is a system of ODEs
>
> {{< katex display >}}
\dv{\vec{u}}{t} = \vec{f}(t, \vec{u}) \qquad \vec{g}\left(\vec{u}(t_0), \vec{u}(t_1)\right) = \vec{0}
{{< /katex >}}
>
> where {{< katex >}} \vec{u} : [t_0, t_1] \to \mathbb{R}^d {{< /katex >}}, {{< katex >}} \vec{f} : [t_0, t_1] \times \mathbb{R}^d \to \mathbb{R}^d {{< /katex >}}, and \\( \vec{g} : \mathbb{R}^d \times \mathbb{R}^d \to \mathbb{R}^d \\) specifies the boundary data at {{< katex >}} t_0 {{< /katex >}} and {{< katex >}} t_1 {{< /katex >}}.

### Example: Poisson's Equation

Perhaps the most well-studied BVP is Poisson's equation

{{< katex display >}}
-\frac{\dd^2 u}{\dd x^2} = f(x) \qquad x \in (0, 1) \qquad u(0) = u_0, \quad u(1) = u_1
{{< /katex >}}

a second-order ODE with Dirichlet boundary conditions. It describes the potential field \\( u \\) due to a charge distribution \\( f(x) \\), as well as heat conduction in a 1D rod and the deflection of an elastic beam under load.
