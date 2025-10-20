---
title: Residue calculus and applications of contour integration
weight: 50
---

{{< katex display >}}

{{< /katex >}}



# Residues

If \\( z_0 \\) is an isolated singularity, and \\( f(z) \\) can be written as a series

{{< katex display >}}
f(z) = \sum_{n=-\infty} ^\infty a_n (z - z_0)^n
{{< /katex >}}

which is valid in a punctured neighborhood of \\( z_0 \\), then

{{< katex display >}}
\oint_C f(z) \dd z = 2 \pi i a_{-1}
{{< /katex >}}

where \\( C \\) is a simple closed curve in the neighborhood enclosing \\( z_0 \\). This is because

{{< katex display >}}
\oint_C (z - z_0)^n \dd z = \begin{cases} 0 & \quad n \neq -1 \\ 2 \pi i & \quad n = -1 \end{cases}
{{< /katex >}}

We call \\( a_{-1} \\) the **residue** at \\( z_0 \\).

Now we can write down the residue theorem:

{{% hint info %}}
{{< katex display >}}
{{< /katex >}}
**Cauchy's Residue Theorem**

Let \\( C \\) be a simple closed contour within and on which a function \\( f(z) \\) is analytic except for a finite number of isolated singularities \\( z_1, \ldots, z_m  \\). Then

{{< katex display >}}
\oint_C f(z) \dd z = 2 \pi i \sum_{n=1} ^m \text{Res}[z_n]
{{< /katex >}}

where \\( \text{Res}[z_n] \\) is the residue of \\( f(z) \\) at \\( z_n \\).

{{% /hint %}}

To make use of this very powerful result to perform contour integrals, the name of the game is completing a contour that properly encloses all singularities while remaining analytic. This is the approach we will take to find residues.

If a function \\( f(z) \\) can be expanded in a Laurent series about \\( z_0 \\)

{{< katex display >}}
f(z) = \sum_{n=-\infty} ^\infty a_n (z - z_0)^n
{{< /katex >}}

then the residue at \\( z_0 \\) is just the coefficient \\( a_{-1} \\). But suppose we don't have a Laurent series expansion for \\( f(z) \\) at \\( z_0 \\)? Constucting the series isn't the only way to find the residue. If we consider \\( (z - z_0)f(z) \\):

{{< katex display >}}
(z - z_0) f(z) = \ldots + a_{-1} + a_0(z - z_0) + a_1(z - z_0)^2 + \ldots
{{< /katex >}}

If \\( z_0 \\) is a simple pole (of order 1), then we can take the limit

{{< katex display >}}
\lim_{z \rightarrow z_0} (z - z_0) f(z) = \lim_{z \rightarrow z_0} a_{-1} + a_0(z - z_0) + a_1(z - z_0)^2 + \ldots = a_{-1}
{{< /katex >}}

What if \\( z_0 \\) is a double pole?

{{< katex display >}}
f(z) = a_{-2} (z - z_0)^{-2} + a_{-1} (z - z_0) + a_0 + a_1(z - z_0) + \ldots
{{< /katex >}}

In that case we can multiply by \\( (z - z_0)^2 \\) and differentiate to pick out the residue

{{< katex display >}}
\lim_{z \rightarrow z_0} \left( \pdv{}{z} \left( (z - z_0)^2 f(z) \right) \right) = a_{-1}
{{< /katex >}}

So, the general recipe is: If \\( f(z) \\) has an \\( m^{th} \\) order pole at \\( z_0 \\), then

{{< katex display >}}
\text{Res}[z_0] = \lim_{z \rightarrow z_0} \left[ \frac{1}{(m - 1)!} \pdv{^m}{z^m} \left((z - z_0)^m f(z) \right) \right]
{{< /katex >}}

In the case of an essential singularity with infinite order, we have no choice but to find the Laurent series expansion and pick out the \\( a_{-1} \\) term directly. No differentiation tricks will help us there.

# Real Integrals

In real life, we often want to evaluate real integrals, which is to say we want to integrate a real-valued, single-valued function along the real axis. Numerically, this is pretty straightforward to do using a Riemann sum, although it can become difficult if the function goes to zero very slowly.

We can turn a real integral into a complex contour integral by appropriately choosing a contour in the complex plane such that one segment of the contour corresponds directly with the real integral, and the remaining segment can be evaluated (usually as 0) leaving us with a closed contour integral.

Suppose we want to evaluate

{{< katex display >}}
\int _{-\infty} ^\infty f(x) \dd x
{{< /katex >}}

We can turn this into a contour integral over the upper half plane (or lower half plane) and taking the limit as \\( R \rightarrow \infty \\):

<p align="center"> <img alt="cauchy-contour-integral-1.png" src="/r/img/aa567/cauchy-contour-integral-1.png" /> </p>

{{< katex display >}}
\oint_C f(z) \dd z =  \int _{-\infty} ^\infty f(x) \dd x + \int _{C_R} f(z) \dd z
{{< /katex >}}

where \\( C_R \\) is a large semicircle and the contour encloses all singularities of \\( f(z) \\). Along \\( C_R \\),

{{< katex display >}}
z = R e^{i \theta} \qquad 0 \leq \theta < \pi
{{< /katex >}}

{{< katex display >}}
\int _{C_R} f(z) \dd z = \int _0 ^\pi f(R e^{i \theta}) R i e^{i \theta} \dd \theta
{{< /katex >}}

If we can show that \\( |z f(z)| \rightarrow 0 \\) as \\( |z| \rightarrow \infty \\), then the \\( C_R \\) contribution goes to zero. We can use Cauchy's residue theorem to evaluate the closed contour integral:

{{< katex display >}}
\int _{-\infty} ^\infty f(x) \dd x = 2 \pi i \sum \text{Residues in upper half plane}
{{< /katex >}}

We could also choose the lower half-plane, as long as we remember to keep the minus sign as \\( \theta \\) would be going clockwise there.

**Example**

{{< katex display >}}
\int _0 ^\infty \frac{1}{1 + x^N} \dd x = \frac{\pi / N}{\sin ( \pi / N)}
{{< /katex >}}

For any positive integer \\( N \\). First, we want to extend this to cover the whole real axis so that we can close the contour. Since the integrand is even,

{{< katex display >}}
\int _0 ^\infty \frac{1}{1 + x^N} \dd x = \frac{1}{2} \int _{-\infty} ^\infty \frac{1}{1 + x^N} \dd x
{{< /katex >}}

Then, we need to check that the contribution from the \\( C_R \\) contour will be zero

{{< katex display >}}
\lim_{z \rightarrow \infty} \left| z \frac{1}{1 + z^N} \right| = \lim_{z \rightarrow \infty} |z| \left| \frac{1}{1 + z^N} \right|
{{< /katex >}}

We can bring out the reverse triangle inequality here:

{{< katex display >}}
|z^N + 1 | \geq |z^N| - |1|
{{< /katex >}}

{{< katex display >}}
\left| z \frac{1}{1 + z^N} \right| \leq \frac{|z|}{|z|^N - 1} = \frac{1}{|z|^{N-1} - \frac{1}{|z|}}
{{< /katex >}}
{{< katex display >}}
\lim_{z \rightarrow \infty} \frac{1}{|z|^{N-1} - \frac{1}{|z|}} = 0
{{< /katex >}}

Okay, at this point we can proceed to find the residues:

{{< katex display >}}
I = \int _{-\infty} ^\infty f(x) \dd x + \int_{C_R} f(z) \dd z = \oint _{\text{UHP}} f(z) \dd z
{{< /katex >}}

At this point we can quote the residue theorem to say

{{< katex display >}}
I = 2 \pi i \sum \text{Res}[z_i] \quad \text{ for pole }z_i \text{ in upper half plane}
{{< /katex >}}

The simple poles of our \\( f(z) \\) occur where \\( 1 + z^N = 0 \\)

{{< katex display >}}
z^N = -1 = e^{i (\pi + 2 \pi k)}
{{< /katex >}}
{{< katex display >}}
z = e^{i \frac{\pi + 2 \pi k}{N}} \quad k = 0, 1, \ldots, \frac{N}{2} - 1
{{< /katex >}}

{{< katex display >}}
I = 2 \pi i \sum_{k=0} ^{N/2 - 1} \text{Res} \left[ \frac{1}{1 + z^N}, z_k \right]
{{< /katex >}}

We can use the differentiation trick above to find the residues of the simple poles:

{{< katex display >}}
\text{Res}[z_k] = \left.\frac{1}{ \dv{}{z} (1 + z^N)} \right|_{z_k} = \frac{1}{N z_k ^{N-1}}
{{< /katex >}}

{{< katex display >}}
I = \frac{\pi i}{N} \sum_{k=0} ^{N/2 - 1} \frac{1}{z_k ^{N-1}} \\
= \frac{\pi i}{N} e^{- \pi i (N-1)/N} \sum_{k=0} ^{N/2 - 1} e^{+ 2 k \pi i / N} \\
= \frac{\pi}{N} \left[ -i e^{i \pi / N} \right] \frac{1 - e^{\frac{2 \pi i}{N} (N/2)}}{1 - e^{2 \pi i / N}}\\
= \frac{\pi}{N} \frac{1}{\sin(\pi / N)}
{{< /katex >}}

For another example, consider an integral of some trigonometric function over a full period:

{{< katex display >}}
I = \int_0 ^{2 \pi} U(\sin \theta, \cos \theta) \dd \theta
{{< /katex >}}

where \\( U \\) is some annoying-to-integrate function like \\( \sin ^2 \theta / (a + \cos \theta) \\). We can turn it into a closed contour integral over the unit circle where

{{< katex display >}}
z = e ^{i \theta} \qquad 0 \leq \theta < 2 \pi
{{< /katex >}}
{{< katex display >}}
\dd z = i e^{i \theta} \dd \theta = i z \dd \theta \rightarrow \dd \theta = \frac{\dd z}{i z}
{{< /katex >}}

{{< katex display >}}
I = \int_0 ^{2 \pi} U(\sin \theta, \cos \theta) \dd \theta = \oint_{R = 1} \frac{U}{iz} \dd z \\
= 2 \pi i \sum \text{Res}\left[ \frac{U}{iz} \text{ inside unit circle} \right]
{{< /katex >}}

From there, we can re-parameterize \\( U \\) using

{{< katex display >}}
\cos \theta = \frac{1}{2} (e ^{i \theta} + e^{-i \theta}) = \frac{1}{2} (z + \frac{1}{z} )
{{< /katex >}}
{{< katex display >}}
\sin \theta = \frac{1}{2i} (e^{i \theta} - e^{-i \theta}) = \frac{1}{2i} (z - \frac{1}{z})
{{< /katex >}}

For example, if we have

{{< katex display >}}
U = \frac{1}{2 + \sin \theta}
{{< /katex >}}

then the integral becomes

{{< katex display >}}
I = \int_0 ^{2 \pi} \frac{\dd \theta}{2 + \sin \theta} \\
= \oint _C \frac{ \dd z / iz}{2 + \frac{1}{2i} (z - \frac{1}{z})} \\
= \oint_C \frac{2 \dd z}{z^2 + 4iz - 1}
{{< /katex >}}

The simple poles of the integrand are where \\( z^2 + 4iz - 1 = 0 \\), and these are found at

{{< katex display >}}
z_1 = (-2 + \sqrt{3})i\\
z_2 = (-2 - \sqrt{3})i
{{< /katex >}}

Of those, only \\( z_1 \\) is found within the unit circle, so

{{< katex display >}}
I = 2 \pi i \text{Res}[z_1]
{{< /katex >}}

To find the residue, re-express the integrand using the roots:

{{< katex display >}}
\frac{2 }{z^2 + 4iz - 1} = \frac{2}{(z - z_1)(z - z_2)}
{{< /katex >}}

and then multiply by \\( (z - z_1) \\):

{{< katex display >}}
\text{Res}[z_1] = \lim_{z \rightarrow z_1} \frac{(z - z_1) 2}{(z - z_1)(z - z_2)} \\
= \frac{2}{z_1 - z_2} = \frac{1}{i\sqrt{3}}
{{< /katex >}}
{{< katex display >}}
I = 2 \pi i \left( \frac{1}{i\sqrt{3}} \right) = \frac{2 \pi}{\sqrt{3}}
{{< /katex >}}
