---
title: "Higher Order Methods I: The Runge-Kutta Family"
weight: 90
---

# Higher Order Methods I: The Runge-Kutta Family

So far we've mostly used forward and backward Euler, both first-order consistent and convergent. We usually just say they're *first-order accurate*, meaning both the local truncation and global errors are \\( \mathcal{O}(\Delta t) \\). They're simple, but in practice we'd like methods with accuracy \\( \mathcal{O}(\Delta t^p) \\) for, say, \\( p = 2 \\) or \\( p = 4 \\). With a second-order method, halving the step size \\( \Delta t \leftarrow \Delta t / 2 \\) cuts the error by a factor of \\( 2^2 = 4 \\). With a fourth-order method it drops by a factor of 16! These methods can really pay off.

This lecture covers **one-step methods**, where {{< katex >}} \vec{u}_n {{< /katex >}} is computed only from {{< katex >}} \vec{u}_{n-1} {{< /katex >}}. Next up are **multistep methods**, where {{< katex >}} \vec{u}_n {{< /katex >}} is computed from several previous values {{< katex >}} \vec{u}_{n-1}, \vec{u}_{n-2}, \ldots, \vec{u}_{n-k} {{< /katex >}}.

## Quadrature

Our starting point for deriving higher-order methods is the approximation of integrals, called **quadrature**. For some function \\( g : [a, b] \to \mathbb{R} \\), pick \\( s \\) distinct points {{< katex >}} x_1, \ldots, x_s \in [a, b] {{< /katex >}} and weights {{< katex >}} w_1, \ldots, w_s {{< /katex >}} and approximate

{{< katex display >}}
\int_a^b g(x) \, \dd x \approx \sum_{i=1}^{s} w_i \, g(x_i)
{{< /katex >}}

The choice of points and weights {{< katex >}} (x_i, w_i) {{< /katex >}} is the quadrature rule. Popular examples:

{{< katex display >}}
\begin{aligned}
\text{left point rule:} & \quad \int_a^b g(x) \, \dd x \approx (b - a) \, g(a) \\
\text{right point rule:} & \quad \int_a^b g(x) \, \dd x \approx (b - a) \, g(b) \\
\text{midpoint rule:} & \quad \int_a^b g(x) \, \dd x \approx (b - a) \, g\left(\frac{a + b}{2}\right) \\
\text{trapezoidal rule:} & \quad \int_a^b g(x) \, \dd x \approx \frac{b - a}{2} \left( g(a) + g(b) \right)
\end{aligned}
{{< /katex >}}

<p align="center"> <img alt="img/amath581/quadrature_rules.svg" src="/r/img/amath581/quadrature_rules.svg" width="600" /> </p>

<p align="center"><em>The four quadrature rules applied to a smooth \( g \). The shaded area is what the rule computes; the exact integral is the area under \( g(x) \). Dots mark where \( g \) is evaluated.</em></p>

## From Quadrature to ODE Solvers

Take a generic scalar ODE, switching to prime notation \\( u'(t) = \dv{u}{t}(t) \\) for convenience,

{{< katex display >}}
u' = f(t, u)
{{< /katex >}}

(the methods extend naturally to systems). Integrate both sides over {{< katex >}} [t_{n-1}, t_n] {{< /katex >}}:

{{< katex display >}}
u(t_n) - u(t_{n-1}) = \int_{t_{n-1}}^{t_n} u'(t) \, \dd t = \int_{t_{n-1}}^{t_n} f(t, u(t)) \, \dd t
{{< /katex >}}

Each quadrature rule for the right-hand side gives a time-stepping scheme.

- **Left point rule** \\( \to \\) forward Euler:

{{< katex display >}}
u(t_n) - u(t_{n-1}) \approx \Delta t \, f(t_{n-1}, u(t_{n-1}))
\quad \to \quad
u_n = u_{n-1} + \Delta t \, f(t_{n-1}, u_{n-1})
{{< /katex >}}

- **Right point rule** \\( \to \\) backward Euler:

{{< katex display >}}
u(t_n) - u(t_{n-1}) \approx \Delta t \, f(t_n, u(t_n))
\quad \to \quad
u_n = u_{n-1} + \Delta t \, f(t_n, u_n)
{{< /katex >}}

- **Trapezoidal rule** \\( \to \\) the [trapezoid method](../05-accuracy/#trapezoid-method) from before:

{{< katex display >}}
u_n = u_{n-1} + \frac{\Delta t}{2} \left( f(t_{n-1}, u_{n-1}) + f(t_n, u_n) \right)
{{< /katex >}}

- **Midpoint rule**:

{{< katex display >}}
u(t_n) - u(t_{n-1}) \approx \Delta t \, f\left(t_{n-1/2}, u(t_{n-1/2})\right) \qquad t_{n-1/2} = \frac{t_{n-1} + t_n}{2}
{{< /katex >}}

This needs \\( u(t_{n-1/2}) \\), which we don't have. There are two ways to approximate it.

### Implicit Midpoint

Approximate {{< katex >}} u(t_{n-1/2}) {{< /katex >}} by the average of {{< katex >}} u(t_{n-1}) {{< /katex >}} and {{< katex >}} u(t_n) {{< /katex >}}:

{{< katex display >}}
u_n = u_{n-1} + \Delta t \, f\left( t_{n-1/2}, \frac{u_n + u_{n-1}}{2} \right)
{{< /katex >}}

### Explicit Midpoint (RK2)

Alternatively, approximate \\( u(t_{n-1/2}) \\) with an intermediate forward Euler half-step:

{{< katex display >}}
\begin{aligned}
\hat{u}_{n-1/2} &= u_{n-1} + \frac{\Delta t}{2} f(t_{n-1}, u_{n-1}) \\
u_n &= u_{n-1} + \Delta t \, f\left(t_{n-1/2}, \hat{u}_{n-1/2}\right)
\end{aligned}
{{< /katex >}}

This is our first Runge-Kutta method, sometimes called **RK2**.

> [!NOTE]
>
> **The Runge-Kutta idea:** construct a series of intermediate approximations to the solution within each step in order to improve the order of accuracy.

```pseudocode
\begin{algorithm}
\caption{Explicit Midpoint (RK2)}
\begin{algorithmic}
\State Given $c$, $f$, $\Delta t$
\State Set $u_0 = c$
\For{$n = 1, 2, \dots, T/\Delta t$}
    \State Set $\hat{u}_{n-1/2} = u_{n-1} + \frac{\Delta t}{2} f(t_{n-1}, u_{n-1})$
    \State Set $u_n = u_{n-1} + \Delta t \, f(t_{n-1/2}, \hat{u}_{n-1/2})$
\EndFor
\end{algorithmic}
\end{algorithm}
```

### RK2 Is Second-Order Accurate

The point of the extra stage is that the resulting explicit scheme is second-order accurate. Plug the true solution into the scheme:

{{< katex display >}}
\tau_n = \frac{u(t_n) - u(t_{n-1})}{\Delta t} - f\left(t_{n-1/2}, \, u(t_{n-1}) + \frac{\Delta t}{2} f(t_{n-1}, u(t_{n-1}))\right)
{{< /katex >}}

Expand everything about {{< katex >}} t_{n-1} {{< /katex >}}. Below, \\( u, u', \ldots \\) and {{< katex >}} f, f_t, f_u, \ldots {{< /katex >}} are all evaluated at {{< katex >}} t_{n-1} {{< /katex >}}, {{< katex >}} (t_{n-1}, u(t_{n-1})) {{< /katex >}}. The first term is

{{< katex display >}}
\frac{u(t_n) - u(t_{n-1})}{\Delta t} = u' + \frac{\Delta t}{2} u'' + \frac{\Delta t^2}{6} u''' + \mathcal{O}(\Delta t^3)
{{< /katex >}}

The second term is \\( f \\) evaluated at a point shifted by \\( \left(\frac{\Delta t}{2}, \frac{\Delta t}{2} f\right) \\), so a 2D Taylor expansion gives

{{< katex display >}}
f\left(t + \tfrac{\Delta t}{2}, u + \tfrac{\Delta t}{2} f\right) = f + \frac{\Delta t}{2} \left( f_t + f_u f \right) + \frac{\Delta t^2}{8} \left( f_{tt} + 2 f_{tu} f + f_{uu} f^2 \right) + \mathcal{O}(\Delta t^3)
{{< /katex >}}

Differentiating the ODE \\( u' = f(t, u) \\) along the solution with the chain rule,

{{< katex display >}}
\begin{aligned}
u' &= f \\
u'' &= f_t + f_u u' = f_t + f_u f \\
u''' &= f_{tt} + 2 f_{tu} f + f_{uu} f^2 + f_u \left( f_t + f_u f \right)
\end{aligned}
{{< /katex >}}

Substituting, the \\( \mathcal{O}(1) \\) and \\( \mathcal{O}(\Delta t) \\) terms cancel exactly, leaving

{{< katex display >}}
\tau_n = \Delta t^2 \left[ \frac{1}{24} \left( f_{tt} + 2 f_{tu} f + f_{uu} f^2 \right) + \frac{1}{6} f_u \left( f_t + f_u f \right) \right] + \mathcal{O}(\Delta t^3) = \mathcal{O}(\Delta t^2)
{{< /katex >}}

It can also be shown that the method is 0-stable, so by the [Lax equivalence theorem](../06-convergence-and-lax/#consistency--stability--convergence) it's second-order convergent.

## Classical Fourth-Order Runge-Kutta (RK4)

Continuing this line of thinking with more accurate quadrature rules gives higher-order Runge-Kutta methods. The most popular is the classical fourth-order Runge-Kutta method (RK4), widely used in off-the-shelf solvers:

{{< katex display >}}
\begin{aligned}
\hat{u}_1 &= u_{n-1} \\
\hat{u}_2 &= u_{n-1} + \frac{\Delta t}{2} f(t_{n-1}, \hat{u}_1) \\
\hat{u}_3 &= u_{n-1} + \frac{\Delta t}{2} f(t_{n-1/2}, \hat{u}_2) \\
\hat{u}_4 &= u_{n-1} + \Delta t \, f(t_{n-1/2}, \hat{u}_3) \\
u_n &= u_{n-1} + \frac{\Delta t}{6} \Big( f(t_{n-1}, \hat{u}_1) + 2 f(t_{n-1/2}, \hat{u}_2) + 2 f(t_{n-1/2}, \hat{u}_3) + f(t_n, \hat{u}_4) \Big)
\end{aligned}
{{< /katex >}}

The final update is Simpson's rule, {{< katex >}} \int_a^b g \approx \frac{b-a}{6}\left(g(a) + 4 g\left(\tfrac{a+b}{2}\right) + g(b)\right) {{< /katex >}}, with the midpoint value split between two estimates. The intermediate values \\( \hat{u}_i \\) are just forward Euler approximations built from the previous estimates. Even though forward Euler is only first-order accurate, the combination ends up fourth-order accurate.

```pseudocode
\begin{algorithm}
\caption{Classical Runge-Kutta (RK4)}
\begin{algorithmic}
\State Given $c$, $f$, $\Delta t$
\State Set $u_0 = c$
\For{$n = 1, 2, \dots, T/\Delta t$}
    \State $k_1 = f(t_{n-1}, u_{n-1})$
    \State $k_2 = f(t_{n-1/2}, u_{n-1} + \frac{\Delta t}{2} k_1)$
    \State $k_3 = f(t_{n-1/2}, u_{n-1} + \frac{\Delta t}{2} k_2)$
    \State $k_4 = f(t_n, u_{n-1} + \Delta t \, k_3)$
    \State Set $u_n = u_{n-1} + \frac{\Delta t}{6} (k_1 + 2 k_2 + 2 k_3 + k_4)$
\EndFor
\end{algorithmic}
\end{algorithm}
```

(Here {{< katex >}} k_i = f(\cdot, \hat{u}_i) {{< /katex >}} are the stage slopes. This is the more common way to write RK4.)

## Stability of Explicit Runge-Kutta Methods

Since these methods are all explicit, we expect stability restrictions. Applying them to the test ODE \\( u' = \lambda u \\) with \\( z = \lambda \Delta t \\), each step multiplies by a polynomial amplification factor {{< katex >}} u_n = R(z) \, u_{n-1} {{< /katex >}}. For RK2,

{{< katex display >}}
\hat{u}_{n-1/2} = \left(1 + \tfrac{z}{2}\right) u_{n-1}
\quad \to \quad
u_n = u_{n-1} + z \left(1 + \tfrac{z}{2}\right) u_{n-1} = \left(1 + z + \frac{z^2}{2}\right) u_{n-1}
{{< /katex >}}

and similarly RK4 gives \\( R(z) = 1 + z + \frac{z^2}{2} + \frac{z^3}{6} + \frac{z^4}{24} \\): the Taylor series of \\( e^z \\), truncated at the order of the method. The region of absolute stability is {{< katex >}} \{ z : |R(z)| \leq 1 \} {{< /katex >}}.

<p align="center"> <img alt="img/amath581/stability_regions_rk.svg" src="/r/img/amath581/stability_regions_rk.svg" width="400" /> </p>

<p align="center"><em>Stability regions for forward Euler, explicit midpoint (RK2), and RK4.</em></p>

The regions grow with the order, but since \\( R(z) \\) is a polynomial, \\( |R(z)| \to \infty \\) as \\( |z| \to \infty \\): no explicit Runge-Kutta method is A-stable.
