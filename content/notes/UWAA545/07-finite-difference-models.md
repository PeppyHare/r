---
title: Finite Difference Methods for MHD
weight: 70
# bookToc: false
---

# Finite Differencing

So for 1D MHD, we want to derive algorithms to advance the governing equations in time that have the form

{{< katex display >}}
\pdv{\vec Q}{t} + \pdv{\vec F}{x} = 0
{{< /katex >}}

We can use the advection equation as a model equation:
{{< katex display >}}
\pdv{u}{t} + a \pdv{u}{x} = 0
{{< /katex >}}
which has the general solution
{{< katex display >}}
u(x - at) = \text{const.} = u(x, t=0)
{{< /katex >}}

If we apply a forward Euler finite difference operators to our PDE,

{{< katex display >}}
\frac{u_j ^{n+1} - u^n _j}{\Delta t} + a \frac{u _{j+1} ^n - u_{j-1} ^n}{2 \Delta x} = 0
{{< /katex >}}

## Stability

A brief von Neumann stability analysis shows that this forward Euler differencing is unstable. The way von Neumann stability analysis works, we assume a wave structure for the solution
{{< katex display >}}
u_j ^n = A^n e^{i k x} = \underbrace{A ^n}_{\text{wave amplitude}} \cdot \overbrace{e^{i k j \Delta x}}^{\text{wave structure}}
{{< /katex >}}

If we substitute this form into our finite difference expression, we have

{{< katex display >}}
A^{n+1} e^{i k j \Delta x} = A^n e^{i k j \Delta x} - \frac{a \Delta t}{2 \Delta x}\left(A^n e^{i k (j+1) \Delta x} - A^n e^{i k (j-1) \Delta x} \right)
{{< /katex >}}
We're interested in the growth of the amplitude \\( A^n \\), called the amplification factor \\( G \\):
{{< katex display >}}
G  \equiv \frac{|A^{n+1}|}{|A^n|}
{{< /katex >}}

For forward Euler, we find 
{{< katex display >}}
\begin{aligned}
\frac{A^{n+1}}{A^n} & = &   1 - \frac{a \Delta t}{2 \Delta x} \left( e^{i k \Delta x} - e^{- i k \Delta x} \right) \\
& = & 1 - \frac{i a \Delta t}{\Delta x} \sin (k \Delta x) \\
G & = & \sqrt{\left( \frac{A^{n+1}}{A^n} \right) \left( \frac{A^{n+1}}{A^n} \right)^\star} \\
& = & \sqrt{1 + \left( \frac{a \Delta t}{\Delta x}\right) ^2 \sin ^2 (k \Delta x)} \\
& \geq & 1 \quad \text{if} \quad \Delta t > 0
\end{aligned}
{{< /katex >}}

<p align="center"> <img alt="33.png" src="/r/img/545/33.png" /> </p>

We find that the forward time, centered space (FTCS) algorithm is unconditionally unstable, for any values of \\( k \\), \\( \Delta t > 0 \\). Not a very good choice for solving the advection equation! However, the FTCS algorithm is an important component of many finite difference schemes which **are** stable.

Physically, the difficulty with the advection term can be seen in the continuity equation

{{< katex display >}}
\pdv{\rho}{t} + \vec v \cdot \grad \rho = - \rho \div \vec v = 0 \quad \text{(incompressible)}
{{< /katex >}}

Using the FTCS difference approach to compute the gradients, we're assuming that the gradient at node \\( j \\) is constant over the time interval \\( n \rightarrow n + 1 \\). This is only valid if the density profile is linear, and for non-linear profiles the gradient is inaccurate. 

<p align="center"> <img alt="34.png" src="/r/img/545/34.png" /> </p>

If we approximate the gradient of the density as

{{< katex display >}}
\pdv{\rho}{x} \approx \frac{\rho _{j+1} - \rho_{j - 1}}{2 \Delta x}
{{< /katex >}}

then we get an error that is the difference between the line tangent at \\( j - 1 \\) and the line tangent at \\( j \\). We should actually calculate the gradient at \\( t + \Delta t / 2 \\) (assuming the flow is in the positive direction). The error leads to an over-estimate of the gradient magnitude, which leads to oscillations, which ultimately leads to instability.

## Stable Solution Approaches for Advection Equation

There are a few approaches we can take to come up with a finite differencing scheme which avoids this instability.

1. Since the error is oscillating positive and negative, we can add diffusion to smooth out the error. This is the same as applying a time-average of the error to smooth the solution.

<p align="center"> <img alt="35.png" src="/r/img/545/35.png" /> </p>

Spatial smoothing also works:

<p align="center"> <img alt="36.png" src="/r/img/545/36.png" /> </p>

Noting that G increases with \\( k \Delta x \\), the shortest wavelengths grow the fastest, which is why a diffusive term helps smooth out the instability.

2. Since the error is caused by computing the gradient at the wrong location, e.g. \\( x_j \\) instead of \\( x_j - v \Delta t / 2 \\), we can use upwind differencing

{{< katex display >}}
\delta _x \rho _j = \begin{cases}
\frac{\rho _j - \rho _{j-1}}{\Delta x} & \quad & \text{ if} \quad v \geq 0 \\
\frac{\rho_{j+1} - \rho_j}{\Delta x} & \quad & \text{if } v < 0
\end{cases}
{{< /katex >}}

3. Flux can be calculated as before, but we can apply limits to prevent minima or maxima from developing. Some approaches like this in the literature are
- total variation diminishing
- total variation bounded
- flux corrected transport

4. Eliminate the advection term, or reduce it. If we write out the MHD equations in such a way that the advection term \\( \vec v \cdot \grad \\) is split out from the rest:

{{< katex display >}}
\pdv{\rho}{t} + \vec v \cdot \grad \rho = - \rho \div \vec v
{{< /katex >}}
{{< katex display >}}
\pdv{\vec v}{t} + \vec v \cdot \grad \vec v = ( - \grad p + \vec j \cross \vec B) / \rho
{{< /katex >}}
{{< katex display >}}
\pdv{\vec B}{t} + \vec v \cdot \grad \vec B = - \vec B \div \vec v + \vec B \cdot \grad \vec v
{{< /katex >}}
{{< katex display >}}
\pdv{p}{t} + \vec v \cdot \grad p = - \Gamma p \div \vec v
{{< /katex >}}

If we let the grid move at the fluid velocity \\( \vec v \\)

{{< katex display >}}
\vec u _{grid} = \vec v
{{< /katex >}}

then the advection term becomes

{{< katex display >}}
\vec v \cdot \grad \rightarrow ( \vec v - \vec u _{grid}) \cdot \grad
{{< /katex >}}

which vanishes. Codes like this, expressing the equations of motion in Lagrangian frame of reference, are generally called ALE codes (Arbitrary Lagrangian Eulerian).

### Method 1: Lax Algorithm

To solve

{{< katex display >}}
\pdv{u}{t} + a \pdv{u}{t} = 0
{{< /katex >}}

we had written the FTCS finite difference scheme:

{{< katex display >}}
u_j ^{n+1} = u_j ^n - \frac{a \Delta t}{2 \Delta x} \left( u_{j+1} ^n - u_{j-1} ^n \right)
{{< /katex >}}

We can add diffusion by replacing \\( u_j ^n \\) with a local spatial average, giving us the Lax algorithm:

{{< katex display >}}
u_j ^n \rightarrow \frac{u_{j+1} ^n + u_{j - 1} ^n}{2} \quad \text{Lax Algorithm}
{{< /katex >}}

If we apply the same von Neumann stability analysis as before, we find that

{{< katex display >}}
G = \sqrt{1 - \left[1 - \left(\frac{a \Delta t}{\Delta x}\right)^2 \right] \sin ^2 (k \Delta x)}
{{< /katex >}}
So we have a stable solution if
{{< katex display >}}
\left| \frac{a \Delta t}{\Delta x} \right| \leq 1 \quad \text{Courant condition}
{{< /katex >}}

This condition (also called the CFL condition) shows up quite a lot in fluid dynamics algorithms. It effectively limits the time step
{{< katex display >}}
\Delta t \leq \Delta x / a
{{< /katex >}}

If we carry the substitution through our finite difference equation, we can see how the Lax method really does add a diffusion term:

{{< katex display >}}
u_j ^{n+1} = \underbrace{u_j ^n - \frac{a \Delta t}{2 \Delta x} (u_{j+1} ^n - u_{j - 1} ^n)}_{\text{FTCS}} + \underbrace{\left( \frac{u_{j+1} ^n - 2 u_j ^n + u_{j-1} ^n}{2} \right)}_{\text{Lax modification}}
{{< /katex >}}

Manipulating the terms a bit,

{{< katex display >}}
\frac{u_j ^{n+1} - u_j ^n}{\Delta t} + a \left( \frac{u_{j+1} ^n - u_{j-1} ^n}{2 \Delta x} \right) = \frac{\Delta x^2}{2 \Delta t} \left( \frac{u_{j+1} ^n - 2 u_j ^n + u_{j-1} ^n}{\Delta x ^2} \right)
{{< /katex >}}

which approximates the PDE

{{< katex display >}}
\underbrace{\pdv{u}{t} + a \pdv{u}{x}}_{\text{original PDE}} = \underbrace{\frac{\Delta x ^2}{2 \Delta t} \pdv{^2 u}{x^2}}_{\text{diffusion term}}
{{< /katex >}}

In the limit of \\( \Delta x \rightarrow 0 \\) goes to zero, the diffusion term disappears and we recover the original PDE. It has the unfortunate property that the diffusion term grows as \\( \Delta t \rightarrow 0 \\), so we only retain accuracy as long as \\( \Delta x ^2 \\) goes to zero faster than \\( \Delta t \\).

### Lax-Wendroff Algorithm

Another algorithm known as the Lax-Wendroff algorithm can be less diffusive and is better behaved. It's also derived from a more mathematically rigorous method than the Lax method. We get it through a process called a Cauchy-Kowalevskaya method. 