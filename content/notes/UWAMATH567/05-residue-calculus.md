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

> [!IMPORTANT]
> {{< katex display >}}
{{< /katex >}}
> **Cauchy's Residue Theorem**
> 
> Let \\( C \\) be a simple closed contour within and on which a function \\( f(z) \\) is analytic except for a finite number of isolated singularities \\( z_1, \ldots, z_m  \\). Then
> 
> {{< katex display >}}
\oint_C f(z) \dd z = 2 \pi i \sum_{n=1} ^m \text{Res}[z_n]
{{< /katex >}}
> 
> where \\( \text{Res}[z_n] \\) is the residue of \\( f(z) \\) at \\( z_n \\).


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

> [!IMPORTANT]
> {{< katex display >}}
{{< /katex >}}
> **Residue of rational functions**
> 
> This gives us a useful formula to find the residue at a simple pole of \\( z_0 \\) of a rational function
> 
> {{< katex display >}}
f(z) = P(z) / Q(z)
{{< /katex >}}
> 
> where \\( P(z) \\) is analytic and \\( Q(z) \\) has a simple pole at \\( z_0 \\):
> 
> {{< katex display >}}
\text{Res}(z_0) = \frac{P(z_0)}{Q'(z_0)}
{{< /katex >}}
