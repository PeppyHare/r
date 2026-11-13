---
title: "Adaptive Step-Size Selection"
weight: 110
---

# Adaptive Step-Size Selection

So far we've mostly used a fixed step size, {{< katex >}} t_n - t_{n-1} = \Delta t {{< /katex >}}. In practice a fixed choice is often sub-optimal: varying the step size can give much more efficient algorithms.

As an example, take the [stiff ODE](../08-stiffness/#example-a-stiff-scalar-ode)

{{< katex display >}}
\dv{u}{t} = -100 \left( u - \sin(t) \right) \qquad u(0) = 1
{{< /katex >}}

and suppose we want to solve it with forward Euler. Because the problem is stiff, we need a very small \\( \Delta t \\) at the beginning, but later the solution is nice and smooth and a much larger \\( \Delta t \\) would do.

<p align="center"> <img alt="img/amath581/adaptive_forward_euler.svg" src="/r/img/amath581/adaptive_forward_euler.svg" width="600" /> </p>

<p align="center"><em>Forward Euler with adaptive step sizes chosen to keep the local truncation error below \( 10^{-3} \). Tick marks show the time steps \( t_n \): very dense through the initial transient, sparse afterwards.</em></p>

The trick is to let the update rule use a different step size at each step,

{{< katex display >}}
u_{n+1} = u_n + \Delta t_n f_n
{{< /katex >}}

which is simple enough. The important question is: **how should we choose \\( \Delta t_n \\)?**

## Estimating the Truncation Error

A simple approach is to estimate the local truncation error of the method and keep it below a tolerance. For forward Euler, Taylor's theorem gives

{{< katex display >}}
u(t_{n+1}) - u(t_n) - \Delta t_n f(t_n, u(t_n)) = \frac{\Delta t_n^2}{2} u''(\xi) \qquad \xi \in [t_n, t_{n+1}]
{{< /katex >}}

We can't evaluate \\( u'' \\) directly, but we can approximate it with a difference of first derivatives, which we *can* evaluate since \\( u' = f \\):

{{< katex display >}}
u''(\xi) \approx \frac{1}{\Delta t_n} \Big( u'(t_{n+1}) - u'(t_n) \Big) = \frac{1}{\Delta t_n} \Big( f(t_{n+1}, u(t_{n+1})) - f(t_n, u(t_n)) \Big)
{{< /katex >}}

So for the numerical solution, we choose \\( \Delta t_n \\) such that

{{< katex display >}}
\frac{\Delta t_n}{2} \left| f_{n+1} - f_n \right| \leq \text{TOL}
{{< /katex >}}

This is efficient: if the proposed {{< katex >}} \Delta t_n {{< /katex >}} is accepted, we already have {{< katex >}} f_{n+1} {{< /katex >}} for the next forward Euler step at no extra cost.

## Updating the Step Size

There are many strategies for adapting \\( \Delta t_n \\), mostly beyond the scope of the course. A simple one: start from the error estimate

{{< katex display >}}
\text{ERROR} = \frac{[\Delta t_n]_{\text{old}}}{2} \left| f_{n+1} - f_n \right| \approx C \, [\Delta t_n]_{\text{old}}^2
{{< /katex >}}

where {{< katex >}} [\Delta t_n]_{\text{old}} {{< /katex >}} is the step size we just tried. This lets us estimate {{< katex >}} C = \text{ERROR} / [\Delta t_n]_{\text{old}}^2 {{< /katex >}}. We want the new step to hit the tolerance, {{< katex >}} C \, [\Delta t_n]_{\text{new}}^2 = \text{TOL} {{< /katex >}}, so

{{< katex display >}}
[\Delta t_n]_{\text{new}} \leftarrow \left( \frac{\text{TOL}}{C} \right)^{1/2} = [\Delta t_n]_{\text{old}} \left( \frac{\text{TOL}}{\text{ERROR}} \right)^{1/2}
{{< /katex >}}

We iterate this until {{< katex >}} \Delta t_n {{< /katex >}} passes the tolerance test. The formula lets {{< katex >}} \Delta t_n {{< /katex >}} naturally *decrease*, but also *increase* when the error is much smaller than the tolerance. In practice we add a safety factor \\( s \in (0, 1] \\),

{{< katex display >}}
[\Delta t_n]_{\text{new}} \leftarrow s \cdot [\Delta t_n]_{\text{old}} \left( \frac{\text{TOL}}{\text{ERROR}} \right)^{1/2}
{{< /katex >}}

so the next attempt lands a bit under the tolerance rather than right at it.

```pseudocode
\begin{algorithm}
\caption{Adaptive Forward Euler}
\begin{algorithmic}
\State Given $c$, $f$, $T$, $\text{TOL}$, safety factor $s$, initial step $\Delta t$
\State Set $t = 0$, $u = c$, $f_{\text{old}} = f(0, c)$
\While{$t < T$}
    \State Set $\Delta t = \min(\Delta t, T - t)$
    \State Set $u_{\text{new}} = u + \Delta t \, f_{\text{old}}$
    \State Set $f_{\text{new}} = f(t + \Delta t, u_{\text{new}})$
    \State Set $\text{ERROR} = \frac{\Delta t}{2} |f_{\text{new}} - f_{\text{old}}|$
    \If{$\text{ERROR} \le \text{TOL}$}
        \State Accept: $t \gets t + \Delta t$, $u \gets u_{\text{new}}$, $f_{\text{old}} \gets f_{\text{new}}$
    \EndIf
    \State Set $\Delta t \gets s \cdot \Delta t \, (\text{TOL} / \text{ERROR})^{1/2}$
\EndWhile
\end{algorithmic}
\end{algorithm}
```

The step size is updated whether or not the step was accepted: a rejected step retries with a smaller \\( \Delta t \\), and an accepted step with a small error lets the next step grow. The course notebook uses \\( s = 0.9 \\), and also clamps each update to between \\( 0.2\times \\) and \\( 2\times \\) the old step so \\( \Delta t \\) can't change too abruptly. With \\( \text{TOL} = 10^{-3} \\) on \\( [0, 3] \\), it takes 194 accepted steps (plus 61 rejected attempts), ranging from \\( \Delta t = 4 \times 10^{-4} \\) in the transient to \\( 5.9 \times 10^{-2} \\) afterwards. A uniform step small enough for the transient would need about 7,500 steps.
