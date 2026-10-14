---
title: "Extension to Nonlinear Systems of ODEs"
weight: 40
---

# Extension to Nonlinear Systems of ODEs

Last time we introduced forward and backward Euler and tried them on the test ODE. Now for the practical details of using them on nonlinear problems and systems, plus some examples that motivate more advanced methods and a theoretical framework for analyzing them.

## Solving Nonlinear ODEs with Backward Euler

Consider a generic nonlinear (still scalar) ODE

{{< katex display >}}
\dv{u}{t} = f(t, u) \qquad u(0) = c \qquad f : [0, T] \times \mathbb{R} \to \mathbb{R}
{{< /katex >}}

Forward Euler doesn't care: we only need to evaluate \\( f \\) at the known point {{< katex >}} (t_n, u_n) {{< /katex >}}.

```pseudocode
\begin{algorithm}
\caption{Forward Euler}
\begin{algorithmic}
\State Given $c$, $f$, $\Delta t$
\State Set $u_0 = c$
\For{$n = 0, 1, 2, \dots, T/\Delta t - 1$}
    \State Set $u_{n+1} = u_n + \Delta t \, f(t_n, u_n)$
\EndFor
\end{algorithmic}
\end{algorithm}
```

It's a bit more complicated to write out backward Euler,

{{< katex display >}}
u_{n+1} = u_n + \Delta t \, f(t_{n+1}, u_{n+1})
{{< /katex >}}

because {{< katex >}} f(t_{n+1}, u_{n+1}) {{< /katex >}} is a general nonlinear function of the unknown, so we have to solve a nonlinear equation every step. Any nonlinear solver works, but our primary approach is Newton's method.

### Newton's Method

Consider

{{< katex display >}}
g(v) = 0
{{< /katex >}}

where \\( g : \mathbb{R} \to \mathbb{R} \\) is continuously differentiable. Our goal is to find \\( v \\). We build a sequence of guesses {{< katex >}} \{v_k\}_{k \geq 0} {{< /katex >}} that should end up arbitrarily close to \\( v \\). At each guess, we pretend \\( g \\) is linear and solve for the root of its linear Taylor expansion

{{< katex display >}}
g(v_{k+1}) \approx g(v_k) + g'(v_k)(v_{k+1} - v_k) = 0
\quad \to \quad
v_{k+1} = v_k - \frac{g(v_k)}{g'(v_k)}
{{< /katex >}}

- We need to pick an initial guess \\( v_0 \\)
- We need to be able to evaluate \\( g \\) and \\( g' \\)
- We assume \\( g' \\) stays bounded away from zero near the solution

Convergence of Newton's method is nontrivial and depends on the initialization and the smoothness of \\( g \\) (see e.g. Nocedal & Wright, Thm. 3.5).

So how does this help us with backward Euler? Let \\( v = u_{n+1} \\)

{{< katex display >}}
\begin{aligned}
u_{n+1} &= u_n + \Delta t \, f(t_{n+1}, u_{n+1}) \\
v &= u_n + \Delta t \, f(t_{n+1}, v) \\
g(v) \equiv v - u_n - \Delta t \, f(t_{n+1}, v) &= 0
\end{aligned}
{{< /katex >}}

Notice that

{{< katex display >}}
g'(v) = 1 - \Delta t \pdv{f}{u}(t_{n+1}, v)
{{< /katex >}}

so our Newton sub-iterations take the form

{{< katex display >}}
v_{k+1} = v_k - \frac{v_k - u_n - \Delta t \, f(t_{n+1}, v_k)}{1 - \Delta t \pdv{f}{u}(t_{n+1}, v_k)}
{{< /katex >}}

Typically we use {{< katex >}} v_0 = u_n {{< /katex >}} as the initial guess, since {{< katex >}} u_{n+1} \to u_n {{< /katex >}} as \\( \Delta t \to 0 \\). Newton converges (asymptotically) quadratically near the solution, so we only need a few iterations, but we never converge *exactly*. We stop when {{< katex >}} |v_{k+1} - v_k| < \text{tol} {{< /katex >}} for some prescribed tolerance, e.g. \\( 10^{-8} \\).

```pseudocode
\begin{algorithm}
\caption{Backward Euler with Newton Sub-iterations}
\begin{algorithmic}
\State Given $c$, $f$, $\Delta t$, and tolerance $\text{tol} > 0$
\State Set $u_0 = c$
\For{$n = 0, 1, 2, \dots, T/\Delta t - 1$}
    \State Initialize $v_0 = u_n$
    \State Set $k = 0$
    \Repeat
        \State Set $v_{k+1} = v_k - \dfrac{v_k - u_n - \Delta t \, f(t_{n+1}, v_k)}{1 - \Delta t \, \frac{\partial f}{\partial u}(t_{n+1}, v_k)}$
        \State Increment $k \gets k+1$
    \Until{$|v_{k+1} - v_k| < \text{tol}$}
    \State Set $u_{n+1} = v_{k+1}$
\EndFor
\end{algorithmic}
\end{algorithm}
```

Not too bad! Now we have nested loops, so the cost per step is waaaay higher, but it is at least stable.

### Example: Growing Ice Thickness

Stefan's ice-growth law models the thickness \\( u \\) of ice on top of a frozen lake

{{< katex display >}}
\dv{u}{t} = \frac{D}{u} \qquad u(0) = c > 0
{{< /katex >}}

where \\( D > 0 \\) is an effective thermal diffusivity of the ice. This has an analytic solution: the ODE is \\( \dv{}{t} u^2 = 2D \\), so

{{< katex display >}}
u(t) = \sqrt{2Dt + c^2}
{{< /katex >}}

The ice grows like \\( \sqrt{t} \\): thickening slows down over time.

<p align="center"> <img alt="img/amath581/stefan_ice_growth_dt0.01.png" src="/r/img/amath581/stefan_ice_growth_dt0.01.png" width="66%" style="min-width: 0" /> <img alt="img/amath581/stefan_newton_iters_dt0.01.png" src="/r/img/amath581/stefan_newton_iters_dt0.01.png" width="32%" style="min-width: 0" /> </p>

<p align="center"><em>Stefan's ice-growth law, \( \Delta t = 0.01 \). Left: numerical solutions against the truth. Middle: errors. Right: Newton sub-iterations per step.</em></p>

## Systems of ODEs with Euler

{{< katex display >}}
\dv{\vec{u}}{t} = \vec{f}(t, \vec{u}) \qquad \vec{u}(0) = \vec{c} \qquad \vec{f} : [0, T] \times \mathbb{R}^d \to \mathbb{R}^d
{{< /katex >}}

Forward Euler is exactly the same, just with vector-valued \\( \vec{u} \\)

{{< katex display >}}
\vec{u}_{n+1} = \vec{u}_n + \Delta t \, \vec{f}(t_n, \vec{u}_n)
{{< /katex >}}

But backward Euler

{{< katex display >}}
\vec{u}_{n+1} = \vec{u}_n + \Delta t \, \vec{f}(t_{n+1}, \vec{u}_{n+1})
{{< /katex >}}

now requires solving a nonlinear *system* of equations at each step, so we extend Newton's method to systems.

### Newton's Method for Systems

Consider a generic problem

{{< katex display >}}
\vec{g}(\vec{v}) = \vec{0} \qquad \vec{g} : \mathbb{R}^d \to \mathbb{R}^d
{{< /katex >}}

The Jacobian of \\( \vec{g} \\) is the matrix of partial derivatives, with the gradients of each component as its rows

{{< katex display >}}
D\vec{g}(\vec{v}) = \begin{bmatrix} - & \grad g_1^T & - \\ - & \grad g_2^T & - \\ & \vdots & \\ - & \grad g_d^T & - \end{bmatrix}
\qquad \left[ D\vec{g} \right]_{ij} = \pdv{g_i}{v_j}
{{< /katex >}}

Again this comes from a Taylor expansion of \\( \vec{g} \\)

{{< katex display >}}
\vec{g}(\vec{v}_{k+1}) = \vec{g}(\vec{v}_k) + D\vec{g}(\vec{v}_k)(\vec{v}_{k+1} - \vec{v}_k) + \mathcal{O}\left(\| \vec{v}_{k+1} - \vec{v}_k \|^2\right)
{{< /katex >}}

Set the linear part to zero and solve for \\( \vec{v}_{k+1} \\)

{{< katex display >}}
\vec{v}_{k+1} = \vec{v}_k - \left( D\vec{g}(\vec{v}_k) \right)^{-1} \vec{g}(\vec{v}_k)
{{< /katex >}}

Of course we don't want to compute a whole inverse, so in practice we solve the linear system

{{< katex display >}}
D\vec{g}(\vec{v}_k) \, \delta\vec{v} = -\vec{g}(\vec{v}_k) \qquad \vec{v}_{k+1} = \vec{v}_k + \delta\vec{v}
{{< /katex >}}

For backward Euler, {{< katex >}} \vec{g}(\vec{v}) = \vec{v} - \vec{u}_n - \Delta t \, \vec{f}(t_{n+1}, \vec{v}) {{< /katex >}}, so {{< katex >}} D\vec{g} = I - \Delta t \, D_{\vec{u}}\vec{f} {{< /katex >}} and the sub-iterations are

{{< katex display >}}
\vec{v}_{k+1} = \vec{v}_k - \left( I - \Delta t \, D_{\vec{u}}\vec{f}(t_{n+1}, \vec{v}_k) \right)^{-1} \left[ \vec{v}_k - \vec{u}_n - \Delta t \, \vec{f}(t_{n+1}, \vec{v}_k) \right]
{{< /katex >}}

We now need access to \\( D\vec{f} \\) and a linear solve every Newton iteration. \\( D\vec{f} \\) can be approximated many ways, though nowadays automatic differentiation is often used to compute it efficiently.

```pseudocode
\begin{algorithm}
\caption{Backward Euler with Newton Sub-iterations for Systems}
\begin{algorithmic}
\State Given $\mathbf{c}$, $\mathbf{f}$, $D_{\mathbf{u}}\mathbf{f}$, $\Delta t$, and tolerance $\text{tol} > 0$
\State Set $\mathbf{u}_0 = \mathbf{c}$
\For{$n = 0, 1, 2, \dots, T/\Delta t - 1$}
    \State Initialize $\mathbf{v}_0 = \mathbf{u}_n$
    \State Set $k = 0$
    \Repeat
        \State Set $\mathbf{v}_{k+1} = \mathbf{v}_k - \left( I - \Delta t \, D_{\mathbf{u}} \mathbf{f}(t_{n+1}, \mathbf{v}_k) \right)^{-1} \left[ \mathbf{v}_k - \mathbf{u}_n - \Delta t \, \mathbf{f}(t_{n+1}, \mathbf{v}_k) \right]$
        \State Increment $k \gets k+1$
    \Until{$\| \mathbf{v}_{k+1} - \mathbf{v}_k \| < \text{tol}$}
    \State Set $\mathbf{u}_{n+1} = \mathbf{v}_{k+1}$
\EndFor
\end{algorithmic}
\end{algorithm}
```

### Example: Predator-Prey Model (Lotka-Volterra)

{{< katex display >}}
\begin{aligned}
\dv{u_1}{t} &= \alpha u_1 - \beta u_1 u_2 \\
\dv{u_2}{t} &= \delta u_1 u_2 - \gamma u_2
\end{aligned}
{{< /katex >}}

where {{< katex >}} u_1 {{< /katex >}} is the prey population, {{< katex >}} u_2 {{< /katex >}} is the predator population, and \\( \alpha, \beta, \gamma, \delta > 0 \\). The RHS and its Jacobian are

{{< katex display >}}
\vec{f}(t, \vec{u}) = \begin{bmatrix} \alpha u_1 - \beta u_1 u_2 \\ \delta u_1 u_2 - \gamma u_2 \end{bmatrix}
\qquad
D_{\vec{u}}\vec{f}(t, \vec{u}) = \begin{bmatrix} \alpha - \beta u_2 & -\beta u_1 \\ \delta u_2 & \delta u_1 - \gamma \end{bmatrix}
{{< /katex >}}

This gives us everything we need to plug and chug.

<p align="center"> <img alt="img/amath581/lotka_volterra.png" src="/r/img/amath581/lotka_volterra.png" width="600" /> </p>

<p align="center"><em>Lotka-Volterra with \( (\alpha, \beta, \gamma, \delta) = (1, 1, 1.5, 0.075) \), computed with backward Euler + Newton sub-iterations.</em></p>
