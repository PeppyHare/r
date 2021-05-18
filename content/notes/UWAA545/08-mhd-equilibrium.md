---
title: MHD Equilibria
weight: 80
# bookToc: false
---

# Equilibrium Calculations

From physical expectations, elliptic equations result from equilibrium calculations and eigenvalue systems. In general, we can write elliptic equations as
{{< katex display >}}
\vec A \vec x = \vec b
{{< /katex >}}
where \\( \vec A \\) may be a nonlinear function of \\( \vec x \\). For example, if we think of Poisson's equation in 1D,
{{< katex display >}}
\dv{^2 \phi}{x^2} = - \rho_c
{{< /katex >}}
and apply finite differencing,
{{< katex display >}}
\frac{\phi_{j+1} - 2 \phi_j + \phi_{j-1}}{\Delta x^2} = - \rho_j
{{< /katex >}}
we get a matrix system
{{< katex display >}}
\vec A \vec x = \frac{1}{\Delta x^2} \begin{bmatrix} -2 & 1 & 0 & \ldots \\ 1 & -2 & 1 & \ldots \\ \ldots & \ldots & \ldots & \ldots \end{bmatrix} \begin{bmatrix} \phi_1 \\ \phi_2 \\ \ldots \end{bmatrix} = \vec b = - \begin{bmatrix} \rho_1 \\ \rho_2 \\ \ldots \end{bmatrix}
{{< /katex >}}
where \\( \vec A \\) is a J by J matrix. In equilibrium calculations, this comes up when solving the Grad-Shafranov equation

{{< katex display >}}
\Delta ^\star \psi = I I' - \mu_0 r^2 p'
{{< /katex >}}
where
{{< katex display >}}
I' = \pdv{I}{\psi} \qquad p' = \pdv{p}{\psi}
{{< /katex >}}
and
{{< katex display >}}
\Delta ^\star \equiv r \pdv{}{r} \frac{r}{r} \pdv{}{r} + \pdv{^2}{z^2}
{{< /katex >}}

The Grad-Shafranov equation is a nonlinear equation, and we often assume a power series expansion of the current density and pressure
{{< katex display >}}
I(\psi) = I_0 + I_1 \psi + I_2 \psi^2 + \ldots
{{< /katex >}}
{{< katex display >}}
p(\psi) = p_0 + p_1 \psi + p_2 \psi^2 + \ldots
{{< /katex >}}

For a force-free equilibrium (\\( p = 0 \\)) with a linear current profile 
{{< katex display >}}
I I' = I_0 I_1 + I_1 ^2 \psi
{{< /katex >}}

this makes the Grad-Shafranov equation a linear system.
{{< katex display >}}
\vec A = \Delta ^\star _{\text{FD}} + I_1 ^2
{{< /katex >}}
{{< katex display >}}
\vec x = \psi_{ij} \qquad \vec b = (I_0 I_1) _{ij}
{{< /katex >}}
where \\( \Delta ^\star _{\text{FD}} \\) is a finite difference representation of the \\( \Delta ^\star \\) operator. For a given geometry and poloidal current profile, \\( I_0 \\) and \\( I_1 \\), we can solve \\( \vec A \vec x = \vec b \\) to give \\( \psi(r, z) \\).

Solving \\( \vec A \vec x = \vec b \\) can be done using either direct or indirect (iterative) methods. Direct decomposition methods (like Kramer's rule, Gaussian decomposition) require \\( \mathcal{O}(N^3) \\) operations, where \\( N \\) is the size of the matrix. They also require full matrix storage, even though \\( \vec A \\) is a sparse (tridiagonal) matrix.

Iterative methods help solve this problem. We begin with a solution which is improved upon until we get convergence. If this converges in fewer operations than a full decomposition, then we've saved some time and a lot of in-memory storage space.

{{< katex display >}}
x^0 \rightarrow x^1 \rightarrow x^2 \rightarrow \ldots
{{< /katex >}}
{{< katex display >}}
\vec x^{n+1} = \vec x^n + \vec B^{-1} (\vec b - \vec A \vec x^n) \\
= \vec x^n + \vec B^{-1} \vec r^n
{{< /katex >}}

The technique boils down to a clever choice of \\( \vec B \\). We want to choose an approximation matrix \\( \vec B \\) which is very close to \\( \vec A \\), but is much easier to invert.
{{< katex display >}}
\vec B \approx \vec A
{{< /katex >}}
For this kind of iterative method, each iteration requires \\( \mathcal{O}(N) \\) operations, and converges in fewer than \\( N \\) iterations. The best iterative methods can converge in \\( \mathcal{O}(N \ln N) \\) total operations.

# Linear Stability

When we studied plasma waves at the beginning of this course, we performed a linearization of the Vlasov equation about an equilibrium state. This is how we got dispersion relations for waves. We assumed an equilibrium of a uniform plasma, with at most static magnetic fields. For more interesting equilibria with nonzero gradients, we follow the same procedure.

First, we linearize the ideal MHD equations about a static equilibrium (\\( \vec v_0 = 0 \\))
{{< katex display >}}
\pdv{\rho_1}{t} = - \div (\rho_0 \vec v_1)
{{< /katex >}}
{{< katex display >}}
\pdv{p_1}{t} = - \div (p_0 \vec v_1) + (1 - \Gamma) p_0 \div \vec v_1
{{< /katex >}}
{{< katex display >}}
\pdv{\vec B_1}{t} = \curl (\vec v_1 \cross \vec B_0)
{{< /katex >}}
{{< katex display >}}
\rho _0 \pdv{\vec v_1}{t} + \frac{1}{\mu_0} \left[(\curl \vec B_1) \cross \vec B_0 + (\curl \vec B_0) \cross \vec B_1 \right]
{{< /katex >}}

Given an equilibrium (\\( \rho_0 \\), \\( p_0 \\), \\( \vec B_0 \\)), the linearized MHD equations can be integrated in time to evolve \\( \rho_1 \\), \\( p_1 \\), \\( \vec B_1 \\), \\( \vec v_1 \\). If we do this and \\( \vec v_1 \\) grows in time, then the plasma is unstable.

Notice that \\( \rho_1 \\) decouples from the other equations, so we don't need to evolve it if we don't want to, or we can evolve it in parallel.

It's often more useful to study individual modes. We can assume a form of the perturbation to select specific modes. For arbitrary perturbed quantity \\( g_1 \\),

{{< katex display >}}
g_1(\vec r, t) = g_1(r, \theta, z, t) = \hat g_1  (r, z, t) e^{i m \theta}
{{< /katex >}}

where \\( m \\) is the azimuthal mode number. As we've written it, \\( g_1 \\) is complex-valued, but only because \\( e^{i m \theta} \\) is a convenient representation of a Fourier mode. We're only interested in the real component.

{{< katex display >}}
\text{Re}(g_1) \leftrightarrow g_1(\theta = 0)
{{< /katex >}}
{{< katex display >}}
\text{Im}(g_1) \leftrightarrow g_1(\theta = - m \pi / 2)
{{< /katex >}}

### Example: Spheromak Tilt m=1

As an example, we consider the \\( m=1 \\) tilt mode in the spheromak, a device which consists of a toroidal equilibrium contained in a cylindrical can. The tilt mode, corresponding to \\( m=1 \\), rotates the equilibrium in the \\( r-z \\) plane. The elongation ratio \\( L/R \\) determines the configuration's stability against the tilt mode.

<p align="center"> <img alt="45.png" src="/r/img/545/45.png" /> </p>