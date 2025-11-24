---
title: Fluid Flow
weight: 100
---

{{< katex display >}}

{{< /katex >}}

# Ideal Fluid Flow

Suppose we have an irrotational fluid:

{{< katex display >}}
\curl \vec V = 0
{{< /katex >}}

If \\( \vec V \\) is curl-free, then there exists a potential \\( \phi \\) such that

{{< katex display >}}
\vec V = \grad \phi
{{< /katex >}}

In 2D, for example, this means

{{< katex display >}}
\vec V = U \vu{x} + V \vu{y} \\
\pdv{\phi}{x} = U \qquad \pdv{\phi}{y} = V
{{< /katex >}}

Physically, an inviscid flow is the result of zero viscosity. Generally this is a good approximation of fluid flow as long as we are far away from any boundaries.

If the fluid is also incompressible:

{{< katex display >}}
\div \vec V = 0 \qquad \rightarrow \qquad \pdv{U}{x} + \pdv{V}{y} = 0
{{< /katex >}}

Then this implies the existence of a stream function \\( \psi \\) such that

{{< katex display >}}
\pdv{\psi}{y} = U \qquad \pdv{\psi}{x} = - V
{{< /katex >}}

because we can substitute into the divergence-free condition:

{{< katex display >}}
\pdv{}{x} \pdv{\psi}{y} - \pdv{}{y} \pdv{\psi}{x} = 0
{{< /katex >}}

The divergence of a curl is always zero:

{{< katex display >}}
\div (\curl \vec V) = 0 \qquad \rightarrow \qquad \nabla ^2 \phi = 0
{{< /katex >}}

Both \\( \phi \\) and \\( \psi \\) are harmonic functions, so the function

{{< katex display >}}
F(z) = \phi + i \psi
{{< /katex >}}

is analytic.

**Example**: uniform flow

{{< katex display >}}
F(z) = U_0 z
{{< /katex >}}

{{< katex display >}}
U = U_0 = \pdv{\phi}{x} \quad \rightarrow \quad \phi = U_0 x + C
{{< /katex >}}
{{< katex display >}}
V = 0 = \pdv{\phi}{y} \qquad \rightarrow \qquad \phi \text{ cannot depend on y}
{{< /katex >}}
{{< katex display >}}
U = U_0 = \pdv{\psi}{y} \qquad \rightarrow \qquad \phi = U_0 y + C
{{< /katex >}}
{{< katex display >}}
V = 0 = - \pdv{\psi}{x} \qquad \rightarrow \qquad \psi \text{ cannot depend on x}
{{< /katex >}}

**Example**: Uniform flow at angle \\( \alpha \\) 

We can just rotate everything by \\( \alpha \\) and

{{< katex display >}}
F(z) = U_0 z e^{i \alpha}
{{< /katex >}}

**Example**: Source flow

Given a point source at the origin (think a line source perpendicular to the z-plane), mass conservation implies

{{< katex display >}}
Q = 2 \pi r \rho = \text{ const. }
{{< /katex >}}

Radial flow velocity \\( V_0 \\) is 

{{< katex display >}}
V_0 = \frac{Q / \rho}{2 \pi r}
{{< /katex >}}

We can define the complex velocity \\( W(z) \\) 

{{< katex display >}}
W(z) \equiv \pdv{F(z)}{z} = U - i V
{{< /katex >}}

where we have used the fact that \\( F(z) \\) is analytic. Then in this example,

{{< katex display >}}
W(z) = V_0 (\cos \theta - i \sin \theta) \\
= \frac{Q / \rho}{2 \pi r} e^{- i \theta} \\
= \frac{Q / \rho}{2 \pi} \frac{1}{z}
{{< /katex >}}

{{< katex display >}}
F(z) = \int _0 ^z W(z) \dd z = \frac{Q / \rho}{2 \pi} \ln z + C
{{< /katex >}}
{{< katex display >}}
\psi = \text{Im} F = \frac{Q / \rho}{2 \pi} \theta
{{< /katex >}}

Again, the streamlines are rays pointing out from the origin.

As a side note, we see that when we have to integrate \\( 1/z \\), we introduce the nowhere-analytic \\( \ln z \\) and therefore we introduce a branch cut and have to restrict the argument. Why is this?

**Example**: Vortex flow

{{< katex display >}}
U = - V_0 \sin \theta
{{< /katex >}}
{{< katex display >}}
V = V_0 \cos \theta
{{< /katex >}}

We define the conserved quantity "circulation" \\( \Gamma \\) 
{{< katex display >}}
\Gamma = \oint \vec V \cdot \dd \vec l = 2 \pi r V_0
{{< /katex >}}

Conservation of angular momentum tells us that

{{< katex display >}}
U = - \frac{\Gamma}{2 \pi r} \sin \theta
{{< /katex >}}
{{< katex display >}}
V = \frac{\Gamma}{2 \pi r } \cos \theta
{{< /katex >}}
{{< katex display >}}
W = - \frac{i \Gamma}{2 \pi r} (\cos \theta - i \sin \theta) = - \frac{i \Gamma}{2 \pi r} \frac{1}{z}
{{< /katex >}}
{{< katex display >}}
F(z) = \int ^z W(z) \dd z = - \frac{i \Gamma}{2 \pi } \ln z + C
{{< /katex >}}

This is very similar to the source flow case. That extra factor of \\( i \\) makes all the difference. Radial source flow has a purely real coefficient for \\( \ln z \\), and purely rotational vortex flow has an imaginary coefficient for \\( \ln z \\). Cool.
