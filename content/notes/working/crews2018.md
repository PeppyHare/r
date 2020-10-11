---
title: "Crews (2018)"
bookToc: false
---

# Development of a Collisionless Plasma Kinetic Solver and an Investigation of One-Dimensional Plasma Waves and Instabilities

Shielded potential of a test electron:

{{< katex display >}}
\phi(r) = \frac{-e}{4 \pi \epsilon_0 r} e ^{- r / \lambda_D}
{{< /katex >}}

where the Debye length is {{< katex >}} \lambda_D = \sqrt{\frac{\epsilon_0 T_e}{ n_e e}} {{< /katex >}}. The mean free path between large-angle collisions is estimated as

{{< katex display >}}
\lambda_{mfp} \sim \frac{\epsilon_0 T_e ^2}{\phi_e n_e \log ( \Lambda)}
{{< /katex >}}
where {{< katex >}}\phi_e = e^2 / 4 \pi \epsilon_0{{< /katex >}} are the constants from the Coulomb force law.

Smooth out the discreteness of particles via spatial average over small volumes:

{{< katex display >}}
\rho \rightarrow \langle \rho_c \rangle \qquad \vec E \rightarrow \langle \vec E \rangle + \delta \vec E
{{< /katex >}}

The mean field {{< katex >}}\langle \vec E \rangle{{< /katex >}} is responsible for collective modes of plasma motion. Estimate the collisionality of the plasma by comparing the length scales {{< katex >}}\lambda_{mfp} / \lambda_D{{< /katex >}}

{{< katex display >}}
\frac{\lambda_{mfp}}{\lambda_D} \sim \frac{T_e ^{3/2}}{n_e ^{1/2}}
{{< /katex >}}

Plasma is seen to become collisionless as the temperature becomes high or the plasma becomes more rarified.

## Phase space mechanics

To arrive at a kinetic equation governing the collisionless mechanics, consider the one-dimensional motion of a single particle

{{< katex display >}}
\dot{x} = v \qquad \dot v = F(x)
{{< /katex >}}

and define the phase space coordinates as {{< katex >}}\vec{\dot r} = \vec F \equiv [ v, F(x) ]{{< /katex >}}. The flux vector is similar to the velocity field of a fluid flow. The streamlines of {{< katex >}}\vec F{{< /katex >}} are the streamlines which a particle will follow if the flux is constant in time. Phase flow is always analogous to that of an incompressible fluid because the flux divergence is zero:

{{< katex display >}}
\div [v, F(x)] = \pdv{v}{x} + \pdv{F(x)}{v}
{{< /katex >}}

If the phase fluid density is given by a function {{< katex >}}f(x, v, t){{< /katex >}} where {{< katex >}}t{{< /katex >}} is the time parameter, because any instantiation of a particle can not leave the phase plane, the probability density will be conserved. We can write a conservation law:

{{< katex display >}}
\pdv{f(x, v, t)}{t} = - \div ( f (x, v, t) \vec F)
{{< /katex >}}

and due to the flow's incompressibility

{{< katex display >}}
\div (f \vec F) = f ( \div \vec F) + \vec F \cdot \grad f = \vec F \cdot \grad f \\
\rightarrow \pdv{f}{t} = - \left[ v, F(x) \right] \cdot \left[ \pdv{f}{x}, \pdv{f}{v} \right] \\
\rightarrow \pdv{f}{t} + v \pdv{f}{x} + F(x) \pdv{f}{v} = 0
{{< /katex >}}

the probability density \\( f \\) satisfies a simple advection equation in the phase space.

## Vlasov Equation

Beginning from the probability density kinetic equation, one can arrive at the Boltzmann equation for the ensemble-averaged velocity distribution function \\( f(\vec x, \vec v, t) \\) of a gas or plasma

{{< katex display >}}
\pdv{f}{t} + \vec v \cdot \grad_x f + \frac{1}{m} \vec F \cdot \grad_v f = C(f)
{{< /katex >}}

where \\( C(f) \\) is in general an integral operator representing inter-particle correlations. We arrive at the Vlasov-Poisson system of equations if we entirely neglect correlations and only consider the electrostatic potential. Restricted to a single spatial dimension, it has the form

{{< katex display >}}
\pdv{f _ \alpha}{t} + v \pdv{f  _ \alpha}{x} - \frac{Z _ \alpha}{m _ \alpha} \pdv{\phi}{x} \pdv{f _ \alpha}{v} = 0 \\
\dv{ ^2 \phi}{x^2} = - \frac{1}{\epsilon_0} \sum_\alpha Z_\alpha \int_{-\infty} ^\infty f _ \alpha(x, v, t) \dd v
{{< /katex >}}

The most striking difference between the dynamics of neutral fluids and a collisionless plasma is the appearance of non-equilibrium velocity distributions in plasma as a result of collective behavior. The collision operator enforces local thermodynamic equilibrium, driving the velocity distribution to Maxwellian.

{{< katex display >}}
f(x, v) = n(x) \sqrt{ \frac{1}{2 \pi v_{th} ^2 (x) }} \exp \left( - \frac{(v - u(x))^2}{2 v_{th}^2 (x)} \right)
{{< /katex >}}

where
{{< katex display >}}
n(x) = \int_{-\infty} ^\infty f(x, v, t) \\
u(x) = \frac{1}{n(x)} \int_{-\infty} ^\infty v f(x, v, t) \dd v \\
v_{th} ^2 (x) = \frac{1}{n(x)} \int_{-\infty} ^\infty (v - u(x))^2 f(x, v, t) \dd v
{{< /katex >}}

In absence of collisions, there is no driver for the velocity distribution to posess normal statistics. The structure of the distribution function within the phase space is generated through wave-particle resonance, where the waves with phase velocity \\( v_{ph} = \omega / k \\) resonate with particles traveling at the same velocity. This process is Landau resonance. 


---