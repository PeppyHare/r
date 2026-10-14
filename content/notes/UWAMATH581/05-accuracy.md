---
title: "Accuracy"
weight: 50
---

# Accuracy

We've noticed some peculiar things about Euler's methods: on the test ODE the numerical solutions deviated from the truth, and in some regimes forward Euler went unstable while backward Euler didn't. Let's dig deeper, starting with convergence and numerical accuracy.

## Convergence

At the very least, our numerical scheme should converge to the true solution as the resolution increases, i.e. as the discretization size goes to zero.

> [!NOTE]
>
> ### Definition: **Convergence of an ODE solver**
>
> Consider an ODE with a ground truth solution \\( u : [0, T] \to \mathbb{R} \\), and an ODE solver that, for an integer \\( N \\), produces a sequence of approximations
>
> {{< katex display >}}
u_n \approx u(t_n) \qquad t_n = n \Delta t \qquad n = 0, 1, \ldots, N \qquad \Delta t = \frac{T}{N}
{{< /katex >}}
>
> We say that the method is **convergent** if
>
> {{< katex display >}}
\lim_{\Delta t \to 0} \max_{0 \leq n \leq N} |u(t_n) - u_n| = 0
{{< /katex >}}

The definition can be adjusted for different purposes, e.g. if we only care about the final time we could ask for {{< katex >}} \lim_{\Delta t \to 0} |u(T) - u_N| = 0 {{< /katex >}}. Note that convergence also depends on the ground truth: at the very least it has to be well-defined.

Empirically, convergence looks like the numerical solution approaching the truth as \\( \Delta t \\) shrinks. For forward Euler on the test ODE (real \\( \lambda \\)):

<p align="center"> <img alt="img/amath581/test_ode_convergence_solution.png" src="/r/img/amath581/test_ode_convergence_solution.png" width="32%" style="min-width: 0" /> <img alt="img/amath581/test_ode_convergence_error.png" src="/r/img/amath581/test_ode_convergence_error.png" width="32%" style="min-width: 0" /> <img alt="img/amath581/test_ode_convergence_error_semilogy.png" src="/r/img/amath581/test_ode_convergence_error_semilogy.png" width="32%" style="min-width: 0" /> </p>

<p align="center"><em>Left: numerical solutions approach the truth. Middle: errors \( |u(t_n) - u_n| \) shrink with \( \Delta t \). Right: the same errors on a semilog scale, which we routinely use since errors are small.</em></p>

## Numerical Accuracy

Convergence alone is a pretty weak statement (though without it the algorithm is useless). It's a more useful concept for comparing schemes if we consider the *rate* at which the limit goes to zero, i.e. how accurate the method is. We consider two types of error.

The **global error** is the difference between the true and numerical solutions

{{< katex display >}}
e_n = u(t_n) - u_n \qquad n = 1, 2, \ldots, N
{{< /katex >}}

We usually look at \\( |e_n| \\), since the sign is less important than the magnitude.

The **local truncation error** asks: how close is the actual solution to satisfying the discretization of the ODE? I.e. it measures the error introduced by the scheme in a single step. For forward Euler this is

{{< katex display >}}
\tau_n = \frac{u(t_n) - u(t_{n-1})}{\Delta t} - f(t_{n-1}, u(t_{n-1})) \equiv \mathcal{N}_{\Delta t}^{FE}[u(t_n)] \qquad n = 1, 2, \ldots
{{< /katex >}}

the residual of the discretized ODE after plugging in the true solution. We call {{< katex >}} \mathcal{N}_{\Delta t} {{< /katex >}} the **difference operator** of the scheme. (The notation hides that \\( \mathcal{N} \\) depends on \\( f \\), {{< katex >}} t_{n-1} {{< /katex >}}, and {{< katex >}} u(t_{n-1}) {{< /katex >}} — think of it as an operator acting on {{< katex >}} u(t_n) {{< /katex >}} with parameters that are known either as problem inputs or from previous steps.) Other schemes just use a different difference operator, e.g. for backward Euler

{{< katex display >}}
\mathcal{N}_{\Delta t}^{BE}[u(t_n)] = \frac{u(t_n) - u(t_{n-1})}{\Delta t} - f(t_n, u(t_n))
{{< /katex >}}

So global and local truncation errors fit in a unified framework for arbitrary ODE solvers. If you want something concrete to ground your reading, just keep forward Euler in mind. It'll turn out the local truncation error is closely related to the global error.

### Order of Accuracy and Convergence

Following Ascher & Petzold:

> [!NOTE]
>
> ### Definition: **Order of accuracy / convergence**
>
> A scheme is **accurate** (or **consistent**) of order \\( p \\) if
>
> {{< katex display >}}
\tau_n = \mathcal{O}(\Delta t^p) \qquad n = 1, 2, \ldots
{{< /katex >}}
>
> A scheme is **convergent** of order \\( p \\) if
>
> {{< katex display >}}
e_n = \mathcal{O}(\Delta t^p) \qquad n = 1, 2, \ldots
{{< /katex >}}

Disclaimer: order of convergence does not necessarily equal order of accuracy! BUT for every method we will be working with, they are equal. It's usually easy to control the local truncation error and verify the order of accuracy.

### Example: Euler Methods Are First-Order Accurate

Both forward and backward Euler are first-order accurate (left as a homework assignment). Taylor expanding directly gives

{{< katex display >}}
\tau_n^{FE} = \frac{\Delta t}{2} u''(t_n) + \mathcal{O}(\Delta t^2) \qquad \tau_n^{BE} = -\frac{\Delta t}{2} u''(t_n) + \mathcal{O}(\Delta t^2)
{{< /katex >}}

## Empirical Validation of the Order of Convergence

It turns out both Euler methods are also first-order convergent. That's harder to prove (see [next lecture](../06-convergence-and-lax/)), but we can pretty convincingly show it empirically. If \\( |e_n| \approx C \Delta t^p \\), then

{{< katex display >}}
\log |e_n| \approx \log C + p \log \Delta t
{{< /katex >}}

so the slope of \\( \log |e_n| \\) against \\( \log \Delta t \\) estimates \\( p \\). The recipe:

1. Pick a problem for which you have an analytic solution \\( u(t) \\)
2. Implement your method to obtain \\( u_n \\) for different choices of \\( \Delta t \\)
3. For each \\( \Delta t \\), compute the error {{< katex >}} |e_n| = |u(t_n) - u_n| {{< /katex >}}
4. Plot \\( \log |e_n| \\) against \\( \log \Delta t \\) and check that the slope is \\( p \\)

Since the error bound holds uniformly in \\( n \\), it's usually sufficient to use {{< katex >}} \max_n |e_n| {{< /katex >}}. The average {{< katex >}} \frac{1}{N} \sum_n |e_n| {{< /katex >}} also works and gives the same rate for ODE solvers — but for other kinds of algorithms the average rate can be better than the max rate, so be careful interpreting it.

For example, forward Euler on [Stefan's ice-growth problem](../04-nonlinear-systems/#example-growing-ice-thickness), with exact solution \\( u(t) = \sqrt{2Dt + c^2} \\):

<p align="center"> <img alt="img/amath581/stefan_forward_euler_convergence.png" src="/r/img/amath581/stefan_forward_euler_convergence.png" width="450" /> </p>

<p align="center"><em>\( \max_n |e_n| \) against \( \Delta t \) for forward Euler on Stefan's ice-growth problem.</em></p>

## Trapezoid Method

Let's take a look at our first second-order accurate scheme, the (symmetric) trapezoid method

{{< katex display >}}
\frac{u_n - u_{n-1}}{\Delta t} = \frac{1}{2}\left( f(t_{n-1}, u_{n-1}) + f(t_n, u_n) \right)
{{< /katex >}}

This is implicit, since {{< katex >}} f(t_n, u_n) {{< /katex >}} appears on the right-hand side. For the truncation error, it helps to Taylor expand about the midpoint {{< katex >}} t_{n-1/2} = \frac{1}{2}(t_{n-1} + t_n) {{< /katex >}}

<!-- figure: a line segment with three points marked, labeled u_{n-1}, u_{n-1/2}, and u_n from left to right. -->

{{< katex display >}}
\begin{aligned}
u(t_n) &= u(t_{n-1/2}) + \frac{\Delta t}{2} u'(t_{n-1/2}) + \frac{\Delta t^2}{8} u''(t_{n-1/2}) + \frac{\Delta t^3}{48} u'''(t_{n-1/2}) + \mathcal{O}(\Delta t^4) \\
u(t_{n-1}) &= u(t_{n-1/2}) - \frac{\Delta t}{2} u'(t_{n-1/2}) + \frac{\Delta t^2}{8} u''(t_{n-1/2}) - \frac{\Delta t^3}{48} u'''(t_{n-1/2}) + \mathcal{O}(\Delta t^4)
\end{aligned}
{{< /katex >}}

Subtracting, the even terms cancel

{{< katex display >}}
\frac{u(t_n) - u(t_{n-1})}{\Delta t} = u'(t_{n-1/2}) + \frac{\Delta t^2}{24} u'''(t_{n-1/2}) + \mathcal{O}(\Delta t^4)
{{< /katex >}}

To make this useful, we need {{< katex >}} u'(t_{n-1/2}) {{< /katex >}} in terms of the endpoints, so expand \\( u' \\) about {{< katex >}} t_{n-1/2} {{< /katex >}} in both the \\( +\frac{\Delta t}{2} \\) and \\( -\frac{\Delta t}{2} \\) directions

{{< katex display >}}
\begin{aligned}
u'(t_n) &= u'(t_{n-1/2}) + \frac{\Delta t}{2} u''(t_{n-1/2}) + \frac{\Delta t^2}{8} u'''(t_{n-1/2}) + \mathcal{O}(\Delta t^3) \\
u'(t_{n-1}) &= u'(t_{n-1/2}) - \frac{\Delta t}{2} u''(t_{n-1/2}) + \frac{\Delta t^2}{8} u'''(t_{n-1/2}) + \mathcal{O}(\Delta t^3)
\end{aligned}
{{< /katex >}}

Averaging, now the odd terms cancel

{{< katex display >}}
\frac{1}{2}\left( u'(t_n) + u'(t_{n-1}) \right) = u'(t_{n-1/2}) + \frac{\Delta t^2}{8} u'''(t_{n-1/2}) + \mathcal{O}(\Delta t^4)
{{< /katex >}}

and since \\( u' = f(t, u) \\) for the true solution, all together

{{< katex display >}}
\tau_n = \frac{u(t_n) - u(t_{n-1})}{\Delta t} - \frac{1}{2}\left( f(t_n, u(t_n)) + f(t_{n-1}, u(t_{n-1})) \right) = \left( \frac{1}{24} - \frac{1}{8} \right) \Delta t^2 u'''(t_{n-1/2}) + \mathcal{O}(\Delta t^4)
{{< /katex >}}

{{< katex display >}}
\tau_n = -\frac{\Delta t^2}{12} u'''(t_{n-1/2}) + \mathcal{O}(\Delta t^4) = \mathcal{O}(\Delta t^2)
{{< /katex >}}

So the trapezoid method is \\( 2^{\text{nd}} \\)-order accurate.

Keep in mind, we needed to assume \\( u \\) is sufficiently smooth (three times continuously differentiable) to show this. The method won't achieve this order of accuracy if e.g. \\( u''' \\) is not bounded.
