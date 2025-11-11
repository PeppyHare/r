---
title: Laplace Transforms
weight: 90
---

{{< katex display >}}

{{< /katex >}}

# Laplace Transform

We all know \\( \mathcal{L} \\) from our undergrad differential equations or electronics classes, but we never got the inverse transform back then, so let's fill in that gap.

The Laplace transform is the same as the one-sided Fourier transform with \\( -i \lambda \\) replaced by \\( s \\) (or \\( -s = + i \lambda \\) )

{{< katex display >}}
\hat{f}(s) = \mathcal{L} [f(t)] = \int _0 ^{\infty} e^{- s t} f(t) \dd t = F(is) = F(\lambda)
{{< /katex >}}

This makes a couple of things clearer. The Laplace transform integral that looked like a completely real integrand actually has a purely imaginary argument in the exponential. And when we look at the inverse Fourier transform, with \\( -s = i \lambda \\), the integral is actually going up and down in the imaginary direction

{{< katex display >}}
f(t) = \mathcal{K} ^{-1} [\hat{f}(s)] = \frac{1}{2 \pi} \int _{-\infty + i \alpha} ^{\infty + i \alpha} e^{- i \lambda t} F(\lambda) \dd \lambda \\
= \frac{1}{2 \pi i} \int_{-i \infty + \alpha } ^{i \infty + \alpha} e^{st} \hat{f} (s) \dd s
{{< /katex >}}

<p align="center"> <img alt="laplace-contour.png" src="/r/img/aa567/laplace-contour.png" width="300px" /> </p>

The path we take to close the contour depends on the sign of \\( t \\). For \\( t < 0 \\), we close on the right by Jordan's lemma (just rotate everything by \\( \pi / 2 \\) ). As it turns out, to make the function integrable, we must take \\( \alpha \\) to be to the right of all singularities of \\( f(t) \\). Since that is the case, there are no poles to the right of the contour and we get zero.

Closing to the left,

{{< katex display >}}
f(t) = \sum \text{Res} [ e^{st} \hat{f}(s)]
{{< /katex >}}

in the complex plane if there are no branch cuts or branch points. If you do have a branch cut in \\( f(s) \\), then we modify the Bromwich contour like this:

<p align="center"> <img alt="laplace-contour-2.png" src="/r/img/aa567/laplace-contour-2.png" width="300px" /> </p>

Example:

{{< katex display >}}
\mathcal{L} [1] = \int _0 ^{\infty} e^{-st} \dd t = \frac{e^{-st}}{s} |_{0} ^{\infty} = \frac{1}{s} \quad \text{ if } \text{Re}(s) > 0
{{< /katex >}}
{{< katex display >}}
\mathcal{L}^{-1} [\frac{1}{s}] = \frac{1}{2 \pi i} \int_L e^{st}{s} \dd s = \begin{cases} \text{Res} [\frac{e^{st}}{s}; s = 0] & t > 0 \\ 0 & t < 0 \end{cases} \\
= \begin{cases} 1 & t > 0 \\ 0 & t < 0 \end{cases}
{{< /katex >}}

## Laplace Transform of Derivatives

{{< katex display >}}
\mathcal{L} [f'(t)] = \int _0 ^{\infty} e^{-st} f'(t) \dd t \\
= e^{-st} f(t) |_0 ^{\infty} + s \int _0 ^\infty e^{-st} f(t) \dd t \\
= s \mathcal{L} [f(t)] - f(0)
{{< /katex >}}
{{< katex display >}}
\mathcal{L} [f''(t)] = s \mathcal{L} [f(t)] - f(0) - f'(0)
{{< /katex >}}

where we assume that \\( e^{-st} f(t) \rightarrow 0 \\) and \\( e^{-st} f'(t) \rightarrow 0 \\) as \\( t \rightarrow \infty \\).

We want to use Laplace transforms to solve differential equations. In particular, the spicy partial differential equations. Let's start with the wave equation:

{{< katex display >}}
\pdv{^2}{t^2} u - c^2 \pdv{^2}{x^2} u = 0 \qquad -\infty < x < \infty \qquad t > 0
{{< /katex >}}
with boundary conditions

{{< katex display >}}
u \rightarrow 0 \quad \text{ as } x \rightarrow \pm \infty
{{< /katex >}}
{{< katex display >}}
u(x, 0) = f(x) \qquad \pdv{}{t} u(x, 0) = 0 \qquad (\text{or } g(x))
{{< /katex >}}
First, define \\( U(\lambda, t) \\) as the Fourier transform of \\( u \\) in \\( x \\)

{{< katex display >}}
U(\lambda, t) = \int_{-\infty}^{\infty}e^{i \lambda x} u(x, t) \dd x
{{< /katex >}}

Here, we are starting to play fast and loose with the rules, and we will make the pure mathematicians mad :) We *should* prove that a solution \\( u(x, t) \\) to our PDE actually exists, and that the solution is integrable (so its Fourier transform exists). But it's way easier to ask for forgiveness than to ask for permission. We assume both of these. If we find \\( u(x, t) \\), then it exists and we can check for integrability after the fact.

{{< katex display >}}
\mathcal{F} \left[ \pdv{^2u}{x^2} \right] = \int_{-\infty}^{\infty}e^{i \lambda x} \pdv{^2 u}{x^2} \dd x \\
= e^{i \lambda x} \pdv{}{x} u |_{-\infty} ^{\infty} - i \lambda \int_{-\infty}^{\infty}e^{i \lambda x} \pdv{}{x} u \dd x \\
= e ^{i \lambda x} \pdv{}{x} u |_{-\infty} ^{\infty} - i \lambda e^{i \lambda x } u |_{-\infty} ^{\infty} + (i \lambda) ^2 U
{{< /katex >}}

We aren't given \\( \pdv{}{x} u \rightarrow 0 \\) as \\( x \rightarrow \pm \infty \\), but we'll assume it to get rid of the boundary terms. There's another thing we need to come back and check at the end!

{{< katex display >}}
\mathcal{F}\left[ \pdv{^2u}{x^2} \right] = - \lambda^2 U
{{< /katex >}}
{{< katex display >}}
\mathcal{F} \left[ \pdv{^2 u}{t^2} \right] = \pdv{^2}{t^2} \mathcal{F}[u]
{{< /katex >}}

So the wave equation now looks like
{{< katex display >}}
\pdv{^2}{t^2} U = - (c \lambda)^2 U
{{< /katex >}}
{{< katex display >}}
\rightarrow U(\lambda, t) = A(\lambda) \cos (c \lambda t) + B(\lambda) \sin (c \lambda t)
{{< /katex >}}

Applying boundary conditions,

{{< katex display >}}
\pdv{}{t} U(\lambda, 0) = 0 \qquad U(\lambda, 0) = F(\lambda) = \mathcal{F}[f(x)]
{{< /katex >}}
{{< katex display >}}
\rightarrow B(\lambda) = 0 \qquad A(\lambda) = F(\lambda)
{{< /katex >}}
{{< katex display >}}
U(\lambda, t) = F(\lambda) \cos (c \lambda t)
{{< /katex >}}
{{< katex display >}}
u(x, t) = \mathcal{F}^{-1} [U(\lambda, t)] = \frac{1}{2 \pi} \int_{-\infty}^{\infty}U(\lambda, t) e^{- i \lambda t} \dd \lambda\\
= \frac{1}{2 \pi } \int_{-\infty}^{\infty}F(\lambda) \cos (c \lambda t) e^{- i \lambda t} \dd \lambda \\
= \frac{1}{2 \pi} \int_{-\infty}^{\infty}\frac{1}{2} F(\lambda) e^{- i \lambda (x - ct)} \dd \lambda + \frac{1}{2 \pi} \int_{-\infty}^{\infty}\frac{1}{2} F(\lambda) e^{- i \lambda( x + ct)} \dd \lambda
{{< /katex >}}

But by definition,

{{< katex display >}}
f(x) = \frac{1}{2 \pi} \int_{-\infty}^{\infty} F(\lambda) e^{-i \lambda t} \dd \lambda
{{< /katex >}}

so

{{< katex display >}}
u(x, t) = \frac{1}{2} f(x - ct) + \frac{1}{2} f(x + ct)
{{< /katex >}}

So, are we done? No! We took some shortcuts that we still need to justify. If \\( f(x) \\) is of compact support, then we're good on the \\( f(x \rightarrow \pm \infty) \\) and \\( f'(x \rightarrow \pm \infty) \\) boundary conditions. Also as long as \\( f(x) \\) has a Fourier transform, then \\( u(x, t) \\) also has a Fourier transform. That means our bases are covered and we have nothing to apologize for.
