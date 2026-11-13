---
title: "Solving a Variable Coefficient Second Order BVP"
weight: 140
---

# Solving a Variable Coefficient Second Order BVP

Here we derive a second-order FDM for a variable coefficient BVP. Beyond the toy examples so far, this shows most of the considerations and ideas involved in solving a linear second-order BVP. Consider

{{< katex display >}}
-\dv{}{t} \left( a(t) \dv{u}{t}(t) \right) + b(t) \dv{u}{t}(t) + c(t) u(t) = f(t) \qquad t \in (0, 1)
{{< /katex >}}

where \\( a, b, c, f \\) are given functions, subject to the Robin boundary conditions

{{< katex display >}}
a(0) \dv{u}{t}(0) = \alpha_0 u(0) + \beta_0 \qquad a(1) \dv{u}{t}(1) = \alpha_1 u(1) + \beta_1
{{< /katex >}}

with given coefficients {{< katex >}} \alpha_0, \alpha_1, \beta_0, \beta_1 {{< /katex >}}. We follow the usual [three steps](../13-finite-differences/#general-structure-of-a-finite-difference-method).

## Step 1: A Uniform Grid

Use a uniform grid on \\( [0, 1] \\), \\( t_j = j \Delta t \\) for \\( j = 0, \ldots, N \\), \\( \Delta t = 1/N \\). Later we'll augment it with a pair of so-called **ghost points**, {{< katex >}} t_{-1} = -\Delta t {{< /katex >}} and {{< katex >}} t_{N+1} = 1 + \Delta t {{< /katex >}}, which help impose derivative conditions at the boundary.

<p align="center"> <img alt="img/amath581/grid_ghost_points.svg" src="/r/img/amath581/grid_ghost_points.svg" width="600" /> </p>

<p align="center"><em>The uniform grid on \( [0, 1] \). Boundary points \( t_0 = 0 \) and \( t_N = 1 \) are large dots; the ghost points \( t_{-1} \) and \( t_{N+1} \) are crosses.</em></p>

## Step 2: Discretize the BVP

We replace every differential operator with a second-order accurate difference formula.

### The Zeroth-Order Term

This one is trivial:

{{< katex display >}}
c(t_j) u(t_j) \approx c_j u_j \qquad c_j = c(t_j)
{{< /katex >}}

### The First-Order Term

For \\( b u' \\) we only need to approximate \\( u' \\), and we use the second-order centered difference

{{< katex display >}}
b(t_j) \dv{u}{t}(t_j) = b(t_j) \frac{u(t_{j+1}) - u(t_{j-1})}{2\Delta t} + \mathcal{O}(\Delta t^2) \approx b_j \frac{u_{j+1} - u_{j-1}}{2\Delta t} \qquad b_j = b(t_j)
{{< /katex >}}

### The Second-Order Term

For \\( (a u')' \\) we need some care, since we'd prefer not to differentiate the coefficient \\( a \\). Instead, apply the centered difference twice, with the coefficient sampled on the **staggered grid** of midpoints {{< katex >}} t_{j \pm 1/2} = t_j \pm \Delta t/2 {{< /katex >}}.

<p align="center"> <img alt="img/amath581/diffusion_stencil.svg" src="/r/img/amath581/diffusion_stencil.svg" width="600" /> </p>

<p align="center"><em>The stencil around \( t_j \). Level 1 (middle row): grid values \( u_{j-1}, u_j, u_{j+1} \) are combined to approximate \( a u' \) at the midpoints \( t_{j \pm 1/2} \), where \( a \) is sampled (hollow squares). Level 2 (top): the midpoint values are combined to approximate \( (a u')' \) at \( t_j \).</em></p>

**Level 1.** Centered differences estimate \\( u' \\) at the midpoints:

{{< katex display >}}
\begin{aligned}
\dv{u}{t}(t_{j+1/2}) &= \frac{u(t_{j+1}) - u(t_j)}{\Delta t} - \frac{\Delta t^2}{24} u'''(t_{j+1/2}) + \mathcal{O}(\Delta t^4) \\
\dv{u}{t}(t_{j-1/2}) &= \frac{u(t_j) - u(t_{j-1})}{\Delta t} - \frac{\Delta t^2}{24} u'''(t_{j-1/2}) + \mathcal{O}(\Delta t^4)
\end{aligned}
{{< /katex >}}

The remainders are \\( \mathcal{O}(\Delta t^4) \\) rather than \\( \mathcal{O}(\Delta t^3) \\), since a centered difference only produces even powers of \\( \Delta t \\) in its error expansion. Multiply by {{< katex >}} a_{j+1/2} = a(t_{j+1/2}) {{< /katex >}} and {{< katex >}} a_{j-1/2} = a(t_{j-1/2}) {{< /katex >}} respectively:

{{< katex display >}}
\begin{aligned}
\left( a \dv{u}{t} \right)(t_{j+1/2}) &= a_{j+1/2} \left( \frac{u(t_{j+1}) - u(t_j)}{\Delta t} \right) - \frac{\Delta t^2}{24} a_{j+1/2} u'''(t_{j+1/2}) + \mathcal{O}(\Delta t^4) \\
\left( a \dv{u}{t} \right)(t_{j-1/2}) &= a_{j-1/2} \left( \frac{u(t_j) - u(t_{j-1})}{\Delta t} \right) - \frac{\Delta t^2}{24} a_{j-1/2} u'''(t_{j-1/2}) + \mathcal{O}(\Delta t^4)
\end{aligned}
{{< /katex >}}

**Level 2.** Apply the centered difference once more, centered at \\( t_j \\) with half-width \\( \Delta t/2 \\), to \\( F = a u' \\):

{{< katex display >}}
F'(t_j) = \frac{F(t_{j+1/2}) - F(t_{j-1/2})}{\Delta t} - \frac{\Delta t^2}{24} F'''(t_j) + \mathcal{O}(\Delta t^4)
{{< /katex >}}

Substituting the expressions for {{< katex >}} F(t_{j \pm 1/2}) {{< /katex >}} needs some care: the error terms get divided by \\( \Delta t \\), and we might worry about losing an order of accuracy. That doesn't happen. The \\( \mathcal{O}(\Delta t^4) \\) remainders become \\( \mathcal{O}(\Delta t^3) \\), while the leading error terms appear as a *difference*, which is itself a centered difference of \\( a u''' \\):

{{< katex display >}}
-\frac{\Delta t^2}{24} \cdot \frac{a_{j+1/2} u'''(t_{j+1/2}) - a_{j-1/2} u'''(t_{j-1/2})}{\Delta t} = -\frac{\Delta t^2}{24} (a u''')'(t_j) + \mathcal{O}(\Delta t^4) = \mathcal{O}(\Delta t^2)
{{< /katex >}}

Putting everything together,

{{< katex display >}}
\begin{aligned}
\dv{}{t} \left( a \dv{u}{t} \right)(t_j) &= \frac{1}{\Delta t} \left[ a_{j+1/2} \left( \frac{u(t_{j+1}) - u(t_j)}{\Delta t} \right) - a_{j-1/2} \left( \frac{u(t_j) - u(t_{j-1})}{\Delta t} \right) \right] + \mathcal{O}(\Delta t^2) \\
&\approx \frac{1}{\Delta t^2} \left[ a_{j+1/2} (u_{j+1} - u_j) - a_{j-1/2} (u_j - u_{j-1}) \right]
\end{aligned}
{{< /katex >}}

> [!IMPORTANT]
>
> **Second-order approximation of the diffusion term**
>
> {{< katex display >}}
\dv{}{t} \left( a \dv{u}{t} \right)(t_j) \approx \frac{1}{\Delta t^2} \left[ a_{j+1/2} u_{j+1} - \left( a_{j+1/2} + a_{j-1/2} \right) u_j + a_{j-1/2} u_{j-1} \right]
{{< /katex >}}
>
> If \\( a = 1 \\), this reduces to the usual centered difference for \\( u'' \\).

### The Boundary Conditions

The Robin conditions involve \\( u' \\) at {{< katex >}} t_0 {{< /katex >}} and {{< katex >}} t_N {{< /katex >}}, so we need second-order approximations there too. There are two options.

**Option 1: One-sided differences.** Use one-sided second-order formulae for {{< katex >}} u'(t_0) {{< /katex >}} and {{< katex >}} u'(t_N) {{< /katex >}}:

{{< katex display >}}
\begin{aligned}
u'(t_0) &= \frac{-3u(t_0) + 4u(t_1) - u(t_2)}{2\Delta t} + \mathcal{O}(\Delta t^2) \\
u'(t_N) &= \frac{3u(t_N) - 4u(t_{N-1}) + u(t_{N-2})}{2\Delta t} + \mathcal{O}(\Delta t^2)
\end{aligned}
{{< /katex >}}

Substituting into the Robin conditions,

{{< katex display >}}
\begin{aligned}
a_0 \frac{-3u_0 + 4u_1 - u_2}{2\Delta t} - \alpha_0 u_0 &= \beta_0 \\
a_N \frac{3u_N - 4u_{N-1} + u_{N-2}}{2\Delta t} - \alpha_1 u_N &= \beta_1
\end{aligned}
{{< /katex >}}

**Option 2: Centered differences with ghost points.** Alternatively, use centered differences at both endpoints, reaching out to the ghost points:

{{< katex display >}}
\begin{aligned}
u'(0) &= \frac{u(t_1) - u(t_{-1})}{2\Delta t} + \mathcal{O}(\Delta t^2) \\
u'(1) &= \frac{u(t_{N+1}) - u(t_{N-1})}{2\Delta t} + \mathcal{O}(\Delta t^2)
\end{aligned}
{{< /katex >}}

which impose the boundary conditions as

{{< katex display >}}
\begin{aligned}
a_0 \frac{u_1 - u_{-1}}{2\Delta t} - \alpha_0 u_0 &= \beta_0 \\
a_N \frac{u_{N+1} - u_{N-1}}{2\Delta t} - \alpha_1 u_N &= \beta_1
\end{aligned}
{{< /katex >}}

We now have two extra unknowns, {{< katex >}} u_{-1} {{< /katex >}} and {{< katex >}} u_{N+1} {{< /katex >}}, so we also impose the discrete ODE at {{< katex >}} t_0 {{< /katex >}} and {{< katex >}} t_N {{< /katex >}} to close the system.

## Step 3: Assemble the Matrices

Now assemble the linear system for {{< katex >}} \vec{u} = (u_0, \ldots, u_N) {{< /katex >}}, term by term. The interior rows \\( j = 1, \ldots, N-1 \\) come from the ODE; the first and last rows are reserved for the boundary conditions (using Option 1).

**The \\( c u \\) term** is a diagonal matrix:

{{< katex display >}}
c(t_j) u(t_j) \approx (C \vec{u})_j \qquad
C = \begin{bmatrix}
0 & & & & & \\
 & c_1 & & & & \\
 & & c_2 & & & \\
 & & & \ddots & & \\
 & & & & c_{N-1} & \\
 & & & & & 0
\end{bmatrix}
{{< /katex >}}

The first and last rows are zero, since those rows are given by the boundary conditions.

**The \\( b u' \\) term:**

{{< katex display >}}
b(t_j) u'(t_j) \approx (B \vec{u})_j \qquad
B = \frac{1}{2\Delta t} \begin{bmatrix}
0 & & & & \\
-b_1 & 0 & b_1 & & \\
 & \ddots & \ddots & \ddots & \\
 & & -b_{N-1} & 0 & b_{N-1} \\
 & & & & 0
\end{bmatrix}
{{< /katex >}}

**The \\( (a u')' \\) term:** Row \\( j \\) is the diffusion stencil above, so the band is tridiagonal; e.g. row 1 is {{< katex >}} \frac{1}{\Delta t^2} \left( a_{1/2}, \, -(a_{1/2} + a_{3/2}), \, a_{3/2}, 0, \ldots \right) {{< /katex >}}.

{{< katex display >}}
(a u')'(t_j) \approx (A \vec{u})_j \qquad
A = \frac{1}{\Delta t^2} \begin{bmatrix}
0 & & & \\
\ddots & \ddots & \ddots & \\
a_{j-1/2} & -(a_{j-1/2} + a_{j+1/2}) & a_{j+1/2} & \\
 & \ddots & \ddots & \ddots \\
 & & & 0
\end{bmatrix}
{{< /katex >}}

**The boundary conditions:** reading off the one-sided Robin equations, the matrix \\( R \\) is zero except in its first and last rows,

{{< katex display >}}
R = \begin{bmatrix}
-\frac{3a_0}{2\Delta t} - \alpha_0 & \frac{2a_0}{\Delta t} & -\frac{a_0}{2\Delta t} & & & & \\[4pt]
 & 0 & & & & & \\
 & & & \ddots & & & \\
 & & & & & 0 & \\[2pt]
 & & & & \frac{a_N}{2\Delta t} & -\frac{2a_N}{\Delta t} & \frac{3a_N}{2\Delta t} - \alpha_1
\end{bmatrix}
{{< /katex >}}

so \\( R \vec{u} \\) is nonzero only in its first and last entries, which correspond to the boundary conditions.

Finally, write

{{< katex display >}}
D = -A + B + C + R \qquad \vec{f} = (\beta_0, f_1, \ldots, f_{N-1}, \beta_1)
{{< /katex >}}

and the numerical solution is computed by solving the linear system

{{< katex display >}}
D \vec{u} = \vec{f}
{{< /katex >}}

As usual \\( D \\) is very sparse (it has at most three nonzeros per interior row), so the system can be solved efficiently with sparse linear algebra or iterative methods.
