---
title: "Order of Convergence of Forward Euler and the Lax Equivalence Theorem"
weight: 60
---

# Order of Convergence of Forward Euler and the Lax Equivalence Theorem

We've seen how to place bounds on the local truncation error \\( \tau_n \\)

{{< katex display >}}
\begin{aligned}
\text{Forward Euler: } \quad & \tau_n = \mathcal{O}(\Delta t) \\
\text{Backward Euler: } \quad & \tau_n = \mathcal{O}(\Delta t) \\
\text{Trapezoid method: } \quad & \tau_n = \mathcal{O}(\Delta t^2)
\end{aligned}
{{< /katex >}}

and observed empirically that forward Euler is first-order convergent. But what we really care about is the global error {{< katex >}} e_n {{< /katex >}}. Ideally we want to show that if {{< katex >}} \tau_n = \mathcal{O}(\Delta t^p) {{< /katex >}} then {{< katex >}} e_n = \mathcal{O}(\Delta t^p) {{< /katex >}}. This is often much harder than computing the order of accuracy. In this lecture we prove it for forward Euler, then state a fundamental theorem of Lax that simplifies the analysis for more complex methods.

## Deriving the Order of Convergence of Forward Euler

Let's derive the order of convergence for forward Euler. At the very first timestep:

{{< katex display >}}
u_1 = u_0 + \Delta t \, f(t_0, u_0)
{{< /katex >}}

Since {{< katex >}} u_0 = u(0) {{< /katex >}} is exact, the truncation error {{< katex >}} \tau_1 = \dfrac{u(t_1) - u(t_0)}{\Delta t} - f(t_0, u(t_0)) = \dfrac{u(t_1) - u_1}{\Delta t} {{< /katex >}}, so

{{< katex display >}}
e_1 = u(t_1) - u_1 = \Delta t \, \tau_1
{{< /katex >}}

The next estimate is

{{< katex display >}}
\begin{aligned}
u_2 &= u_1 + \Delta t \, f(t_1, u_1) \\
&= u(t_1) + \Delta t \, f(t_1, u(t_1)) + \left(u_1 - u(t_1)\right) + \Delta t \left( f(t_1, u_1) - f(t_1, u(t_1)) \right)
\end{aligned}
{{< /katex >}}

so

{{< katex display >}}
e_2 = u(t_2) - u_2 = \Delta t \, \tau_2 + \Big( \Delta t \, \tau_1 + \Delta t \left( f(t_1, u(t_1)) - f(t_1, u_1) \right) \Big)
{{< /katex >}}

Naively, this looks bad: we end up with \\( N = T/\Delta t \\) terms {{< katex >}} \Delta t \, \tau_n {{< /katex >}} to add up, plus the propagated error from each step. That could kill a whole order of accuracy, or worse, if errors are amplified.

In the general case, the true solution satisfies the scheme up to the truncation error, while the numerical solution satisfies it exactly

{{< katex display >}}
\begin{aligned}
u(t_n) - u(t_{n-1}) - \Delta t \, f(t_{n-1}, u(t_{n-1})) &= \Delta t \, \tau_n \\
u_n - u_{n-1} - \Delta t \, f(t_{n-1}, u_{n-1}) &= 0
\end{aligned}
{{< /katex >}}

Rearrange and subtract to get a recurrence for the global error

{{< katex display >}}
\overbrace{u(t_n) - u_n}^{e_n} = \overbrace{u(t_{n-1}) - u_{n-1}}^{e_{n-1}} + \Delta t \left( f(t_{n-1}, u(t_{n-1})) - f(t_{n-1}, u_{n-1}) \right) + \Delta t \, \tau_n
{{< /katex >}}

If \\( f \\) is Lipschitz continuous in its second argument,

{{< katex display >}}
\exists \, L > 0 \quad \text{s.t.} \quad |f(t, u) - f(t, v)| \leq L |u - v| \quad \forall \, t, u, v
{{< /katex >}}

then we can bound the terms on the r.h.s. in absolute value

{{< katex display >}}
\begin{aligned}
|e_n| &\leq |e_{n-1}| + \Delta t \, L \, |u(t_{n-1}) - u_{n-1}| + \Delta t \, |\tau_n| \\
&= |e_{n-1}| + \Delta t \, L \, |e_{n-1}| + \Delta t \, |\tau_n| \\
|e_n| &\leq (1 + \Delta t \, L) |e_{n-1}| + \Delta t \, |\tau_n|
\end{aligned}
{{< /katex >}}

We call the {{< katex >}} (1 + \Delta t \, L) {{< /katex >}} coefficient an **amplification factor**. It's always \\( > 1 \\) in this case. Applying the bound again,

{{< katex display >}}
|e_n| \leq (1 + \Delta t \, L)^2 |e_{n-2}| + (1 + \Delta t \, L) \Delta t \, |\tau_{n-1}| + \Delta t \, |\tau_n|
{{< /katex >}}

and taking this all the way back to \\( t = 0 \\),

{{< katex display >}}
|e_n| \leq (1 + \Delta t \, L)^n \overbrace{|e_0|}^{0} + \Delta t \sum_{k=0}^{n-1} (1 + \Delta t \, L)^k \, |\tau_{n-k}|
{{< /katex >}}

using {{< katex >}} e_0 = u(0) - u_0 = 0 {{< /katex >}}. Now suppose that \\( u^{\prime \prime}(t) \\) is a bounded function, that is {{< katex >}} \displaystyle \sup_{0 \leq t \leq T} |u''(t)| \leq M {{< /katex >}} for some \\( M > 0 \\). Then by the Lagrange (mean-value) form of the Taylor remainder, {{< katex >}} \tau_n = \frac{\Delta t}{2} u''(\xi_n) {{< /katex >}} for some {{< katex >}} \xi_n \in [t_{n-1}, t_n] {{< /katex >}}, so {{< katex >}} |\tau_n| \leq \dfrac{M}{2} \Delta t {{< /katex >}} and

{{< katex display >}}
\begin{aligned}
|e_n| &\leq (1 + \Delta t \, L) |e_{n-1}| + \frac{M}{2} \Delta t^2 \\
&\leq \frac{M}{2} \Delta t^2 \sum_{k=0}^{n-1} (1 + \Delta t \, L)^k \\
&= \frac{M}{2} \Delta t^2 \, \frac{(1 + \Delta t \, L)^n - 1}{\Delta t \, L}
\end{aligned}
{{< /katex >}}

using the geometric series \\( \sum_{k=0}^{K} a r^k = a \frac{1 - r^{K+1}}{1 - r} \\). Now we need to control the {{< katex >}} (1 + \Delta t \, L)^n {{< /katex >}}. Realizing

{{< katex display >}}
1 + a \leq e^a
{{< /katex >}}

we get

{{< katex display >}}
\begin{aligned}
(1 + \Delta t \, L)^n &\leq e^{n \Delta t L} \leq e^{TL} \\
\to |e_n| &\leq \frac{M}{2} \frac{\left(e^{TL} - 1\right)}{L} \Delta t = \mathcal{O}(\Delta t)
\end{aligned}
{{< /katex >}}

So forward Euler is **convergent of order one**, under the assumptions we made along the way (\\( f \\) Lipschitz in \\( u \\), \\( u^{\prime \prime} \\) bounded). Note the constant grows like \\( e^{TL} \\): the bound is only useful on finite time intervals.

## Consistency + Stability = Convergence

The important intuition from the calculation above is that the global error ends up the same order as the local truncation error. The proof was specific to forward Euler, but a fundamental theorem of numerical analysis says this property holds for much larger families of algorithms. First a definition.

> [!NOTE]
>
> ### Definition: **0-stability**
>
> Consider a numerical ODE solver with difference operator {{< katex >}} \mathcal{N}_{\Delta t} {{< /katex >}}. The method is **0-stable** if there exist constants {{< katex >}} C, h_0 > 0 {{< /katex >}}, independent of \\( \Delta t \\), such that for all {{< katex >}} \Delta t \leq h_0 {{< /katex >}} and any two sequences {{< katex >}} \{v_n\}_{n=0}^N {{< /katex >}} and {{< katex >}} \{w_n\}_{n=0}^N {{< /katex >}}
>
> {{< katex display >}}
|v_n - w_n| \leq C \left[ |v_0 - w_0| + \max_{1 \leq j \leq n} \left| \mathcal{N}_{\Delta t}[v_j] - \mathcal{N}_{\Delta t}[w_j] \right| \right]
{{< /katex >}}

Think of {{< katex >}} v_n {{< /katex >}} and {{< katex >}} w_n {{< /katex >}} as two numerical solutions of the ODE. 0-stability says that, for small enough \\( \Delta t \\), the difference between them stays bounded by the difference in initial conditions plus the perturbations introduced through the difference operator. The "0" refers to requiring \\( \Delta t \\) sufficiently small: it's a notion of stability in the limit \\( \Delta t \to 0 \\).

This brings us to the Lax equivalence theorem, due to Peter Lax.

> [!IMPORTANT]
>
> **Theorem: Lax Equivalence**
>
> A numerical method that is consistent and 0-stable is also convergent. In fact, if the method is consistent of order \\( p \\), then it is also convergent of order \\( p \\).
>
> **Proof**
>
> Take {{< katex >}} v_n = u(t_n) {{< /katex >}} (the true solution) and {{< katex >}} w_n = u_n {{< /katex >}} (produced by our scheme). By definition {{< katex >}} \mathcal{N}_{\Delta t}[u(t_j)] = \tau_j {{< /katex >}} and {{< katex >}} \mathcal{N}_{\Delta t}[u_j] = 0 {{< /katex >}}, and {{< katex >}} e_0 = 0 {{< /katex >}}. Substituting into the definition of 0-stability,
>
> {{< katex display >}}
|e_n| \leq C \left[ |e_0| + \max_{1 \leq j \leq n} \left| \mathcal{N}_{\Delta t}[u(t_j)] - \mathcal{N}_{\Delta t}[u_j] \right| \right] = C \max_{1 \leq j \leq n} |\tau_j| = \mathcal{O}(\Delta t^p)
{{< /katex >}}

The proof is simple, which means most of the work in showing the order of convergence goes into verifying the conditions. For any other method:

1. Bound the local truncation error \\( \tau_n \\) (consistency)
2. Prove the resulting difference operator \\( \mathcal{N}_{\Delta t} \\) is 0-stable

Both steps lean heavily on Taylor expansions and additional smoothness assumptions, as in the forward Euler example. (Our forward Euler proof is essentially a hands-on version of this argument: the recurrence {{< katex >}} |e_n| \leq (1 + \Delta t L)|e_{n-1}| + \Delta t |\tau_n| {{< /katex >}} sums to {{< katex >}} |e_n| \leq \frac{e^{TL} - 1}{L} \max_j |\tau_j| {{< /katex >}}, so the stability constant is \\( C = (e^{TL} - 1)/L \\).)
