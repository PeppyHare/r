---
title: Conformal Mappings
weight: 90
---

{{< katex display >}}

{{< /katex >}}

# Conformal Mappings

A **conformal mapping** is a mapping which preserves both the magnitude and sense of angles. The funny thing is when we work with conformal mappings to solve problems, we will mostly be looking for places where a mapping is _not_ conformal. For the definition:

A mapping which preserves the magnitude and sense of the angle between two smooth arcs passing through a specific point is said to be conformal at that point.

<p align="center"> <img alt="conformal-mapping-diagram.png" src="/r/img/aa567/conformal-mapping-diagram.png" /> </p>

{{% hint info %}}
{{< katex display >}}
{{< /katex >}}
**Theorem**

At each point where \\( w(z) \\) is analytic and \\( w'(z) \neq 0 \\), the mapping \\( w = w(z) \\) is conformal.

{{% /hint %}}

We'll come back to prove this later, but this isn't the important part. Non-conformality is what is important for us.

Let's take a look at invariance of the Laplace equation under a conformal mapping

{{< katex display >}}
z = x + iy
{{< /katex >}}

{{< katex display >}}
\nabla ^2 \phi = 0 
{{< /katex >}}

{{< katex display >}}
w = u + iv
{{< /katex >}}

If \\( w \\) is conformal, then \\( \nabla ^2 _w \phi = \pdv{^2 \phi}{u^2} + \pdv{^2 \phi}{v^2} = 0 \\) 

As we know, in numerical analysis we frequently use conformal mappings to solve problems in a simpler geometry than the physical geometry.

Showing the invariance of the Laplace equation under a conformal mapping is pretty easy, but it is tedious:

<p align="center"> <img alt="laplace-equation-conformal.png" src="/r/img/aa567/laplace-equation-conformal.png" /> </p>

(can't be bothered to type all that out again right now...)

So, the Laplace equation is fine, but how do we know what sort of mapping to use for our particular boundary conditions? The answer is basically people have made tables of conformal mappings that are useful for particular types of boundary conditions; just look in the back of a complex analysis textbook to find the one we need

Example:

{{< katex display >}}
f(z) = \frac{1}{\pi} \ln (z) \qquad 0 \leq \text{arg}(z)  < 2 \pi
{{< /katex >}}
{{< katex display >}}
\psi = \text{Im} f(z) = \frac{1}{\pi} \theta
{{< /katex >}}

\\( \psi \\) satisfies the Laplace equation. The constants of \\( \psi \\) are like rays out from the origin - streamlines for a source flow. The particular problem that \\( \psi \\) solves looks like this:

<p align="center"> <img alt="cm-laplace-problem-1.png" src="/r/img/aa567/cm-laplace-problem-1.png" /> </p>


Another example: electrostatic potential in a cylindrical conductor:

<p align="center"> <img alt="cm-laplace-problem-2.png" src="/r/img/aa567/cm-laplace-problem-2.png" /> </p>

We want to convert the circle into a straight line, and the interior into the upper half plane. To transform circles into straight lines requires a bilinear transformation:

{{< katex display >}}
w(z) = A \frac{z - z_1}{z - z_0}
{{< /katex >}}

<p align="center"> <img alt="cm-problem-2-mapping.png" src="/r/img/aa567/cm-problem-2-mapping.png" /> </p>

We pick \\( z_0 = -1 \\) to map point \\( C \\) to infinity. Then we map \\( a \\) to the origin by picking \\( z_1 = 1 \\). Then choose \\( A = -i \\) so the image lies flat

{{< katex display >}}
w(z) = i \frac{z - 1}{z + 1}
{{< /katex >}}
{{< katex display >}}
\phi = \frac{1}{\pi} \ln w \\
= \frac{1}{\pi} \text{arg} w \\
= \frac{1}{\pi} \text{arg} \left( i \frac{z - 1}{z + 1} \right) \\
= \frac{1}{\pi} \tan^{-1} \left( \frac{1 - x^2 - y^2}{2y} \right) \quad 0 \leq \theta < 2 \pi
{{< /katex >}}

In the \\( w \\) plane, the unit circle is

{{< katex display >}}
|z|^2 = 1 \qquad \rightarrow \qquad w = -i \frac{z - z^\star}{2(1 + x)} = \frac{y}{1 + x}
{{< /katex >}}

This is real, so \\( v = 0 \\). The interior of the circle is the upper half plane \\( v > 0 \\).
