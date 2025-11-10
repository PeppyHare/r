---
title: Fourier Transforms
weight: 80
---

{{< katex display >}}

{{< /katex >}}

# Fourier Transform

It's good to start out with the definition of a Fourier transform:

{{% hint info %}}
{{< katex display >}}
{{< /katex >}}
**Fourier Transform**

{{< katex display >}}
\mathcal{F}(f(t)) \equiv F(\lambda) \equiv \int_{-\infty}^{\infty}e^{i \lambda t} f(t) \dd t
{{< /katex >}}

Note: \\( t \\) does not necessarily denote time, as it generally does in the Laplace transform. It's just a dummy variable in the integration and is often a spatial coordinate.

To recover \\( f(t) \\) we also have the inverse Fourier transform

{{< katex display >}}
f(t) = \mathcal{F} ^{-1} (F(\lambda)) = \frac{1}{2 \pi} \int_{-\infty}^{\infty}e^{- i \lambda t} F(\lambda) \dd \lambda
{{< /katex >}}

{{% /hint %}}

{{% hint info %}}
{{< katex display >}}
{{< /katex >}}
**Fourier's Theorem**

This is what gives us the ability to write down the inverse transform. We won't derive the theorem here since that is usually done in an earlier course. The general approach starts with the Fourier series expansion and takes the limit to converge to the Riemann sum of the integral. The theorem states:

{{< katex display >}}
f(t) = \frac{1}{2 \pi} \int_{-\infty}^{\infty} \dd \lambda \int_{-\infty}^{\infty}\dd \tau e^{i \lambda ( \tau - t)} f(\tau)
{{< /katex >}}

This is valid for any piecewise smooth \\( f(t) \\) which is integrable.

{{% /hint %}}

If we think about it, it's amazing that we can recover \\( f(t) \\) after all of that. The key is that \\( e^{i \lambda t}, e^{-i \lambda t} \\) form a complete, orthogonal basis for all piecewise smooth integrable functions.

For consistency, we need to make sure we consistently place the \\( \pm \\) exponent on the transform and the factor of \\( 1/2 \pi \\), since they are arbitrary choices.

"Piecewise smooth" means that over any interval, we can subdivide into a finite number of pieces where the function is smooth. We can have a finite number of jumps, but the function can never jump to infinity.

Example:

{{< katex display >}}
f(t) = \frac{1}{t^2 + 4} \qquad - \infty < t < \infty
{{< /katex >}}

{{< katex display >}}
F(\lambda) = \int_{-\infty}^{\infty} \frac{e^{i \lambda t}}{t ^2 + 4 } \dd t
{{< /katex >}}

As a real integral, this isn't the easiest thing to do. But we can use Jordan's lemma to make it simple for us. \\( 1 / z^2 + 4 \\) gotes to zero as \\( |z| \rightarrow \infty \\), so

{{< katex display >}}
F(\lambda) = \oint _{UHP} \frac{e^{i \lambda z}}{z^2 + 4} \dd z
{{< /katex >}}

{{< katex display >}}
\lambda > 0 \rightarrow F(\lambda) = 2 \pi i  \text{Res} \frac{e^{i \lambda z}}{z^2 + 4} \text{ at } z = - 2 i \\
= - 2 \pi i \frac{e^{i \lambda (-2i)}}{2 (-2 i)} = \frac{\pi}{2} e^{2 \lambda}
{{< /katex >}}

{{< katex display >}}
F(\lambda) = \frac{\pi}{2 } e^{- 2 |\lambda|} \qquad -\infty < \lambda < \infty
{{< /katex >}}

Let's take our inverse transform for a spin to show that it works!

{{< katex display >}}
f(t) = \frac{1}{2\pi} \int_{-\infty}^{\infty} e^{- i \lambda t} F(\lambda) \dd \lambda \\
= \frac{1}{4} \int_{-\infty}^{\infty}e^{-i \lambda t} e^{- 2 |\lambda|} \dd \lambda \\
= \frac{1}{4} \left( \int _0 ^\infty e^{- (it + 2)\lambda} \dd \lambda + \int _{-\infty} ^{0} e^{- (it - 2) \lambda} \dd \lambda \right) \\
= \frac{1}{4} \frac{e^{- (it + 2) \lambda}}{- (it + 2)} | _0 ^{\infty} - \frac{1}{4} \frac{e^{- (it - 2)\lambda}}{- (it - 2)} | _{-\infty} ^0 \\
= \frac{1}{4} \frac{1}{(it + 2)} - \frac{1}{4} \frac{1}{(it - 2)} \\
= \frac{1}{t^2 + 4}
{{< /katex >}}

This is pretty cool, but in real life the powerful use of the transform is in solving partial differential equations.

## Fourier Transform of Derivatives

{{< katex display >}}
\mathcal{F}(f'(t)) = \int_{-\infty}^{\infty}e^{i \lambda t} f'(t) \dd t \\
= e^{i \lambda t} f(t) |_{- \infty} ^{\infty} - i \lambda \int_{-\infty}^{\infty}e^{i \lambda t }f (t) \dd t
{{< /katex >}}

We've required that \\( f(t) \\) is integrable, so the boundary term must vanish. \\( f(t) |^{\pm \infty} = 0 \\). This is actually a pretty major restriction on Fourier transforms. Many familiar functions are not totally integrable, but we often want to use their Fourier transform. The generalized Fourier transform solves this by restricting the transform in the direction that is integrable, then setting the function to zero in the other direction. This is very related to the Laplace transform, which is always one-sided.

Let's do some examples

{{< katex display >}}
f(t) = e^{- t} \quad \rightarrow \quad F(\lambda) = \int_{-\infty}^{\infty}e^{i \lambda t - t} \dd t = \left.\frac{1}{i \lambda - 1} e^{i (\lambda - 1)t} \right|_{-\infty} ^{\infty}
{{< /katex >}}
This limit does not exist as \\( t \rightarrow -\infty \\). Similarly, the transform of \\( f(t) = e^{t} \\) blows up as \\( t \rightarrow \infty \\). To overcome this we, can consider a one-sided version of the function

{{< katex display >}}
f(t) = \begin{cases}  f(t) & t \geq 0 \\ 0 & t < 0 \end{cases}
{{< /katex >}}

These functions do have a well-defined Fourier transform

{{< katex display >}}
f(t) = \begin{cases} e^{-i \lambda_0 t} & t \geq 0 \\ 0 & t < 0 \end{cases}
{{< /katex >}}
{{< katex display >}}
F(\lambda) = \int _0 ^\infty e^{i (\lambda - \lambda _0)t} \dd t = \frac{e^{i (\lambda - \lambda_0)t}}{i (\lambda - \lambda_0)}
{{< /katex >}}

This limit does not exist for purely real \\( \lambda \\), since it oscillates forever in the \\( + \infty \\) direction. But if there is a small positive imaginary part of \\( \lambda \\) then the limit is
{{< katex display >}}
F(\lambda) = \frac{i}{\lambda - \lambda_0}
{{< /katex >}}

Now we want an inverse Fourier transform for this:

{{< katex display >}}
f(t) = \frac{1}{2 \pi} \int_{-\infty}^{\infty}\frac{i}{\lambda - \lambda_0} e^{- i \lambda t} \dd \lambda
{{< /katex >}}

Now we've made ourselves an improper integral. But at least we know how we got here! (it was by letting \\( \text{Im}(\lambda) > 0 \\) ). We should not try to convert this into a principal value integral, because we will get a different answer that way.

Instead, we need to modify the inverse transform! This is because Fourier's theorem is only valid for an integrable function. So how should we fix it? If \\( f(t) \\) is not integrable, but \\( g(t) = e^{- \alpha t} f(t) \\) is integrable (e.g. \\( f(t) \sim e^{a t} \rightarrow g(t) \sim e^{-(\alpha - a)t} \\) if \\( \alpha > a \\) ). The Fourier theorem then applies to \\( g(t) \\)

{{< katex display >}}
G(\lambda) = \int_{-\infty}^{\infty}e^{i \lambda t} g(t) \dd t = \int_{-\infty}^{\infty}e^{i (\lambda + i \alpha)t} f(t) \dd t \\
= F(\lambda + i \alpha)
{{< /katex >}}

So, we can relate \\( G(\lambda) \\) to \\( F(\lambda + i \alpha) \\). We know the inverse transform for \\( G(\lambda) \\)

{{< katex display >}}
g(t) = \frac{1}{2 \pi } \int_{-\infty}^{\infty}e^{- i \lambda t} G(\lambda) \dd \lambda \\
= \frac{1}{2 \pi} \int_{-\infty}^{\infty}e^{- i \lambda t} F( \lambda + i \alpha) \dd \lambda
{{< /katex >}}
{{< katex display >}}
f(t) = \frac{1}{2 \pi} \int_{-\infty}^{\infty}e^{-i (\lambda + i \alpha) t} F(\lambda + i \alpha) \dd \lambda
{{< /katex >}}
(let \\( \hat{\lambda} = \lambda + i \alpha \\) )
{{< katex display >}}
f(t) = \frac{1}{2 \pi} \int_{-\infty + i \alpha}^{\infty + i \alpha} e^{- i \hat{\lambda} t} F(\hat{\lambda}) \dd \hat{\lambda}
{{< /katex >}}

For our example, we just need \\( \alpha > 0 \\) to make \\( g(t) \\) integrable. Now the contour of integration sits just above the real axis.

<p align="center"> <img alt="fourier-contour-1.png" src="/r/img/aa567/fourier-contour-1.png" width="300px" /> </p>

By Cauchy's theorem, this is the same as the indented contour going just above \\( \lambda_0 \\)

{{< katex display >}}
f(t) = \frac{1}{2 \pi} \int _{\Omega} \frac{e^{- i \lambda t}}{\lambda - \lambda_0} \dd \lambda
{{< /katex >}}

We can use Jordan's lemma for this. For \\( t < 0 \\), \\( e^{- i \lambda t} \\) has a positive exponent so we close in the upper half plane. Closing above, we now have a contour that does not contain any singularities, so \\( f(t) = 0 \\). That's exactly what we think we should get for our single-sided function.

For \\( t > 0 \\), we need to close in the lower half plane, so we enclose the singularity at \\( \lambda = \lambda_0 \\)

{{< katex display >}}
\text{Res} \left[ \frac{e^{- i \lambda t}}{\lambda - \lambda_0}; \lambda = \lambda_0 \right] = \lim_{\lambda \rightarrow \lambda_0} \frac{(\lambda - \lambda_0)e^{- i \lambda t}}{\lambda - \lambda_0} = e^{-i \lambda_0 t}
{{< /katex >}}

and we've successfully recovered our one-sided \\( f(t) \\).

In general, if we go from \\( f(t) \\) to \\( F(\lambda) \\) and we find that \\( f(t) \\) is not integrable, then \\( F(\lambda) \\) exists for some \\( \text{Im}(\lambda) > \alpha \\)

{{< katex display >}}
F(\lambda) = \frac{i}{\lambda - \lambda_0}
{{< /katex >}}

is not singular on the real axis, and the inverse transform should integrate along \\( (- \infty + i \alpha, \infty + i \alpha) \\) i.e. above the axis.

Of course, in most applications we don't have prior knowledge of \\( f(t) \\). We usually end up with a partial differential equation where we have assumed an expression for \\( F(\lambda) \\). Given the \\( F(\lambda) = i / (\lambda - \lambda_0) \\), this appears to give an improper integral

{{< katex display >}}
f(t) = \frac{1}{2 \pi} \int_{-\infty}^{\infty}e^{-i \lambda t} F(\lambda) \dd \lambda
{{< /katex >}}

In this case, we should not just take the principal value integral because integrating along the contour is not the same as the principal value limit! The correct approach is to apply the causality condition! If we end up with a singularity on the path of integration, then something must be wrong with the physics of the problem. Taking the indented contour going just above the singularity corresponds with allowing for a small \\( \text{Im}(\lambda) > 0 \\), which means \\( f(t) \\) does not diverge faster than \\( e^{\alpha \lambda} \\) for some \\( \lambda > 0 \\).
