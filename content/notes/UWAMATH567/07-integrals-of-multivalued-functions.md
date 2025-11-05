---
title: Integrals of Multivalued Functions
weight: 70
---

{{< katex display >}}

{{< /katex >}}

Now we're getting to the good stuff that would usually be skipped in undergraduate courses!

Consider the example

{{< katex display >}}
I = \int _{0} ^{\infty} \frac{x^{\alpha - 1}}{x + 1} \dd x \qquad 0 < \alpha < 1
{{< /katex >}}

Previously, we've said we should refuse to compute the integral of a multi-valued function. But for a real value this integral is legit and well-defined.

First, observe that the integrand is a single-valued function. Numerically, you can just take the area under the curve and work out the result. But in the complex plane, we don't know how to do it. The complex function

{{< katex display >}}
f(z) = \frac{z^{\alpha - 1}}{z + 1}
{{< /katex >}}

is a multi-valued function. Now, the multi-valuedness that's been introduced is our own fault, so we need to deal with it by defining a single-valued integrand by restricting the argument. How you restrict the argument will give you different functions as a result, but you should compute the same integral!

We pick \\( 0 < \theta < 2 \pi \\). We find that the function is discontinuous at the branch across \\( 0 \leq x \leq \infty \\) (\\( A \neq B \\) )

<p align="center"> <img alt="abtest-ch7.png" src="/r/img/aa567/abtest-ch7.png" /> </p>

{{< katex display >}}
A: \quad \theta = 0 \qquad f(A) = \frac{(r e^{i 0})^{\alpha - 1}}{r e^{i 0} + 1} = \frac{r ^{\alpha - 1}}{r + 1}
{{< /katex >}}
{{< katex display >}}
B: \quad \theta = 2 \pi \quad f(B) = \frac{(r e^{i 2 \pi})^{\alpha - 1}}{r e^{2 \pi i} + 1} = \frac{r^{\alpha - 1} e^{ 2 \pi i(\alpha - 1)}}{r + 1} = e^{ 2 \pi \alpha i} f(A)
{{< /katex >}}

If we cut the domain this way, we want to follow the contour along the real axis, then close the contour. We have to avoid the branch cut where the functino is not analytic, so we end up with this pac-man shaped contour.

<p align="center"> <img alt="ch7-contour1.png" src="/r/img/aa567/ch7-contour1.png" /> </p>

\\( C_0 \\) is what we want. \\( C_R \rightarrow 0 \\) and \\( C_2 \rightarrow 0 \\). Normally \\( C_1 \\) would cancel with \\( C_0 \\). In this case, one will be a multiple of the other, so we can still compute it.

Let's convince ourselves that \\( I = \int C_0 \\)

{{< katex display >}}
\int _{C_0} = \int_{\rho} ^{R + \rho} \frac{(r e^{i 0^+})^{\alpha - 1}}{r e^{i 0^+} + 1} \dd (r e^{i 0^+}) \\
\lim_{\rho \rightarrow 0} \lim_{R \rightarrow \infty} =  \int_{0} ^{\infty} \frac{x^{\alpha - 1}}{x + 1} \dd x = I
{{< /katex >}}

{{< katex display >}}
\int_{C_1} = \int_R ^\rho \frac{(r e^{i 2 \pi^-})^{\alpha - 1}}{r e^{i 2 \pi ^-} + 1} \dd (r e^{i 2 \pi ^-}) \\
\lim_{\rho \rightarrow 0} \lim_{R \rightarrow \infty} =  - e^{2 \pi \alpha i} \int_{0} ^{\infty} \frac{x^{\alpha - 1}}{x + 1} \dd x = - e^{ 2 \pi \alpha i} I

{{< /katex >}}

But before we get ahead of ourselves, let's waiti to take the \\( \lim_{\rho \rightarrow 0} \\) until we deal with \\( z = 0 \\) on \\( C_2 \\)

{{< katex display >}}
z = \rho e^{i \theta}
{{< /katex >}}
{{< katex display >}}
\rho \rightarrow 0^+ \qquad \theta \text{ from } 2 \pi \text{ to } 0
{{< /katex >}}

{{< katex display >}}
\int_{C_2} f(z) \dd z = \int_{2 \pi} ^0 \frac{ \rho ^{\alpha - 1} e^{i (\alpha - 1) \theta}}{\rho e^{i \theta} + 1} e^{i \theta} \rho \dd \theta \\
\lim_{\rho \rightarrow 0} = \int_{2 \pi} ^0 \frac{ \rho^{\alpha - 1} e^{i (\alpha - 1) \theta}}{1} e^{i \theta} \rho \dd \theta \\
\rightarrow \int_{2 \pi} ^0 \rho ^\alpha e^{i \alpha \theta} \dd \theta \\
= \rho^\alpha \int_{2 \pi} ^0 e^{i \alpha \theta} \dd \theta \\
= \rho^\alpha \left. \frac{i e^{\alpha \theta}}{i \alpha}\right|_{2 \pi} ^{\theta = 0}\\
= 0
{{< /katex >}}

On the big circle \\( C_R \\), \\( \int_{C_R} f(z) \dd z \rightarrow 0 \text{ as } R \rightarrow \infty  \\) if \\( |z f(z) | \rightarrow 0 \\) as \\( R \rightarrow \infty \\)

{{< katex display >}}
\left| z \frac{z^{\alpha - 1}}{z + 1} \right| = \left| \frac{z^\alpha}{z + 1} \right| \leq \frac{|z^\alpha|}{|z| - 1} \\
\rightarrow |z| ^{\alpha - 1} \rightarrow 0 \text{ as } R \rightarrow \infty
{{< /katex >}}

Putting all the pieces together,

{{< katex display >}}
\oint _C = \int_{C_0} + \int_{C_1} + \int_{C_2} + \int_{C_R} \\
= I - e^{2 \pi \alpha i} I \\
= 2\pi i \sum \text{Res} [ f(z) \text{ inside } C]
{{< /katex >}}

{{< katex display >}}
\text{Res}[z =-1] = \lim_{z \rightarrow -1} \frac{(z + 1)z^{\alpha - 1}}{z + 1} \\
= \lim_{z \rightarrow e^{i \pi}} z^{\alpha - 1} = e^{i \pi (\alpha - 1)}
{{< /katex >}}

{{< katex display >}}
I (1 - e^{2 \pi \alpha i}) = 2 \pi i e^{i \pi (\alpha - 1)}
{{< /katex >}}
{{< katex display >}}
I = \frac{2 \pi i e^{(\alpha - 1) \pi i}}{1 - e^{2 \pi \alpha i}} = \frac{\pi}{\sin(\alpha \pi)}
{{< /katex >}}

Now we know how to do the general case \\( \int_0 ^\infty x^{\alpha - 1} f(x) \dd x \\)!

For example,

{{< katex display >}}
I = \int _0 ^{\infty} \frac{x^{\alpha - 1}}{x^2 + 1} \dd x \\
= \frac{- \pi e^{-\pi \alpha i}}{\sin (\alpha \pi)} \sum \text{Res} \frac{z^{\alpha - 1}}{z ^2 + 1} \text{ at } e^{\pi i / 2}, e^{3 \pi i / 2} \\
= \frac{\pi}{\sin \alpha \pi} \sin \left( \frac{1}{2}(\alpha + 1) \pi \right)
{{< /katex >}}

In general, when trying to compute real integrals in the complex plane, we increase in difficulty as we further restrict the bounds of integration:

{{< katex display >}}
I = \int_{-\infty}^{\infty}f(x) \dd x
{{< /katex >}}
{{< katex display >}}
\rightarrow I = \int _0 ^{\infty} f(x) \dd x
{{< /katex >}}
{{< katex display >}}
\rightarrow I = \int _a ^b
{{< /katex >}}

Let's take a look at how we might compute the second-hardest case, using \\( \ln(z) \\) as an assistant:

## Complex Integrals with \\( \ln (z) \\)

Often, a multi-valued integrand involving \\( ln(z) \\) is introduced to solve a related real integral. Consider:

{{< katex display >}}
I = \int_0 ^\infty  \frac{\dd x}{1 + x^3} \dd x
{{< /katex >}}

We've evaluated this in the past by closing the contour along the radial path \\( \theta = 2 \pi / 3 \\). But this doesn't work in general for integrals of the form

{{< katex display >}}
I = \int _0 ^\infty f(x) \dd x
{{< /katex >}}

There may not be any radial line that closes the contour in an analytic single-valued way. So instead, we try evaluating the integral of \\( \ln (z) f(z) \\)

{{< katex display >}}
J = \oint _C \ln (z) f(z) \dd z
{{< /katex >}}

To make this single-valued, we restrict \\( 0 \leq \text{arg}(z) < 2 \pi \\). \\( C \\) is the closed "Pac-man" contour \\( C_R + C_0 + C_1 + C_2 \\) from the previous section:

<p align="center"> <img alt="ch7-contour1.png" src="/r/img/aa567/ch7-contour1.png" /> </p>

Suppose \\( f(z) \\) is such that

{{< katex display >}}
| \int _{C_R} \ln (z) f(z) \dd z | \rightarrow 0 \qquad |z| \rightarrow \infty
{{< /katex >}}

This si true provided \\( |z^{1+\epsilon} f(z) | \rightarrow 0 \\) for any \\( \epsilon > 0 \\). This is because \\( |\ln(z)| \\) is bounded by \\( |z^\epsilon| \\).

We also suppose that

{{< katex display >}}
|\int _{C_2} \ln(z) f(z) \dd z | \rightarrow 0 \quad \text{ as } |z| = \rho \rightarrow 0^+
{{< /katex >}}

This is true if \\( f(z) \\) is bounded as \\( |z| \rightarrow 0 \\) because

{{< katex display >}}
\int _{C_2} \ln (z) f(z) = \int _{2 \pi} ^0 (\ln \rho + i \theta) \rho e^{i \theta} i f(\rho e^{i \theta}) \dd \theta
{{< /katex >}}

and this would vanish as \\( f(\rho e^{i \theta}) \rho \ln (\rho) \\) when \\( \rho \rightarrow 0 \\).

On \\( C_0 \\): \\( z = r e^{i 0} = r \\)

{{< katex display >}}
\int _{C_0} = \int _0 ^\infty \ln(r) f(r) \dd r
{{< /katex >}}

On \\( C_1 \\): \\( z = r e^{2 \pi i} \\)

{{< katex display >}}
\int _{C_1} = \int _{\infty} ^0 (\ln (r) + 2 \pi i) f(r e^{2 \pi i}) \dd r \\
= - \int _0 ^\infty \ln(r) f(r) \dd r - 2 \pi i \int _0 ^\infty f(r) \dd r
{{< /katex >}}
{{< katex display >}}
\int _{C_0} + \int _{C_1} = \int _0 ^\infty \ln (r) f(r) \dd r - \int _0 ^\infty \ln (r) f(r) \dd r - 2 \pi i \int _0 ^{\infty} f(r) \dd r \\
= - 2 \pi i I
{{< /katex >}}

Putting it all together,

{{< katex display >}}
I = - \frac{1}{2 \pi i} \oint _C \ln (z) f(z) \dd z \\
= - \sum_{z_j} \text{Res} [ \ln (z) f(z); z_j]
{{< /katex >}}

where \\( 0 \leq \text{arg}(z) < 2 \pi  \\) and \\( z_j \\) are the poles of \\( f(z) \\), excluding the origin and positive real axis. For our example:

{{< katex display >}}
f(z) = \frac{1}{1 + z^3}
{{< /katex >}}

On \\( C_R \\) : \\( z = R e^{i \theta} \\)

{{< katex display >}}
\int _{C_R} = \int _0 ^{2 \pi} \frac{(\ln R + i \theta)}{1 + R^3 e^{3 i \theta}}
{{< /katex >}}
{{< katex display >}}
| \int _{C_R} | \leq \int _0 ^{2 \pi } \frac{R |\ln R + i \theta|}{|1 - R^3|} \dd \theta \rightarrow 0 \text{ as } R^{-2} \ln R \text{ as } R \rightarrow \infty
{{< /katex >}}

{{< katex display >}}
I = - \sum \text{Res} \frac{\ln (z)}{1 + z^3} \text{ at } e^{\pi i / 3}, e^{\pi i}, e^{5 \pi i / 3} \\
= - \frac{\ln e^{\pi i / 3}}{3 e^{2 \pi i / 3}} - \frac{\ln e^{\pi i}}{3 e^{2 \pi i}} - \frac{\ln e^{5 \pi i / 3}}{3 e^{10 \pi i / 3}} \\
= - \frac{\pi i}{9 e^{2 \pi i / 3}} - \frac{\pi i }{3} - \frac{5 \pi i }{9 e^{10 \pi i / 3}} \\
= \pi \frac{4}{9} \sin (\pi / 3) \\
= \frac{2 \pi}{3 \sqrt{3}}
{{< /katex >}}


Let's have another example:

{{< katex display >}}
I = \int _0 ^{\infty} \frac{\dd x}{x^2 + 3x + 2}
{{< /katex >}}

This is a case where there's no way to close the contour with a single-valued function, since there is no radial line other than \\( \theta = 0, 2 \pi \ldots \\) for which \\( z^2 + 2 z + 2 \\) is a constant multiple of \\( r^2 + 3r + 2 \\). But computing the related integral

{{< katex display >}}
\oint _C \frac{\ln (z) \dd z}{z^2 + 3z + 2}
{{< /katex >}}

leads us to

{{< katex display >}}
I = - \sum \text{Res} \frac{\ln(z)}{z^2 + 3z + 2} = - \frac{\ln (e^{\pi i})}{-1} - \frac{\ln (2 e^{\pi i})}{1} = \ln (2)
{{< /katex >}}

To generalize this:

{{% hint info %}}
{{< katex display >}}
{{< /katex >}}
**Computing one-sided improper integrals with \\( \ln (z) \\)**

{{< katex display >}}
I = \int _0 ^\infty f(x) \dd x = - \sum_{z_j} \text{Res}[ f(z) \ln (z); z_j]
{{< /katex >}}

where \\( 0 \leq \text{arg}(z) < 2 \pi \\) and \\( z_j \\) are the poles of \\( f(z) \\) which do not lie on the positive real axis or the origin, and

{{< katex display >}}
|z^{1 + \epsilon} f(z) | \rightarrow 0 \text{ as } R \rightarrow \infty, \epsilon > 0
{{< /katex >}}

{{% /hint %}}

Suppose \\( f(x) \\) itself contains a \\( \ln(x) \\):

{{< katex display >}}
I = \int _0 ^{\infty} \frac{\ln(x)}{x^2 + a^2} \dd x \qquad a > 0
{{< /katex >}}

Let \\( f(x) = \ln (x) g(x) \\) where \\( g(x) = 1/x^2 + a^2 \\) which is analytic. As before,

{{< katex display >}}
J = \oint _C \ln(z) f(z) \dd z = \oint _C (\ln (z))^2 g(z) \dd z
{{< /katex >}}

Again, \\( |\int _{C_R}| \rightarrow 0 \\) and \\( |\int _{C_2} | \rightarrow 0 \\)

On \\( C_0 \\), \\( z = r e^{i 0} = r \\)

{{< katex display >}}
\int_{C_0} = \int _0 ^\infty (\ln r)^2 g(r) \dd r
{{< /katex >}}

On \\( C_1 \\) , \\( z = r  e^{2 \pi i} \\)

{{< katex display >}}
\int _{C_1} = \int _{\infty} ^0 (\ln (r) + 2 \pi i)^2 g(r) \dd r \\
= - \int _0 ^\infty (\ln (r))^2 g(r) \dd r - 4 \pi i \int _0 ^\infty \ln (r) g(r) \dd r + 4 \pi ^2 \int _0 ^\infty g(r) \dd r
{{< /katex >}}

{{< katex display >}}
\int _{C_0} + \int _{C_1} = - 4 \pi i \int _0 ^\infty \ln (r) g(r) \dd r + 4 \pi ^2 \int _0 ^\infty g(r) \dd r \\
= - 4 \pi I + 4 \pi ^2 \int _0 ^\infty g(r) \dd r
{{< /katex >}}

{{< katex display >}}
J = \oint _C = 2 \pi i \sum \text{Res} [ (\ln z)^2 g(z) ; z_j \text{ in } C]
{{< /katex >}}

{{< katex display >}}
I = - \frac{1}{2} \sum \text{Res} [ (\ln z)^2 g(z)] - i \pi \int _0 ^\infty g(r) \dd r
{{< /katex >}}

{{< katex display >}}
\int _0 ^\infty g(r) \dd r = - \sum \text{Res} [ \ln z g(z) ]
{{< /katex >}}

## Finite Integrals

Now we get to the really hard stuff:

{{< katex display >}}
\int _a ^b f(x) \dd x
{{< /katex >}}

For example, say we need to compute the real integral

{{< katex display >}}
I = \int _{-1} ^1 \left( \frac{1 - x}{1 + x} \right)^{1/3} \dd x
{{< /katex >}}

Consider \\( f(z) = \left( \frac{z - 1}{z + 1} \right)^{1/3} \\). To make this multi-valued function single-valued, we need to place branch cuts and determine where the resulting function is continuous:

<p align="center"> <img alt="abtest-2-ch7.png" src="/r/img/aa567/abtest-2-ch7.png" width=300px /> </p>

{{< katex display >}}
z - 1 = r_1 e^{i \theta_1} \qquad 0 \leq \theta_1 < 2 \pi
{{< /katex >}}
{{< katex display >}}
z + 1 = r_2 e^{i \theta_2} \qquad - \leq \theta_2 < 2 \pi
{{< /katex >}}

{{< katex display >}}
A: \theta_1 = 0 \qquad \theta_2 = 0
{{< /katex >}}
{{< katex display >}}
B: \theta_1 = 2 \pi \qquad \theta_2 = 2 \pi
{{< /katex >}}

So \\( f(A) = f(B) \\) and the function is continuous from \\( 1 \rightarrow \infty \\).

{{< katex display >}}
C: \theta_1 = \pi \qquad \theta_2 = 0
{{< /katex >}}
{{< katex display >}}
D: \theta_1 = \pi \qquad \theta_2 = 2 \pi
{{< /katex >}}
{{< katex display >}}
f(C) = \left( \frac{r_1}{r_2} \right)^{1/3} e^{i \pi / 3}\\
f(D) = \left( \frac{r_1}{r_2} \right)^{1/3} e^{-i \pi / 3}
{{< /katex >}}

So \\( f(C) \neq f(D) \\) and the branch cut remains between \\( -1 \\) and \\( 1 \\). We can close this contour with a "dumbell" contour

<p align="center"> <img alt="dumbell-contour.png" src="/r/img/aa567/dumbell-contour.png" width=300px /> </p>

On \\( C_1 \\) :

{{< katex display >}}
x - 1 = z - 1 = r_1 e^{i \theta_1} \qquad \theta_1 = \pi \qquad r_1 = 1 - x
{{< /katex >}}
{{< katex display >}}
x + 1 = z + 1 = r_2 e^{i \theta_2} \qquad \theta_2 = 2 \pi \qquad r_2 = 1 + x
{{< /katex >}}

{{< katex display >}}
\int_{C_1} f(z) \dd x = \int_{-1}^{1} \left( \frac{r_1}{r_2} \right) ^{1/3} e^{i (\theta_1 - \theta_2) / 3} \dd x \\
= \int_{-1} ^1 \left( \frac{1 - x}{1 + x} \right) ^{1/3} e^{- i \pi / 3} \dd x
{{< /katex >}}

On \\( C_3 \\):

{{< katex display >}}
x - 1 = z - 1 = r_1 e^{i \theta_1} \qquad \theta_1 = \pi \qquad r_1 = 1 - x
{{< /katex >}}
{{< katex display >}}
x + 1 = z + 1 = r_2 e^{i \theta_2} \qquad \theta_2 = 0 \qquad r_2 = 1 + x
{{< /katex >}}
{{< katex display >}}
\int_{C_{3}} f(z) \dd z = \int _{-1} ^1 \left( \frac{r_1}{r_2} \right) ^{1/3} e^{i (\theta_1 - \theta_2) / 3} \dd x \\
= \int_{-1} ^{1} \left( \frac{1 - x}{1 + x} \right) ^{1/3} e^{i \pi / 3} \dd x
{{< /katex >}}

On \\( C_2 \\):

{{< katex display >}}
z - 1 = r_1 e^{i 0} \qquad r_1 \rightarrow 0
{{< /katex >}}
{{< katex display >}}
\int_{C_2} \rightarrow 0 \text{ as } r_1 ^{1/3} r_1
{{< /katex >}}

On \\( C_4 \\):

{{< katex display >}}
\frac{1}{z + 1} = \frac{1}{r_2 e^{i \theta_2}}, \qquad r_2 \rightarrow 0
{{< /katex >}}
{{< katex display >}}
\int _{C_4} \rightarrow 0 \text{ as } r_2 ^{-1/3} r_2
{{< /katex >}}

So the closed contour integral over \\( C_1 + C_2 + C_3 + C_4 \\) gives us a constant times the integral we want to do, so that's good! But we can't use the residue theorem because we've got a whole branch cut inside the contour!

{{< katex display >}}
\oint_C f(z) \dd z = (e^{- i \pi / 3} - e^{i \pi / 3} ) I
{{< /katex >}}

One method we have is to deform the contour out to infinity

{{< katex display >}}
|z| = R \text{ on } C_R
{{< /katex >}}

For large \\( R \\) we can expand \\( f(z) \\) in inverse powers of \\( z \\)

{{< katex display >}}
f(z) = \left( \frac{1 - \frac{1}{z}}{1 + \frac{1}{z}} \right)^{1/3}
{{< /katex >}}

Using the binomial expansion,

{{< katex display >}}
\frac{1}{(1 + \frac{1}{z})^{1/3}} = (1 + \frac{1}{z})^{-1/3} \approx 1 - \frac{1}{3} \frac{1}{z} + \ldots
{{< /katex >}}

{{< katex display >}}
f(z) \approx 1 - \frac{2}{3} \frac{1}{z}  + ( ) z^2 + \ldots
{{< /katex >}}


Then we compute the integral directly

{{< katex display >}}
\int_{C_R} f(z) \dd z = \int _0 ^{2 \pi} \left( 1 - \frac{2}{3} \frac{1}{R e^{i \theta}} + \ldots \right) R e^{i \theta} \dd \theta
{{< /katex >}}

All terms except the first go to zero for large \\( R \\) and we're left with

{{< katex display >}}
= - \frac{2}{3} 2 \pi i
{{< /katex >}}

{{< katex display >}}
- \frac{4 \pi i}{3} = - 2 i \sin \frac{\pi}{3} I \quad \rightarrow \quad I = \frac{2 \pi}{3 \sin (\pi / 3)}
{{< /katex >}}

Or, we could take method 2: flip the direction of \\( C \\) around so that it encloses points on the outside, in a negative sense. There, the only singularity is the point as \\( \infty \\), defined as

{{< katex display >}}
z = \frac{1}{t} \quad \text{ as } t \rightarrow 0
{{< /katex >}}

{{< katex display >}}
\oint _C f(z) \dd z = - \oint _{C_{\infty}}f(z) \dd z
{{< /katex >}}
So what is the residue of the point at infinity?

{{< katex display >}}
z = \frac{1}{t} \qquad \dd z = - \frac{1}{t^2} \dd t
{{< /katex >}}

{{< katex display >}}
- \oint _{C_{\infty}} - \frac{1}{t^2} f(\frac{1}{t}) \dd t = \oint _{C_\infty} \frac{1}{t^2} f(\frac{1}{t}) \dd t = 2 \pi i \text{Res} (f(\frac{1}{t}); t = 0)
{{< /katex >}}

{{< katex display >}}
f(t) = 1 + \frac{2}{3} t + ( ) t^2 + \ldots
{{< /katex >}}

{{< katex display >}}
\frac{1}{t^2} f(\frac{1}{t}) = \frac{1}{t^2} - \frac{2}{3} \frac{1}{t} + \ldots
{{< /katex >}}

So we can just pick out the residue as \\( \text{Res(t = 0)} = - \frac{2}{3} \\).

The most difficult case of all is the finite integral of a function which is analytic everywhere on the interval.

{{< katex display >}}
I = \int _a ^b f(x) \dd x
{{< /katex >}}

Consider

{{< katex display >}}
g(z) = \ln \left[ \frac{(z - b)}{(z - a)} \right] f(z)
{{< /katex >}}

and again, look at the dumbell contour in the z plane. The resulting function is of course multi-valued, so we need to restrict the arguments
{{< katex display >}}
z_1 = r_1 e^{i \theta_1} \qquad z_2 = r_2 e^{i \theta_2}
{{< /katex >}}
{{< katex display >}}
0 \leq \theta_1 < 2 \pi \qquad 0 \leq \theta_2 < 2 \pi
{{< /katex >}}

We check the continuity using the same A/B test as before

At \\( A \\):

{{< katex display >}}
\theta_1 = 0 \qquad \theta_2 = 0
{{< /katex >}}
{{< katex display >}}
\ln \frac{z - b}{z - a} = \ln \frac{ r_1 e^{i \theta_1}}{r_2 e^{i \theta_2}} = \ln \frac{r_1}{r_2} + i (\theta_1 - \theta_2)
{{< /katex >}}

At \\( B \\):

{{< katex display >}}
\theta_1 = 2 \pi \qquad \theta_2 = 2 \pi
{{< /katex >}}

So \\( g(A) = g(B) \\) and the function is continuous from \\( b \rightarrow \infty \\)

At \\( C \\):

{{< katex display >}}
\theta_1 = \pi \qquad \theta_2 = 0
{{< /katex >}}
At \\( D \\):
{{< katex display >}}
\theta_1 = \pi \qquad \theta_2 = 2 \pi
{{< /katex >}}

Since \\( g(C) \neq g(D) \\) the branch cut remains between \\( a \rightarrow b \\). Now we try to compute the integral over the dumbell contour \\( C \\)

{{< katex display >}}
J = \oint _C \ln \frac{z - b}{z - a} \dd z
{{< /katex >}}

Along the bottom,

{{< katex display >}}
z = x - i \epsilon \qquad \theta_1 = \pi \qquad \theta_2 = 2 \pi
{{< /katex >}}
{{< katex display >}}
g(z) = \left[ \ln \frac{b - x}{x - a} - i \pi \right] f(z)
{{< /katex >}}

Along the top,

{{< katex display >}}
z = x + i \epsilon \qquad \theta_1 = \pi \qquad \theta_2 = 0
{{< /katex >}}

{{< katex display >}}
g(z) = \left[\ln \frac{b - x}{x - a} + i \pi \right] f(z)
{{< /katex >}}

On the little circles:

{{< katex display >}}
z = b + \epsilon e^{i \theta} \qquad \dd z = \epsilon e^{i \theta} \dd \theta
{{< /katex >}}
{{< katex display >}}
g \sim \ln \epsilon f(b) \qquad g \dd z \sin \epsilon \ln \epsilon f(b) \rightarrow 0 \text{ as } \epsilon \rightarrow 0
{{< /katex >}}

So now we've just got the two straight segments. But we want \\( \int f(z) \\), not \\( \int \ln \frac{b - z}{a - z} f(z) \\). Lucky for us, some things are about to cancel nicely:

{{< katex display >}}
\oint _C g(z) \dd z = \int _a ^b f(z) \left( \left[ \ln \frac{b - x}{x - a} - i \pi \right] - \left[ \ln \frac{b - x}{x - a} + i \pi \right] \right) \dd x \\
= - 2 \pi i \int _a ^b f(x) \dd x
{{< /katex >}}

{{< katex display >}}
I = \int _a ^b f(x) \dd x = - \frac{1}{2 \pi i} \oint _C g(z) \dd z
{{< /katex >}}

We could almost have anticipated this result from the beginning, because the discontinuity in \\( g(z) \\) is only in the argument, not the imaginary part. So we've successfully enclosed a contour. But we've enclosed a branch cut in doing so, so the residue theorem does not apply. So as usual with the dumbell contour, we can add a minus sign and find the residues of \\( g(z) \\) outside of \\( C \\), plus the residue at infinity

{{< katex display >}}
\oint_C g(z) \dd z = - 2 \pi i \sum \text{Res} ( f(z) ; z_j \text{ outside } C) + 2 \pi i \sum \text{Res} ( \frac{1}{t^2} f(\frac{1}{t}); t \rightarrow 0)
{{< /katex >}}


{{< katex display >}}
I = \int _a ^b f(x) \dd x = \sum \text{Res}[ g(z) ; z_j \text{ in the cut plane }] - \text{Res} [ \frac{1}{t^2} f(\frac{1}{t}); t \rightarrow 0]
{{< /katex >}}

(Just as a note on the sign flipping here, we have \\( -2 \pi i \sum \text{Res} \\) because we flipped the contour inside out. We get another sign flip for the residue at infinity from \\( \dd z \rightarrow - \frac{1}{t^2} \dd t \\) )
