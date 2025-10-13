---
title: Sequences, series, and singularities
weight: 40
---

{{< katex display >}}

{{< /katex >}}


# Series

If we talk to a pure mathematician about series, things can get very complicated, so in this course we will do things starting from a series that we should find very familiar: the geometric series

{{< katex display >}}
S_N = 1 + r + r^2 + \ldots + r^N
{{< /katex >}}

To sum it up, we multiply by \\( r \\) and subtract:

{{< katex display >}}
r S_N = r + r^2 + \ldots + r^{N+1}
{{< /katex >}}
{{< katex display >}}
(1 - r)S_N = 1 - r^{N+1}
{{< /katex >}}
{{< katex display >}}
\rightarrow S_N = \frac{1 - r^{N+1}}{1 - r}
{{< /katex >}}

For the infinite series,

{{< katex display >}}
S = \sum_{n=0}^{\infty} r^n
{{< /katex >}}

{{< katex display >}}
S = \lim_{N \rightarrow \infty} S_N = \lim_{N \rightarrow \infty} \frac{1 - r^{N+1}}{1 - r}
{{< /katex >}}

The series converges if this limit converges. For the geometric series we can see by inspection that if \\( |r| < 1 \\) then

{{< katex display >}}
\lim_{N \rightarrow \infty} \frac{1 - r^{N+1}}{1 - r} = \frac{1}{1 - r}
{{< /katex >}}

If instead \\( r \\) is complex, then there is some other terminology we should use. If \\( \sum_{n = 0} ^{\infty} |z_n| \\) converges, then we say the series \\( \sum_{n = 0} ^\infty z_n \\) is **absolutely convergent**. Absolute convergence implies convergence, since

{{< katex display >}}
| S_N | = \left| \sum_{n = 0} ^{\infty} z_n \right| \leq \sum_{n=0} ^{\infty} |z_n|
{{< /katex >}}

by the triangle inequality. So if \\( \sum_{n=0} ^{\infty} |z_n| \\) converges, so must \\( |S_N| \\).

But of course the other way around is not true. If \\( \sum_{n=0} ^\infty z_n \\) is convergent, we can't necessarily say anything about \\( \sum_{n=0} ^\infty |z_n| \\). In real variables, a common example of this situation is

{{< katex display >}}
\sum_{n=1} ^\infty (-1)^n \frac{1}{n}
{{< /katex >}}

This converges, but \\( \sum_{n=1} ^{\infty} \frac{1}{n} \\) does not.

A complex series \\( \sum_{n=0} ^{\infty} c_n \\) is convergent if \\( \sum_{n=0} ^{\infty} |c_n| \\) is convergent. We can compare the absolute convergence with \\( \sum_{n=0} ^{\infty} r^n \\). \\( \sum_{n=0}^{\infty} |c_n| \\) is convergent if \\( \left| \frac{c_{n+1}}{c_n} \right| < 1 \\) by the same principle.

{{% hint info %}}
{{< katex display >}}
{{< /katex >}}
**Comparison test**

Suppose the series \\( \sum_{n=0} ^\infty a_n (z - z_0)^n \\) is convergent for \\( |z - z_0| < R \\). Then if for \\( n \geq N \\) we can show that

{{< katex display >}}
|b_n| \leq |a_n|
{{< /katex >}}

then the series \\( \sum_{n=0} ^\infty b_n(z - z_0)^n \\) is also convergent for \\( |z - z_0| < R \\)

{{% /hint %}}

## Cauchy-Taylor theorem

{{% hint info %}}
{{< katex display >}}
{{< /katex >}}
**Cauchy-Taylor theorem**

If \\( f(z) \\) is analytic throughout the circular disk \\( |z - z_0| < R> \\) , then it can be expanded in a Taylor series about the point \\( z_0 \\), and that series is convergent everywhere inside the disk.

{{< katex display >}}
f(z) = \sum_{n=0} ^\infty A_n (z - z_0)^n \qquad A_n = \frac{f^{(n)}(z_0)}{n!} = \frac{1}{2 \pi i} \oint_C \frac{f(\xi) \dd \xi}{(\xi - z_0)^{n+1}}
{{< /katex >}}

**Proof**

Starting with the Cauchy integral formula,

{{< katex display >}}
f(z) = \oint_C \frac{1}{2 \pi i} \frac{f(\xi) \dd \xi}{\xi - z}
{{< /katex >}}

We take \\( C \\) to be the biggest circle centered at \\( z_0 \\) on and inside which \\( f(\xi) \\) is analytic. Then, we expand the denominator about \\( z_0 \\).

{{< katex display >}}
\frac{1}{\xi - z} = \frac{1}{(\xi - z_0) - (z - z_0)} \\
= \frac{1}{(\xi - z_0)(1 - \frac{z - z_0}{\xi - z_0})} \\
= \frac{1}{(\xi - z_0)}\frac{1}{1 - r} \qquad r \equiv \frac{z - z_0}{\xi - z_0}
{{< /katex >}}

We've shown that for \\( |r | < 1 \\) the geometric series holds for \\( \frac{1}{1 - r} = \sum_{n=0} ^\infty r^n \\). Along the contour, \\( |z - z_0| < |\xi - z_0| = R \\). Changing the order of integration and summation,

{{< katex display >}}
f(z) = \frac{1}{2 \pi i} \sum_{n=0} ^\infty \oint_C \frac{f(\xi) \dd \xi (z - z_0)^n}{(\xi - z_0)^{n+1}} \\
= \frac{1}{2\pi i} \sum_{n=0} ^\infty \frac{2 \pi i f^{(n)}(z_0)}{n!}\\
= \sum_{n=0} ^\infty A_n (z - z_0)^n \qquad |z - z_0 | < R
{{< /katex >}}

This gives us our series.

(note: we can integrate term by term since the geometric series converges _uniformly_.)

{{% /hint %}}

The addition to the normal Taylor series we're used to is the aspect of convergence. If we want to expand about \\( z_0 \\), we can expand the radius of convergenze (where the series converges) out from \\( z_0 \\) as far as we want until we hit a point where \\( f(z) \\) is no longer analytic. That is the only thing that determines the radius of convergence.

For example, looking at \\( \frac{1}{1 - z} = 1 + z + z^2 + \ldots  \\) we can say that the series converges for \\( |z| < 1 \\) because it has a singularity at \\( z = 1 \\).

This provides a nice explanation for the radius of convergence of some real series, like

{{< katex display >}}
\frac{1}{1 + z^2} = 1 - z^2 + z^4 - \ldots
{{< /katex >}}

The ratio test gives \\( |z | < 1 \\), and this is because there is a singularity at \\( z = i \\). Even if we restrict \\( z \\) to real values, we are bound by the same region of convergence.

# Laurent Series

A Laurent series is an extension of the Taylor series, that has the form

{{< katex display >}}
f(z) = \sum_{n = -\infty} ^{\infty} a_n (z - z_0)^n
{{< /katex >}}

where

{{< katex display >}}
a_n = \frac{1}{2 \pi i} \oint_C \frac{f(\xi) \dd \xi}{(\xi - z_0)^{n+1}}
{{< /katex >}}

This series converges in the annulus

{{< katex display >}}
r_0 < |z - z_0| < R
{{< /katex >}}

in which the function \\( f(z) \\) remains analytic.

This allows for the function to blow up at \\( z = z_0 \\). Skipping the proof of the region of convergence here, it's in the book somewhere...

We almost never use this formula for \\( a_n \\). It's a real pain! There is almost always an easier way to calculate the series, as we'll see in the next examples. But the theorem is useful for knowing the radius of convergence.

There are several cases we should consider:

1. If there are no singularities beyond some \\( r_0 \\), then we can extend \\( R \\) to \\( \infty \\)
2. If there is no singularity inside \\( |z - z_0| < r_0 \\) then we can shrink \\( r_0 \\) to zero (and the series becomes a Taylor series expansion)
3. If a singularity at \\( z = a \\) inside the smaller circle, the smallest value \\( r_0 \\)  can take is \\( |z_0 - a| \\)
4. If we choose \\( z_0 \\) to be the same as \\( a \\), i.e. we are expanding \\( f(z) \\) about one of its singularities, then the expansion **is** valid in the "punctured neighborhood" \\( 0 < |z - z_0 | < R \\)  (note that the point \\( z_0 \\) is not included in the neighborhood of validity). This is only possible as long as \\( z_0 \\) is an _isolated_ singularity. For example, we can't do this along a branch cut because there is no neighborhood that doesn't also contain other non-analytic points.

**Example**: Expand \\( f(z) = e^{z} / z \\) about \\( z = 0 \\).

In this case, the easier way to get the coefficients of the series is to use the expansion of \\( e^z \\) and just divide by \\( z \\)

{{< katex display >}}
\frac{e^z}{z} = \frac{1}{z} \left[1 + \frac{z}{1!} + \frac{z^2}{2!} + \ldots \right] = \frac{1}{z} + 1 + \frac{z}{2!} + \frac{z^2}{3!} + \ldots
{{< /katex >}}

The region of convergence of this series is \\( 0 < |z| \\).

**Example** Expand \\( f(z) = \frac{1}{1 - z} \\) in several different regions, in powers of \\( z \\) (that is, about \\( z = 0 \\) )

a) In the region \\( |z| < 1 \\): Just write down the geometric series

{{< katex display >}}
f(z) = 1 + z + z^2 + z^3 + \ldots \qquad |z| < 1
{{< /katex >}}

b) For \\( |z| > 1 \\)

We can re-express the function as

{{< katex display >}}
\frac{1}{1 - z} = - \frac{1}{z} \frac{1}{1 - \frac{1}{z}} = - \frac{1}{z} \left[ 1 + (1/z) + (1/z)^2 \right] \\
 = - \frac{1}{z} - \frac{1}{z^2} - \frac{1}{z^3} - \ldots
{{< /katex >}}

If we let \\( t = \frac{1}{z} \\) we can see that this is like a Taylor expansion about \\( t = 0 \\), or about \\( z = \infty \\). The radius of convergence stretches from \\( r_0 = \infty \\) down to \\( R = 1 \\)

**Example**

{{< katex display >}}
f(z) = \frac{1}{(z - 1) (z - 2)} = \frac{1}{z - 2} - \frac{1}{z - 1}
{{< /katex >}}

a) Expand with validity \\( |z| < 1 \\)

There are singularities at \\( z = 1 \\) and \\( z = 2 \\). We expand about \\( z = 0 \\)

{{< katex display >}}
- \frac{1}{z - 1} = \frac{1}{1-z} = \sum_{n=0} ^\infty z^n \qquad |z| < 1
{{< /katex >}}

{{< katex display >}}
\frac{1}{z - 2} = - \frac{1}{2} \frac{1}{1 - \frac{z}{2}} = - \frac{1}{2} \sum_{n=0}^{\infty} (z/2)^n \qquad |z/2| < 1
{{< /katex >}}

The sum of the two will have the smaller radius of convergence

{{< katex display >}}
f(z) = \sum_{n=0} ^\infty - \frac{1}{2} (z/2)^n + (z)^n \qquad |z | < 1
{{< /katex >}}

b) Convergingn in \\( |z| > 2 \\). Again, expand about \\( z_0 = \infty \\) with

{{< katex display >}}
\frac{1}{z - 2} = \frac{1}{z} \frac{1}{1 - \frac{2}{z}} = \frac{1}{z} \sum_{n=0} ^\infty (2/z)^n
{{< /katex >}}

{{< katex display >}}
\frac{1}{z - 1} = \frac{1}{z} \sum_{n=0} ^\infty (1/z)^n
{{< /katex >}}

This is again a Taylor expansion in \\( 1/z \\) about \\( z = \infty \\).

c) In the region \\( 1 < |z| < 2 \\)

Just combine the expansion of each term such that the intersection gives the region of validity we're looking for:

{{< katex display >}}
\frac{1}{z - 1} = -\frac{1}{z} \frac{1}{1 - \frac{1}{z}} = \frac{1}{z} \sum_{n=0} ^\infty (1/z)^n \qquad | 1/z | < 1
{{< /katex >}}

{{< katex display >}}
\frac{1}{z - 2} = - \frac{1}{2} \frac{1}{1 - \frac{z}{2}} = - \frac{1}{2} \sum_{n=0} ^\infty (z/2)^n \qquad |z| < 2
{{< /katex >}}

The sum is valid in the annulus

{{< katex display >}}
f(z) = \sum_{n=-\infty} ^{-1} - z^n + \sum_{n=0} ^{\infty} \frac{1}{2^{n+1}} z^n \qquad 1 < |z| < 2
{{< /katex >}}
