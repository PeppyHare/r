---
title: Real Integrals
weight: 60
---

{{< katex display >}}

{{< /katex >}}


# Real Integrals

In real life, we often want to evaluate real integrals, which is to say we want to integrate a real-valued, single-valued function along the real axis. Numerically, this is pretty straightforward to do using a Riemann sum, although it can become difficult if the function goes to zero very slowly.

We can turn a real integral into a complex contour integral by appropriately choosing a contour in the complex plane such that one segment of the contour corresponds directly with the real integral, and the remaining segment can be evaluated (usually as 0) leaving us with a closed contour integral.

Suppose we want to evaluate

{{< katex display >}}
\int _{-\infty} ^\infty f(x) \dd x
{{< /katex >}}

We can turn this into a contour integral over the upper half plane (or lower half plane) and taking the limit as \\( R \rightarrow \infty \\):

<p align="center"> <img alt="cauchy-contour-integral-1.png" src="/r/img/aa567/cauchy-contour-integral-1.png" width=400px/> </p>

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

**Example: Improper integral of an odd rational function**

Evaluate

{{< katex display >}}
I = \int_{0} ^\infty \frac{\dd x}{x^3 + a^3} \qquad a > 0
{{< /katex >}}

Because we have an integral on \\( 0, \infty \\), we can't immediately close the contour using \\( C_R \\) as shown above. We also can't expand the integral to the whole real axis because \\( f(x) \\) is not an even function.

However, there is a useful symmetry we can apply here: \\( (x e^{2 \pi i / 3})^3 = x^3 \\). This suggests using the following contour, where \\( C_R \\) is the sector \\( R e^{i \theta} : 0 \leq \theta \leq 2 \pi / 3 \\):

<p align="center"> <img alt="contour-ex427.png" src="/r/img/aa567/contour-ex427.png" width=400px/> </p>

We therefore have:

{{< katex display >}}
\oint_C \frac{\dd z}{z^3 + a^3} = \left( \int _{C_L} + \int_{C_x} + \int _{C_R} \right) \frac{\dd z}{z^3 + z^3} \\
 = 2 \pi i \sum_j \text{Res} \left( \frac{1}{z^3 + z^3}; z_j \right)
{{< /katex >}}

The only pole inside \\( C \\) satisfies \\( z^3 = - a^3 = a^3 e^{i \pi} \\) and is given by \\( z_1 = ae^{i \pi / 3} \\).

The residue is obtained from

{{< katex display >}}
\text{Res} \left( \frac{1}{z^3 + z^3} ; z_1 \right) = \left( \frac{1}{3 z^3} \right)_{z_1} = \frac{1}{3 a^2 e^{2 \pi i / 3}} = \frac{1}{3 a^2} e^{- 2 \pi i / 3}
{{< /katex >}}

The integral on \\( C_L \\) is evaluated by making the substitution \\( z = e^{2 \pi i / 3} r \\) (where the orientation is taken into account)

{{< katex display >}}
\int _{C_L } \frac{ \dd z}{z^3 + a^3} = \int_{r = R} ^0 \frac{e^{2 \pi i / 3}}{r^3 + a^3} \dd r = - e ^{2 \pi i / 3} I
{{< /katex >}}

Thus taking into account the contributions from \\( C_x  \\) (\\( 0 \leq z = x \leq R \\) ) and from \\( C_L \\), we have

{{< katex display >}}
I (1 - e^{2 \pi i / 3}) = \lim_{R \rightarrow \infty} \int_0 ^R \frac{ \dd r}{r^3 + a^3} (1 - e^{2 \pi i / 3}) = \frac{2 \pi i}{3a^2} e^{- 2 \pi i / 3}
{{< /katex >}}

Thus

{{< katex display >}}
I = \frac{2 \pi i}{3 a^2} \frac{3^{-2 \pi i / 3}}{1 - e^{2 \pi i / 3}} = \frac{\pi}{3 a^2} \left( \frac{2i}{e^{-i \pi / 3} - e^{i \pi / 3}} \right)e^{-i \pi} \\
= \frac{\pi}{3 a^2 \sin(\pi / 3)} = \frac{2 \pi}{3 \sqrt{3} a^2}
{{< /katex >}}

### Trigonometric Integrals over a Period

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


It is sometimes convenient, when analyzing the behavior of a function near infinity, to make the change of variables \\( z = 1/t \\). Using \\( dz = - \frac{1}{t^2} dt \\) and noting that the clockwise (positive direction) of \\( C_R: z = R e^{i \theta} \\) transforms to a clockwise rotation (negative direction) in \\( t \\): \\( t = 1/z = (1/R)e^{-i \theta} = \epsilon e^{-i \theta} \\) we have

{{< katex display >}}
\text{Res}(f(z); \infty) = \frac{1}{2 \pi i} \oint_{C_{\infty}} f(z) \dd z = \frac{1}{2 \pi i} \oint_{C_{\epsilon}} \left( \frac{1}{t^2} \right) f \left( \frac{1}{t} \right) \dd t
{{< /katex >}}

where \\( C_{\epsilon} \\) is the limit as \\( \epsilon \rightarrow 0 \\) of a small circle around the origin in the \\( t \\) plane. So the residue at \\( \infty \\) is given by

{{< katex display >}}
\text{Res}(f(z); \infty) = \text{Res} \left[ \frac{1}{t^2} f(\frac{1}{t}); 0\right]
{{< /katex >}}

that is, the right-hand side is the coefficient of \\( t^{-1} \\) in the expansion of \\( f(1/t)/t^2 \\) near \\( t = 0 \\); the left-hand side is the coefficient of \\( z^{-1} \\) in the expansion of \\( f(z) \\) at \\( z = \infty \\) . Sometimes we write

{{< katex display >}}
\text{Res}(f(z); \infty) = \lim_{z \rightarrow \infty}(z f(z)) \quad \text{when} \quad f(\infty) = 0
{{< /katex >}}

The concept of residue at infinity is quite useful when we integrate rational functions. Rational functions have only isolated singular points in the extended plane and are analytic elsewhere. Let \\( z_1, z_2, \ldots, z_N \\) denote the finite singularities. Then, for every rational function,

{{< katex display >}}
\sum_{j=1}^N \text{Res}(f(z); z_j) = \text{Res}(f(z); \infty)
{{< /katex >}}


{{% hint info %}}
{{< katex display >}}
{{< /katex >}}
**Theorem**

Let \\( f(z) = N(z) / D(z) \\) be a rational function such that the degree of \\( D(z) \\) exceeds the degree of \\( N(z) \\) by at least two. Then

{{< katex display >}}
\lim_{R \rightarrow \infty} \int_{C_R} f(z) \dd z = 0
{{< /katex >}}

We write

{{< katex display >}}
f(z) = \frac{a_n z^n + a_{n-1} z^{n-1} + \ldots + a_1 z + a_0}{b_m z^m + b_{m-1} z^{m-1} + \ldots + b_1 z + b_0}
{{< /katex >}}

Then, by repeated application of the triangle inequality,

{{< katex display >}}
\left| \int_{C_R} f(z) \dd z \right| \leq \int _0 ^\pi (R \dd \theta) \frac{ |a_n| |z|^n + |a_{n-1} | |z| ^{n-1} + \ldots + |a_1| |z| + |a_0|}{|b_m||z|^m - |b_{m-1}| |z| ^{m-1} - \ldots - |b_1| |z| - |b_0|} \\
= \frac{\pi R(|a_n| R^n + \ldots + |a_0|)}{|b_m| R^m - |b_{m-1}| R^{m-1} - \ldots - |b_0|} \rightarrow _{R \rightarrow \infty} 0
{{< /katex >}}

since \\( m \geq n + 2 \\)

{{% /hint %}}

Some integrals that are closely related to the one described above are of the form

{{< katex display >}}
I_1 = \int _{-\infty} ^{\infty} f(x) \cos (kx) \dd x
{{< /katex >}}
{{< katex display >}}
I_2 = \int _{-\infty} ^{\infty} f(x) \sin (kx) \dd x
{{< /katex >}}
{{< katex display >}}
I_{3 \pm} = \int_{-\infty} ^{\infty} f(x) e^{\pm ikx} \dd x \qquad (k > 0)
{{< /katex >}}

where \\( f(x) \\) is a rational function satisfying the conditions of the theorem above. These integrals are evaluated by a method similar to the ones described earlier. When evaluating integrals such as \\( I_1 \\) or \\( I_2 \\), we first replace them by integrals of the form \\( I_3 \\). We evaluate, say  \\( I_{3+} \\) by using the contour \\( C_R \\) above. Again, we need to evaluate the integral along the upper semicircle. Because \\( e^{ikz} = e^{ikx} e^{-ky} \\), we have \\( |e^{ikz}| \leq 1 \\) (where \\( y > 0 \\) ) and

{{< katex display >}}
\left| \int_{C_R} f(z) e^{ikz} \dd z \right| \leq \int _{0} ^\pi |f(z)| | \dd z| \rightarrow _{R \rightarrow \infty} 0
{{< /katex >}}

from the results of the theorem. Thus using

{{< katex display >}}
I_{3+} = \int_{-\infty} ^{\infty} f(x) e^{ikx} \dd x \\
= \int_{-\infty}^{\infty}f(x) \cos kx \dd x + i \int_{-\infty}^{\infty}f(x) \sin kx \dd x
{{< /katex >}}

By taking the real and imaginary parts, we can compute \\( I_1 \\) and \\( I_2 \\)

{{< katex display >}}
I_{3+} = I_1 + i I_2 = 2 \pi i \sum_{j=1}^N \text{Res} (f(z) e^{ikz}; z_j)
{{< /katex >}}

**Example**

Evaluate

{{< katex display >}}
I = \int_{-\infty} ^\infty \frac{\cos kx}{(x + b)^2 + a^2} \dd x \qquad k > 0, a > 0, b \in \Reals
{{< /katex >}}

We consider

{{< katex display >}}
I_+ = \int_{-\infty} ^\infty \frac{e^{ikx}}{(x + b)^2 + a^2} \dd x
{{< /katex >}}

and use the contour \\( C_R \\) shown above to find

{{< katex display >}}
I_+ = 2 \pi i \text{Res} \left( \frac{e^{ikz}}{(z + b)^2 + a^2}; z_0 = ia - b \right) \\
= 2 \pi i \left( \frac{e^{ikz}}{2 (z+b)} \right) _{z_0 = ia -b } = \frac{\pi}{a} e^{-ka} e^{-ibk}
{{< /katex >}}

From

{{< katex display >}}
I_+ = \int_{-\infty} ^\infty \frac{\cos kx}{(x + b)^2 + a^2} \dd x + i \int_{-\infty} ^{\infty} \frac{\sin kx}{(x + b)^2 + a^2} \dd x
{{< /katex >}}

we have

{{< katex display >}}
I = \frac{\pi}{a} e^{-ka} \cos bk
{{< /katex >}}

and

{{< katex display >}}
J = \int_{-\infty} ^\infty \frac{\sin kx}{(x + b)^2 + a^2} \dd x = \frac{-\pi}{a} e^{-ka} \sin bk
{{< /katex >}}

If \\( b = 0 \\) the latter formula reduces to \\( J = 0 \\), which also follows directly from the fact that the integrand is odd. The reader can verify that

{{< katex display >}}
\left| \int_{C_R} \frac{e^{ikz}}{(z + b)^2 + a^2} \dd z \right| \leq \int_{C_R} \frac{|\dd z|}{|z|^2 - 2 |b| |z| - a^2 - b^2} \\
= \frac{\pi R}{R^2 - 2bR - (a^2 + b^2)} \rightarrow _{R \rightarrow \infty} 0
{{< /katex >}}

In applications we frequently wish to evaluate integrals like \\( I_{3\pm} \\) involving \\( f(x) \\) for which all that is known is \\( f(x) \rightarrow 0 \\) as \\( |x| \rightarrow \infty \\). From calculus we know that in these cases the integral still converges, conditionally, but our estimates leading to

{{< katex display >}}
I_{3+} = I_1 + i I_2 = 2 \pi i \sum_{j=1}^N \text{Res} (f(z) e^{ikz}; z_j)
{{< /katex >}}

must be made more carefully. We say that \\( f(z) \rightarrow 0 \\) **uniformly** as \\( R \rightarrow \infty \\) in \\( C_R \\) if \\( |f(z)| \leq K_R \\), where \\( K_R \\) depends only on \\( R \\) (not on \\( \text{arg}(z) \\) ) and \\( K_R \rightarrow 0 \\) as \\( R \rightarrow \infty \\). We have the following lemma, called Jordan's Lemma

### Jordan's Lemma

{{% hint info %}}
{{< katex display >}}
{{< /katex >}}
**Jordan's Lemma**

Suppose that on the circular arc \\( C_R \\) shown above, we have \\( f(z) \rightarrow 0 \\) uniforly as \\( R \rightarrow \infty \\). Then

{{< katex display >}}
\lim_{R \rightarrow \infty} \int_{C_R} e^{ikz} f(z) \dd z = 0 \qquad (k > 0)
{{< /katex >}}

With \\( |f(z)| \leq K_R \\) where \\( K_R \\) is independent of \\( \theta \\) and \\( K_R \rightarrow 0 \\) as \\( R \rightarrow \infty \\),

{{< katex display >}}
I = \left| \int_{C_R} e^{ikz} f(z) \dd z \right| \leq \int_{0} ^\pi e^{-ky} K_R R \dd \theta
{{< /katex >}}

using \\( y = R \sin \theta \\) and \\( \sin(\pi - \theta) = \sin \theta \\)

{{< katex display >}}
\int_0 ^\pi e^{-ky} \dd \theta = \int_{0}^\pi e^{-kR \sin \theta} \dd \theta = 2 \int_0 ^{\pi / 2} e^{-k R \sin \theta} \dd \theta
{{< /katex >}}

But in the region \\( 0 \leq \theta \leq \pi / 2 \\) we also have the estimate \\( \sin \theta \geq 2 \theta / \pi \\)

<p align="center"> <img alt="jordan-lemma-1.png" src="/r/img/aa567/jordan-lemma-1.png" /> </p>

Thus

{{< katex display >}}
I \leq 2 K_R R \int_0 ^{\pi / 2} e ^{-2 k R \theta / \pi} \dd \theta = \frac{2 K_R R \pi}{2kR} (1 - e^{-kR})
{{< /katex >}}

and \\( I \rightarrow 0 \\) as \\( R \rightarrow \infty \\) because \\( K_R \rightarrow 0 \\)

We note that if \\( k < 0 \\), a similar result holds for the contour in the lower half plane. Moreover, by simply rotating the contour, Jordan's lemma applies to the cases \\( k = il, l \neq 0 \\). Consequently, the result \\( I_{3+} = I_1 + i I_2 = 2 \pi i \sum_{j=1}^N \text{Res} (f(z) e^{ikz}; z_j) \\) follows whenever Jordan's lemma applies.

{{% /hint %}}

Let's see this in action in an example:

**Example**

Evaluate

{{< katex display >}}
I = 2 \int_{-\infty}^{\infty}\frac{x \sin \alpha x \cos \beta x}{x^2 + \gamma^2} \dd x \qquad \gamma > 0, \beta \in \Reals
{{< /katex >}}

The trigonometric formula

{{< katex display >}}
\sin \alpha x \cos \beta x = \frac{1}{2} \left[ \sin(\alpha - \beta)x + \sin(\alpha + \beta)x \right]
{{< /katex >}}

motivates the introduction of the integrals

{{< katex display >}}
J = \int_{-\infty}^{\infty}\frac{x e^{i (\alpha - \beta)x}}{x^2 + \gamma ^2} \dd x + \int_{-\infty}^{\infty}\frac{x e^{i (\alpha + \beta)x}}{x^2 + \gamma ^2} \dd x + = J_1 + J_2
{{< /katex >}}

Jordan's lemma applies because the function \\( f(z) = z / (z^2 + \gamma ^2) \rightarrow 0 \\) uniformly as \\( z \rightarrow \infty \\), and we note that

{{< katex display >}}
|f| \leq \frac{R}{R^2 - \gamma^2} \equiv K_R
{{< /katex >}}

We note that the denominator is only one degree higher than the numerator. If \\( \alpha - \beta > 0 \\) then we close our contour in the upper half plane and the only residue is \\( z = i \gamma (\gamma > 0) \\), hence

{{< katex display >}}
J_1 = i \pi e^{-(\alpha - \beta)\gamma}
{{< /katex >}}

On the other hand, if \\( \alpha - \beta < 0 \\) we close in the lower half plane and find

{{< katex display >}}
J_1 = - i \pi e^{(\alpha - \beta) \gamma}
{{< /katex >}}

Combining the results

{{< katex display >}}
J_1 = i \pi \text{sgn}(\alpha - \beta)e^{-|\alpha - \beta | \gamma}
{{< /katex >}}

Similarly, for \\( I_2 \\) we find

{{< katex display >}}
J_2 = i \pi \text{sgn}(\alpha + \beta) e^{- |\alpha + \beta| \gamma}
{{< /katex >}}

Thus

{{< katex display >}}
J = i \pi \left[ \text{sgn}(\alpha - \beta) e^{- |\alpha - \beta| \gamma} + \text{sgn} (\alpha + \beta) e^{- |\alpha + \beta | \gamma} \right]
{{< /katex >}}

and, by taking the imaginary part,

{{< katex display >}}
I = i \pi \left[ \text{sgn}(\alpha - \beta) e^{- |\alpha - \beta| \gamma} + \text{sgn} (\alpha + \beta) e^{- |\alpha + \beta | \gamma} \right]
{{< /katex >}}

If we take \\( \text{sgn}(0) = 0 \\) then the case \\( \alpha = \beta \\) is incorporated in the result.

For another example using Jordan's lemma:

**Example**

{{< katex display >}}
I = \int _0 ^\infty \frac{x \sin (mx)}{a^2 + x^2} \dd x \qquad a > 0, m > 0
{{< /katex >}}

Let's turn this into the form of \\( I_{3+} \\) above

{{< katex display >}}
= \frac{1}{2} \int_{-\infty}^{\infty} \frac{x \sin (mx)}{a^2 + x^2} \dd x = \frac{1}{2} \text{Im} \int_{-\infty}^{\infty}\frac{z e^{imz} \dd z}{a^2 + z^2}
{{< /katex >}}

Here our \\( f(z) \\) that we want to converge uniformly is

{{< katex display >}}
f(z) = \frac{z}{a^2 + z^2}
{{< /katex >}}

{{< katex display >}}
|f(z) | \leq \left| \frac{R}{a^2 - R^2} \right| \rightarrow 0
{{< /katex >}}

Note that this is a weaker convergence than \\( |z f(z)| \cancel{\rightarrow} 0 \\), so we can't just disregard the \\( C_R \\) contour. But we can use Jordan's lemma:

{{< katex display >}}
I = \frac{1}{2} \text{Im} \oint _{UHP} \frac{z}{a^2 + z^2} e^{imz} \dd z \\
= \frac{1}{2} \text{Im} \left[ 2 \pi i \text{Res} \left( \frac{z e^{imz}}{a^2 + z^2} ; z = ia \right) \right] \\
= \frac{1}{2} \text{Im} \left[ 2 \pi i \frac{ ai e^{-ma}}{2ai} \right] = \frac{\pi}{2} e^{-ma}
{{< /katex >}}


## Improper Integrals (Principal value)

If \\( f(z) \\) has a simple pole at \\( z = z_0 \\), \\( \int_C f(z) \dd z \\) is an improper integral if \\( C \\) passes through \\( z_0 \\). The **principal value** of an improper integral is the limit

{{< katex display >}}
P \int_a ^b f(z) \dd z = \lim_{\epsilon \rightarrow 0} \left[ \int_a ^{z_0 - \epsilon} f(z) \dd z + \int_{z_0 + \epsilon} ^b f(z) \dd z \right]
{{< /katex >}}

Such a limit does not exist if \\( f(z) \\) has a singularity more severe than a single pole on the path of integration. When writing the notation for a principal value, we may use \\( P \int \\), \\( \sout{\int} \\), or \\( \text{P.V.} \int \\). We'll use \\( P \int \\) everywhere here.

Suppose we want to perform a contour integration over \\( C \\), where there is a singularity along the path. Here we **should** refuse to do the problem because the answer depends on how you do it. But if we put a \\( P \\) out in front and \\( z_0 \\) is a simple pole, then the integral becomes well-defined. So how do we go about cutting \\( z_0 \\) out of \\( C \\)?


<p align="center"> <img alt="principal-value-with-indent.png" src="/r/img/aa567/principal-value-with-indent.png" width=400px /> </p>

We add an indent around \\( z_0 \\) then subtract whatever that would have contributed to the integral. So what does the bump contribute?

{{< katex display >}}
z = z_0 + \epsilon e^{i \theta}
{{< /katex >}}

{{< katex display >}}
\int_{\text{(bump)}} f(z) \dd z = - \int_{\theta_0} ^{\theta_0 + \pi} f(z + \epsilon e^{i \theta}) i \epsilon e^{i \theta} \dd \theta
{{< /katex >}}

where \\( \theta_0 \\) is whatever angle \\( f(z) \\) makes with the horizontal at \\( z_0 \\). If \\( z_0 \\) is a simple pole, then we have a series expansion of \\( f(z) \\)

{{< katex display >}}
f(z) = \frac{a_{-1}}{(z - z_0)} + \sum_{n = 0} ^\infty a_n (z - z_0)^n
{{< /katex >}}

{{< katex display >}}
f(z_0 + \epsilon e^{i \theta}) = \frac{a_{-1}}{\epsilon e^{i \theta}} + \ldots
{{< /katex >}}

{{< katex display >}}
f(z_0 + \epsilon e^{i \theta}) i \epsilon e^{i \theta} = i a_{-1} + i \sum_{n=0} ^\infty a_n (\epsilon e^{i \theta})^n
{{< /katex >}}
{{< katex display >}}
\rightarrow _{\epsilon \rightarrow 0} i a_{-1}
{{< /katex >}}

{{< katex display >}}
- \int_{\theta_0} ^{\theta_0 + \pi} f(z + \epsilon e^{i \theta}) i \epsilon e^{i \theta} \dd \theta = \pi i a_{-1}
{{< /katex >}}

So the principal value is equal to the indented contour integral, plus half the residue of the singularity along the path.

With this, we can write down a modified residue theorem for the principle value integral:

{{% hint info %}}
{{< katex display >}}
{{< /katex >}}
**Modified Residue Theorem**

If \\( f(z) \\) has poles inside and on \\( C \\), then

{{< katex display >}}
P \oint_C f(z) \dd z = 2 \pi i \sum \text{Res}(f(z); z_0 \text{ inside } C) + \pi i \sum \text{Res}(f(z); z_0 \text{ on } C)
{{< /katex >}}

{{% /hint %}}

This is only possible if the poles on \\( C \\) are simple poles, otherwise the bump contour integral goes to infinity.

These improper integrals also come up in inverse Laplace transforms, but generally they appear there if we have missed some physical constraint such as causality (e.g. the function you're transforming is assumed to be 0 for all time before \\( t = 0 \\), in order for the transform to be valid).) Improper integrals can also appear in physics PDEs if we ignore viscosity. But we'll find if we put even a little bit of viscosity back in, the singularity moves just off the contour and we see that everything is actually fine.

**Example**

{{< katex display >}}
I = \int_{-\infty}^{\infty} \frac{\sin(tx)}{x} \dd x
{{< /katex >}}

Here, this is a proper integral (\\( \lim_{x \rightarrow 0} f(x) = t \\) ). But we want to use Jordan's lemma to calculate the integral, closing it in the upper half plane. But we can't close it because \\( \sin(tx) \\) blows up along the imaginary axis.

Since the original integral is proper, the principal value is the same as the regular value

{{< katex display >}}
I = PI = P \int_{-\infty}^{\infty}\frac{\sin(tx)}{x} \dd x = P \text{Im} \int_{-\infty}^{\infty}\frac{e^{itx}}{x} \dd x
{{< /katex >}}

There is a wrong way to do this:

{{< katex display >}}
I = \int_{-\infty}^{\infty}\frac{ \sin(tx)}{x} \dd x \neq \text{Im} \int_{-\infty}^{\infty}\frac{e^{itx}}{x} \dd x
{{< /katex >}}

Because the real component of \\( e^{itx}/x \\) has a singularity at \\( x = 0 \\). The real part is what turns it into an improper integral!

Instead, we start with the principal value:

{{< katex display >}}
P \int_{-\infty}^{\infty}\frac{\sin (tx)}{x} \dd x = P \text{Im} \int_{-\infty}^{\infty}\frac{e^{itx}}{x} \dd x = \text{Im} P \int_{-\infty}^{\infty}\frac{e^{itx}}{x} \dd x
{{< /katex >}}

Here we've introduced an improper integral \\( \int_{-\infty}^{\infty}\frac{\cos(tx)}{x} \dd x \\)

{{< katex display >}}
J = P \int_{-\infty}^{\infty} \frac{e^{itz}}{z} \dd z
{{< /katex >}}

Now we can go back to using Jordan's lemma to compute the result. Since \\( |\frac{1}{z}| \rightarrow 0 \\) as \\( z \rightarrow \infty \\), we can close the contour. We close it in the upper half plane if \\( t > 0 \\), or in the lower half plane if  \\( t < 0 \\).

{{< katex display >}}
J = P \int _{UHP} \frac{e^{itz}}{z} \dd z
{{< /katex >}}

We use the modified residue theorem for this one. There are no singularities inside the contour, and the residue at \\( z_0 = 0 \\) is 1, so

{{< katex display >}}
J = \pi i
{{< /katex >}}

{{< katex display >}}
I = \text{Im}(J) = \pi
{{< /katex >}}

For \\( t < 0 \\) the contour goes clockwise, so we add a negative sign

{{< katex display >}}
J = - \pi i \qquad t < 0
{{< /katex >}}

This gives us a pretty good step function:

{{< katex display >}}
\frac{I}{\pi} = \begin{cases} 1 & t > 0 \\ -1 & t < 0 \end{cases}
{{< /katex >}}

What about \\( t = 0 \\)?

{{< katex display >}}
J = P \int_{-\infty}^{\infty} \frac{1}{x} \dd x \\
= \int _{-R} ^{- \epsilon} \frac{\dd x}{x} + \int _{\epsilon} ^{R} \frac{\dd x}{x} \\
\lim_{R \rightarrow \infty} \lim_{\epsilon \rightarrow 0} = \ln x |_{-R} ^{-\epsilon} + \ln x |_{\epsilon} ^{R} \\
= \ln \left( \frac{-\epsilon}{-R} \right) + \ln \left( \frac{R}{\epsilon} \right) \\
= \ln (1) = 0
{{< /katex >}}

Another example:

{{< katex display >}}
I = \int_{-\infty}^{\infty}\frac{\cos(ax) - \cos(bx)}{x^2} \dd x \qquad a > 0, b > 0
{{< /katex >}}

Note the series expansion of cosine

{{< katex display >}}
\cos(ax) = 1 - \frac{(ax)^2}{2!} + \ldots
{{< /katex >}}
{{< katex display >}}
\cos(bx) = 1 - \frac{(bx)^2}{2!} + \ldots
{{< /katex >}}

So the leading terms cancel and this is actually a proper integral

{{< katex display >}}
PI = I
{{< /katex >}}

{{< katex display >}}
I = P \int_{-\infty}^{\infty} () = \text{Re} P \int_{-\infty}^{\infty}\frac{e^{iax} - e^{ibx}}{x^2} \dd x
{{< /katex >}}

{{< katex display >}}
J = P \int_{-\infty}^{\infty}\frac{e^{iax} - e^{ibx}}{x^2} \dd x
{{< /katex >}}

Use residue theorem, to get the residue multiply by \\( x \\) and take the limit as \\( x \rightarrow 0 \\)

{{< katex display >}}
J = \pi i \text{Res}(z = 0) = \pi (b - a) = I
{{< /katex >}}
