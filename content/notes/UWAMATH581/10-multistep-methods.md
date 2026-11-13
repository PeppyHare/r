---
title: "Higher Order Methods II: Linear Multistep Methods"
weight: 100
---

# Higher Order Methods II: Linear Multistep Methods

The [Runge-Kutta methods](../09-runge-kutta/) are **1-step methods**: the estimate of {{< katex >}} u_n {{< /katex >}} only depends on {{< katex >}} u_{n-1} {{< /katex >}}. This is a point of possible confusion, since an RK scheme still takes additional *stages* to compute {{< katex >}} u_n {{< /katex >}} (RK4 has three intermediate values). But all of those stages are built from {{< katex >}} u_{n-1} {{< /katex >}} alone, never from {{< katex >}} u_{n-2}, u_{n-3}, \ldots {{< /katex >}}.

In contrast, **linear multistep methods** (LMMs) estimate {{< katex >}} u_n {{< /katex >}} from several previous estimates {{< katex >}} u_{n-1}, u_{n-2}, u_{n-3}, \ldots {{< /katex >}}.

## 1- and 2-Step Methods

Introduce the shorthand

{{< katex display >}}
f_n = f(t_n, u_n)
{{< /katex >}}

Note this is *not* {{< katex >}} f(t_n, u(t_n)) {{< /katex >}}, which involves the true solution. A 1-step method is a rule for computing {{< katex >}} u_n {{< /katex >}} from {{< katex >}} u_{n-1} {{< /katex >}} and {{< katex >}} f_{n-1} {{< /katex >}} (and possibly {{< katex >}} f_n {{< /katex >}}). In this sense forward and backward Euler

{{< katex display >}}
u_n = u_{n-1} + \Delta t \, f_{n-1} \qquad u_n = u_{n-1} + \Delta t \, f_n
{{< /katex >}}

are 1-step methods. A 2-step method involves {{< katex >}} u_n, u_{n-1}, u_{n-2} {{< /katex >}} and {{< katex >}} f_n, f_{n-1}, f_{n-2} {{< /katex >}}. Examples we've already met in the homework are the 2-step Adams-Bashforth and Adams-Moulton methods

{{< katex display >}}
\begin{aligned}
&\text{(Adams-Bashforth, explicit)} & u_n &= u_{n-1} + \frac{\Delta t}{2} \left( 3 f_{n-1} - f_{n-2} \right) \\
&\text{(Adams-Moulton, implicit)} & u_n &= u_{n-1} + \frac{\Delta t}{12} \left( 5 f_n + 8 f_{n-1} - f_{n-2} \right)
\end{aligned}
{{< /katex >}}

2-step methods have a property we haven't seen before: **they are not self-starting**. We can only use them to compute {{< katex >}} u_n {{< /katex >}} for \\( n \geq 2 \\), since \\( n = 1 \\) would need the undefined {{< katex >}} u_{-1} {{< /katex >}}. So 2-step (and higher) LMMs need some other method to compute {{< katex >}} u_1 {{< /katex >}} first, typically a forward Euler step or a more accurate Runge-Kutta step.

### Constructing 1-Step LMMs

The family of 1-step LMMs comes from equations of the form

{{< katex display >}}
v(t + \Delta t) + \alpha_0 v(t) = \Delta t \Big( \beta_1 v'(t + \Delta t) + \beta_0 v'(t) \Big) + \mathcal{O}(\Delta t^{p+1})
{{< /katex >}}

for sufficiently smooth \\( v \\). We pick the coefficients {{< katex >}} \alpha_0, \beta_0, \beta_1 {{< /katex >}} to get a prescribed order \\( p \\), or the maximal possible order. Setting \\( v = u \\) and {{< katex >}} t = t_{n-1} {{< /katex >}}:

| {{< katex >}} (\alpha_0, \beta_0, \beta_1) {{< /katex >}} | Identity | Method | \\( p \\) |
|---|---|---|---|
| \\( (-1, 1, 0) \\) | {{< katex >}} v(t + \Delta t) - v(t) = \Delta t \, v'(t) + \mathcal{O}(\Delta t^2) {{< /katex >}} | forward Euler | 1 |
| \\( (-1, 0, 1) \\) | {{< katex >}} v(t + \Delta t) - v(t) = \Delta t \, v'(t + \Delta t) + \mathcal{O}(\Delta t^2) {{< /katex >}} | backward Euler | 1 |
| \\( (-1, \tfrac{1}{2}, \tfrac{1}{2}) \\) | {{< katex >}} v(t + \Delta t) - v(t) = \tfrac{\Delta t}{2} \left( v'(t + \Delta t) + v'(t) \right) + \mathcal{O}(\Delta t^3) {{< /katex >}} | trapezoid | 2 |

Notice \\( p \\) matches the order of consistency of each method. This is not a coincidence.

### Constructing 2-Step LMMs

The 2-step family comes from

{{< katex display >}}
\begin{aligned}
v(t + 2\Delta t) + \alpha_1 v(t + \Delta t) + \alpha_0 v(t) &= \Delta t \Big[ \beta_2 v'(t + 2\Delta t) + \beta_1 v'(t + \Delta t) + \beta_0 v'(t) \Big] \\
&\quad + \mathcal{O}(\Delta t^{p+1})
\end{aligned}
{{< /katex >}}

Again we pick {{< katex >}} \alpha_j, \beta_j {{< /katex >}} to get a desired or maximal order \\( p \\), and again, generally speaking, **the exponent \\( p \\) coincides with the order of consistency of the resulting LMM** (see Griffiths & Higham, *Numerical Methods for Ordinary Differential Equations*, Sec. 4).

### Deriving Adams-Bashforth

The coefficients come from Taylor expansions of \\( v \\). Start with

{{< katex display >}}
v(t + \Delta t) = v(t) + \Delta t \, v'(t) + \frac{1}{2} \Delta t^2 v''(t) + \mathcal{O}(\Delta t^3)
{{< /katex >}}

We want this accurate to \\( \mathcal{O}(\Delta t^3) \\), but we don't want to evaluate \\( v''(t) \\). We *are* comfortable evaluating \\( v \\) and \\( v' \\), since for the ODE these are \\( u(t) \\) and \\( f(t, u(t)) \\). So approximate \\( v'' \\) in terms of \\( v' \\), using the expansion

{{< katex display >}}
v'(t - \Delta t) = v'(t) - \Delta t \, v''(t) + \mathcal{O}(\Delta t^2)
\quad \to \quad
\Delta t \, v''(t) = v'(t) - v'(t - \Delta t) + \mathcal{O}(\Delta t^2)
{{< /katex >}}

Substituting back,

{{< katex display >}}
v(t + \Delta t) = v(t) + \Delta t \, v'(t) + \frac{\Delta t}{2} \Big( v'(t) - v'(t - \Delta t) \Big) + \mathcal{O}(\Delta t^3)
{{< /katex >}}

and reorganizing,

{{< katex display >}}
v(t + \Delta t) = v(t) + \frac{\Delta t}{2} \Big( 3 v'(t) - v'(t - \Delta t) \Big) + \mathcal{O}(\Delta t^3)
{{< /katex >}}

Now take \\( v = u \\), {{< katex >}} t_n = t + \Delta t {{< /katex >}}, {{< katex >}} t_{n-1} = t {{< /katex >}}, {{< katex >}} t_{n-2} = t - \Delta t {{< /katex >}}: this is exactly Adams-Bashforth.

If we instead approximate \\( v'' \\) with the *forward* expansion {{< katex >}} v'(t + \Delta t) = v'(t) + \Delta t \, v''(t) + \mathcal{O}(\Delta t^2) {{< /katex >}}, we get

{{< katex display >}}
v(t + \Delta t) = v(t) + \frac{\Delta t}{2} \Big( v'(t + \Delta t) + v'(t) \Big) + \mathcal{O}(\Delta t^3)
{{< /katex >}}

which is the implicit trapezoid method. It's only a 1-step method, but it's the implicit analogue of 2-step Adams-Bashforth in the sense of this derivation. To derive Adams-Moulton, keep the \\( v''' \\) term in the Taylor expansion and approximate both \\( v'' \\) and \\( v''' \\) with difference formulae in \\( v' \\); the resulting method is third-order accurate.

## General Form of LMMs

In general, a \\( k \\)-step LMM takes the form

{{< katex display >}}
\sum_{j=0}^{k} \alpha_j u_{n+j} = \Delta t \sum_{j=0}^{k} \beta_j f_{n+j}
{{< /katex >}}

with coefficients {{< katex >}} \alpha_j, \beta_j {{< /katex >}} to be chosen. Replacing {{< katex >}} u_{n+j} \leftarrow v(t_n + j\Delta t) {{< /katex >}} and {{< katex >}} f_{n+j} \leftarrow v'(t_n + j\Delta t) {{< /katex >}} for a smooth function \\( v \\), the LMM is analogous to the identity

{{< katex display >}}
\sum_{j=0}^{k} \alpha_j v(t_n + j\Delta t) = \Delta t \sum_{j=0}^{k} \beta_j v'(t_n + j\Delta t) + \mathcal{O}(\Delta t^{p+1})
{{< /katex >}}

and \\( p \\) turns out to be precisely the order of consistency of the LMM. We design an LMM by choosing the coefficients to obtain a desired \\( p \\), or the highest possible. Many choices are possible, giving rise to different families of methods.

### Order Conditions

A systematic approach: Taylor expand both sides about \\( t_n \\),

{{< katex display >}}
\begin{aligned}
v(t_n + j\Delta t) &= \sum_{m=0}^{p} \frac{v^{(m)}(t_n)}{m!} (j\Delta t)^m + \frac{v^{(p+1)}(\xi_j)}{(p+1)!} (j\Delta t)^{p+1} \\
\Delta t \, v'(t_n + j\Delta t) &= \sum_{m=0}^{p-1} \frac{v^{(m+1)}(t_n)}{m!} j^m \Delta t^{m+1} + \frac{v^{(p+1)}(\zeta_j)}{p!} j^p \Delta t^{p+1}
\end{aligned}
{{< /katex >}}

substitute into the identity, and cancel all terms of order \\( \Delta t^p \\) and below. Define

{{< katex display >}}
C_0 = \sum_{j=0}^{k} \alpha_j
\qquad
C_m = \sum_{j=0}^{k} \left( \frac{j^m}{m!} \alpha_j - \frac{j^{m-1}}{(m-1)!} \beta_j \right) \quad m = 1, \ldots, p
{{< /katex >}}

where {{< katex >}} C_m {{< /katex >}} is the coefficient of {{< katex >}} v^{(m)}(t_n) \Delta t^m {{< /katex >}} in the difference between the left and right sides.

> [!IMPORTANT]
>
> **Order conditions**
>
> The LMM has order \\( p \\) if
>
> {{< katex display >}}
C_0 = C_1 = \cdots = C_p = 0
{{< /katex >}}

That's \\( p + 1 \\) equations. The LMM has \\( 2k + 1 \\) unknown coefficients (we normalize \\( \alpha_k = 1 \\)), so in principle we could reach order \\( p = 2k \\) if we ignore other issues such as stability. In practice we work with \\( p < 2k \\), which leaves free parameters to improve the computational cost or the stability properties of the method; see Griffiths & Higham for the stability theory of LMMs. (Stability really does bite here: the *first Dahlquist barrier* says a 0-stable \\( k \\)-step LMM has order at most \\( k + 2 \\), and at most \\( k + 1 \\) if \\( k \\) is odd.)

### Example: Checking Adams-Bashforth

For AB2 written as a 2-step LMM, {{< katex >}} u_{n+2} - u_{n+1} = \Delta t \left( \tfrac{3}{2} f_{n+1} - \tfrac{1}{2} f_n \right) {{< /katex >}}, so \\( \alpha = (0, -1, 1) \\) and \\( \beta = (-\tfrac{1}{2}, \tfrac{3}{2}, 0) \\):

{{< katex display >}}
\begin{aligned}
C_0 &= 0 - 1 + 1 = 0 \\
C_1 &= (0 - 1 + 2) - \left(-\tfrac{1}{2} + \tfrac{3}{2} + 0\right) = 0 \\
C_2 &= \left(0 - \tfrac{1}{2} + 2\right) - \left(0 + \tfrac{3}{2} + 0\right) = 0 \\
C_3 &= \left(0 - \tfrac{1}{6} + \tfrac{8}{6}\right) - \left(0 + \tfrac{3}{4} + 0\right) = \tfrac{5}{12} \neq 0
\end{aligned}
{{< /katex >}}

so AB2 has order exactly \\( p = 2 \\).

## Families of LMMs

This line of thinking gives rise to many families of LMMs.

**Explicit Adams** (Adams-Bashforth): {{< katex >}} \alpha_k = 1 {{< /katex >}}, {{< katex >}} \alpha_{k-1} = -1 {{< /katex >}}, all other {{< katex >}} \alpha_j = 0 {{< /katex >}}, and {{< katex >}} \beta_k = 0 {{< /katex >}}:

{{< katex display >}}
u_{n+k} - u_{n+k-1} = \Delta t \sum_{j=0}^{k-1} \beta_j f_{n+j}
{{< /katex >}}

The choice \\( \beta_k = 0 \\) is crucial: it makes the method explicit.

**Implicit Adams** (Adams-Moulton): the only difference is that \\( \beta_k \\) is included in the sum, which makes the method implicit:

{{< katex display >}}
u_{n+k} - u_{n+k-1} = \Delta t \sum_{j=0}^{k} \beta_j f_{n+j}
{{< /katex >}}

**Backward Differentiation Formulae** (BDF):

{{< katex display >}}
\sum_{j=0}^{k} \alpha_j u_{n+j} = \Delta t \, \beta_k f_{n+k}
{{< /katex >}}

This family is popular for solving stiff problems, and can be viewed as a generalization of backward Euler (which is BDF1). For example, BDF2 is {{< katex >}} u_{n+2} - \tfrac{4}{3} u_{n+1} + \tfrac{1}{3} u_n = \tfrac{2}{3} \Delta t \, f_{n+2} {{< /katex >}}.
