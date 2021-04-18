---
title: Particle in Cell Model
weight: 30
# bookToc: false
---

# Particle-In-Cell Model (Particle model revisited)

The order of magnitude issues with the N-body model prevent a direct application in even simple laboratory plasmas. In a plasma with \\( N = O(10^{21}) \\), we have interactions on the order of \\( O(10^{42}) \\) making direct computation completely impractical.

We can instead use representative particles with the same charge to mass ratio, but fewer (\\( N = 10^3 \sim 10^7 \\)) particles. The governing equations for such a model look very similar to the N-body model:

{{< katex display >}}
\dv{\vec v_i}{t} = \left( \frac{q}{m} \right)_i (\vec E + \vec v_i \cross \vec B) + \sum_{j \neq i} \left. \dv{\vec v_{ij}}{t} \right|_{coll} \delta (\vec r_i - \vec r_j)
{{< /katex >}}
{{< katex display >}}
\dv{\vec r_i}{t} = \vec v_i
{{< /katex >}}

These hold for each superparticle \\( i \\). We can track the position and velocity in time \\( (\vec r, \vec v)_i \\) of each superparticle \\( i \\). The physical properties of superparticle \\( i \\) will be:

{{< katex display >}}
m_i = m_\alpha \frac{N_{plasma}}{N_{model}} \qquad \alpha = \text{ion, electron, ...}
{{< /katex >}}

{{< katex display >}}
q_i = q_\alpha \frac{N_{plasma}}{N_{model}}
{{< /katex >}}

{{< katex display >}}
n_i = n_\alpha \frac{N_{model}}{N_{plasma}}
{{< /katex >}}

Since \\( q_i / m_i = q_\alpha / m_\alpha \\), the collisionless dynamics will be preserved for the same \\( \vec E \\) and \\( \vec B \\). Provided a sufficiently large number of superparticles (adequate statistics), this means we can use this heavily reduced model to capture the entire behavior of the plasma.

Let's compute some plasma parameters for this "undersampled" system.

{{< katex display >}}
\omega_p = \sqrt{\frac{n_\alpha q_\alpha ^2}{\epsilon_0 m_\alpha}} = \sqrt{\frac{n_i q_i ^2}{\epsilon_0 m_i}}
{{< /katex >}}

We find that the plasma frequency remains the same for the sampled system. The cyclotron frequency is also preserved for the physical system.

{{< katex display >}}
\omega_c = \frac{q_\alpha B}{m_\alpha} = \frac{q_i B}{m_i}
{{< /katex >}}

However, if we look at the Debye length, we see that it changes

{{< katex display >}}
\lambda_D = \frac{v_{th}}{\omega_p} = \sqrt{\frac{\epsilon_0 k T_\alpha}{n_\alpha q_\alpha ^2}} = {\sqrt{\frac{\epsilon_0 k T_i}{n_i q_i ^2}}} \sqrt{\frac{N_{model}}{N_{plasma}}}
{{< /katex >}}

This difference will have important implications on the spatial scales and resolution of the model. The coupling to the Maxwell's equations is accomplished as we did in the N-body model.

There are two outstanding issues that we need to address before we can move on to computation:

- Singularities. The Coulomb force between two charged particles approaches \\( \infty \\) as \\( r \rightarrow 0 \\).
- Large number of interactions. Even with fewer particles, \\( O(10^7) \\), there are still \\( N^2 \\) particle-particle interactions at all times. \\( O(10^{14}) \\) interactions is still not really practical to compute.

To deal with singularities, we can use finite-size particles, with their properties diffusely distributed throughout their volume. When these particle "clouds" begin to overlap, the overlapping volumes cancel each other, and when the particles overlap entirely (\\( r = 0 \\)), the force is zero

<p align="center"> <img alt="3.png" src="/r/img/545/3.png" /> </p>

The same technique is used in hydrodynamics in a model called SPH (smooth particle hydrodynamics). SPH techniques are used quite often for hypervelocity impacts, like asteroids striking a planet. An interesting application of SPH is the brasil nut problem: why do brasil nuts end up at the top of a can of mixed nuts? As it turns out, if we model simple normal collisions in a can of particles of varying sizes, we don't see the effect at all. However, if we introduce friction between particles then the effect does show up, so we can deduce that the surface area to volume ratio of the brasil nut is important.

Using SPH in a plasma is more complicated, because plasma particles interact with every other particle through long range EM forces. We can no longer limit interactions locally in a plasma. Instead, to limit the number of interactions, we use a spatial grid to integrate the EM forces. Electromagnetic sources from each particle \\( i \\) are assigned to a spatial grid node \\( j \\)

<p align="center"> <img alt="4.png" src="/r/img/545/4.png" /> </p>

Then, \\( \vec E \\) and \\( \vec B \\) are computed on the grid based on \\( \rho_j \\) and \\( \vec j _j \\) to give \\( (\vec E, \vec B)_j \\). Then, particle positions and velocities are evolved using \\( (\vec E, \vec B)_j \\) to compute local forces on each particle.

The computational time required to compute the fields depends on the number of grid points, \\( M \\). At each time step, this requires \\( O(M^2) \\) operations. The computational time required to compute assign particles positions and velocities to the grid and compute forces on each particle is \\( O(N) \\). This makes the total compute time \\( O(M^2 + \alpha N) \ll N^2 \\)

### Relationship to N-Body and Kinetic Models

PIC is similar to the N-body model in some obvious ways:
  - The plasma is treated as discrete particles that interact through EM fields
  - Same governing equations, only with fewer particles

However, the EM fields are computed by currents and charges localized to a spatial grid. This is an important distinction. It is what removes the n-body interactions from the model.

By comparison to the kinetic model, kinetic models are derived by performing an ensemble average to transform from discrete space to a smooth, continuous space. The averaging process accounts for smoothly varying long-range forces, which is just what we've done by mapping our particles to a spatial grid. The short-range abrupt forces are encompassed in the collision operator in the same way. The same idea of separating the smooth long-range forces from the abrupt forces was the key Vlasov insight. As we arbitrarily crank up the spatial resolution, the PIC model converges not to the N-body model, but to the Vlasov kinetic model.

PIC models are "particle ensemble averages," but not in a strict sense. They can be thought of as a sampling or discretization of the continuous phase space.

## General Comments on Kinetic Models

- The PIC method is a robust and efficient method for collisionless plasmas. Collisions are usually modeled using Monte Carlo methods.
- PIC does not work well when the physics is dominated by a small population (small number of particles), because the sampling error becomes very significant.
- PIC methods work well for handling vacuum boundaries, but physical boundaries are more difficult. This is the opposite of the case for fluid models.
- PIC methods naturally resolve sharp features in phase space, e.g. a cold beam
- Continuum kinetic methods can require more computational effort. PIC methods have been around since the 60's, but continuum models have only become computationally practical more recently. There are a couple of reasons for this. Dimensionality is a key component. Continuum distribution methods encompass a six-dimensional space, but particle methods can work in three-dimensional spaces. Additionally, solving the governing equations Boltzmann, Vlasov, Vlasov + Fokker-Planck, etc. are more complicated than the equation of motion for the PIC method.
- Continuum methods better model tails of distributions, which is often where interesting physics happens. E.g ionization, fusion are driven by the high energy tail of the distribution, while the overall dynamics are determined by the bulk. If tails are not interesting, then computational effort is wasted on large unoccupied regions of phase space. Tails also constrain the numerical solution for continuum methods. High velocity and low density can lead to oscillations where the value of the distribution function is very small, leading to potentially negative values.
- Continuum methods (more generally fluid methods) can introduce numerical diffusion and dispersion.
  - Diffusion leads to a smoothing of sharp features over time.
  - Dispersion leads to low/high wavenumber features propagating at the wrong speed.

## Computational Methods for PIC

- PIC can easily be extended to include relativistic effects, only requiring minimal changes to the equation of motion.
- Collisions are often neglected in PIC methods, assuming a low density, collisionless plasma. As we try to apply PIC methods to collisional plasmas, the accuracy gets worse.

Let's talk about how we go about solving the governing equations for a plasma. First, we divide the domain into a _uniform_ grid, \\( \Delta x = \Delta y = \Delta z = const. \\). We will have a distribution of particles throughout the domain with independent position and velocity \\( (\vec x, \vec v)_i \\).

<p align="center"> <img alt="5.png" src="/r/img/545/5.png" /> </p>

The geometry of the particles themselves depends on dimensionality.
  - Particles have an infinite extent in unresolved dimensions. In 3D, this means that particles are spheres. In 2D they are cylindrical, and in 1D they are planar.

The general procedure for solving the PIC method goes like this:

1. Particles are weighted to the grid. The position of each particle \\( i \\) in phase space \\( (\vec x, \vec v)_i \\) is weighted to the grid to compute the electromagnetic source terms \\( (\rho_c, \vec j)_j \\) at each grid location \\( j \\).
{{< katex display >}}
\underbrace{(\vec x, \vec v)_i}_{\text{particles}} \rightarrow \underbrace{(\rho_c, \vec j)_j}_{\text{grid}} \qquad \text{(Particle weighting)}
{{< /katex >}}
2. Advance the electric and magnetic fields on the grid
{{< katex display >}}
\underbrace{(\rho_c, \vec j)_j}_{\text{grid}} \rightarrow \underbrace{(\vec E, \vec B)_j}_{\text{grid}} \qquad \text{(Field solve)}
{{< /katex >}}
3. Electromagnetic fields are weighted to particles
{{< katex display >}}
\underbrace{(\vec E, \vec B)_j}_{\text{grid}} \rightarrow \underbrace{\vec F_i}_{\text{particle}} \qquad \text{(Force weighting)}
{{< /katex >}}
4. Particles are advanced in time
{{< katex display >}}
\vec F_i \rightarrow \vec v_i \rightarrow \vec x_i
{{< /katex >}}

## Particle & Force Weighting

As mentioned earlier, PIC uses finite size particles rather than point particles to avoid the issue of force singularities. This is particularly important in the 1-dimensional case, since infinitesimal particles would never be able to exchange positions. _The exact size and shape of the particles matter_. The charge density for a point particle is

{{< katex display >}}
\rho_c(\vec r) = q_i \delta (\vec r - \vec r_i)
{{< /katex >}}

For a finite-size particle,

{{< katex display >}}
\rho_c (\vec r) = q_i S(\vec r - \vec r_i)
{{< /katex >}}

where \\( S \\) is a particle shape factor. Conservation of charge requires
{{< katex display >}}
\int S(\vec r - \vec r_i) \dd \vec r = \int \delta ( \vec r - \vec r _i) \dd \vec r = 1
{{< /katex >}}

The Lorentz force must be weighted to the particles using the same shape factor in order to get consistent dynamics. For \\( \vec B = 0 \\),
{{< katex display >}}
\vec F_i = q_i \vec E (\vec r_i) = \overbrace{q_i \int \vec E(\vec r) \delta (\vec r - \vec r_i) \dd \vec r}^{\text{point particles}} \\
= \underbrace{q_i \int \vec E(\vec r) S(\vec r - \vec r_i) \dd \vec r}_{\text{finite-size particles}}
{{< /katex >}}

Particles must have local support, meaning \\( S(\vec r - \vec r_i) \\) is spatially restricted to a small portion of the grid. The simplest weighting/shape is a uniform charge cloud. In 1D, this is

{{< katex display >}}
S(x) = \begin{cases}  1/a_0 &\qquad & \text{if} \quad |x| \leq a_0 /2 \\
0 &\qquad & \text{otherwise}
\end{cases}
{{< /katex >}}

This provides zeroth-order weighting to the nearest grid point (NGP). When we go to compute the fields from our source terms, the particle will only contribute to the closest single grid point.

If the size of our particle is very small compared to the grid spacing \\( \Delta x > a_0 \\), what happens to \\( \rho_c \\) as the particle drifts through the grid? Because we compute the weighted density as \\( \rho_c (\vec r) = q_i S(\vec r - \vec r_i) \\), there will be some positions for which a particle will not contribute to any grid point. Likewise, if \\( \Delta x < a_0> \\), then the particle appears on multiple grid points, but only at some times, producing double-counting. Both of these cases violate conservation of charge:

{{< katex display >}}
\pdv{}{t} \int q_\alpha f_\alpha \dd \vec x \dd \vec v = 0
{{< /katex >}}

To conserve charge, **\\( \Delta x \\) must equal \\( a_0 \\)**. This is a limitation of zeroth-order weighting.

Even if we have \\( \Delta x = a_0 \\), nearest grid point still produced particles that appear and disappear on the grid instantaneously, but at least they appear/disappear in a way that conserves total charge. The resulting charge distribution is noisy as a result, hinting at a general issue with PIC methods. The noise introduced by weighting charge distribution to a grid is addressed by using many particles, \\( N \gg M \\). Typically, we'll use \\( N \sim M^2 \\).

The nearest grid point weighting can be improved to 1st order, using a linear \\( S(x) \\).

<p align="center"> <img alt="6.png" src="/r/img/545/6.png" /> </p>

We maintain the important property \\( \int S(x) \dd x = 1 \\). Using \\( a_0 = \Delta x \\) so that

{{< katex display >}}
\sum_j S(x_j - x) = 1
{{< /katex >}}

for any \\( x \\). The resulting charge density after weighting looks like this:

<p align="center"> <img alt="7.png" src="/r/img/545/7.png" /> </p>

{{< katex display >}}
\rho_j = q_i \frac{x_{j+1} - x_i}{\Delta x} \qquad \rho_{j+1} = q_i \frac{x_i - x_j}{\Delta x}
{{< /katex >}}

The same weighting strategy extends to multiple dimensions. In 2D, this is bilinear weighting; in 3D we have trilinear. 1st order weighting requires more computational effort than nearest grid point, but produces smoother fields. The instantaneous appearance/disappearance of particles as they move across the grid is now gone, leading to a smoother electric field. This is the typical PIC weighting method. Higher-order weightings further reduce noise, but with dramatically increased computational expense. For example, a second-order scheme might be

{{< katex display >}}
S_2( x_j - x) = \frac{3}{4} - \left( \frac{x - x_j}{\Delta x} \right)^2
{{< /katex >}}
{{< katex display >}}
S_2(x_{j \pm 1} - x) = \frac{1}{2} \left( \frac{1}{2} \pm \frac{x - x_j}{\Delta x} \right) ^2
{{< /katex >}}

All shape functions must satisfy conservation of charge \\( \sum_j S(x_j - x) = 1 \\) for any \\( x \\). But they must also preserve the first moment

{{< katex display >}}
\sum_j x_j S(x_j - x) = x
{{< /katex >}}

to preserve the electric dipole moment. And, of course, we require \\( S(x) \geq 0 \\) everywhere. This last requirement will trip up higher order methods if we naively use Lagrange interpolation functions. Instead, we can construct higher orders by using functions defined by convolutions of lower order shapes.

{{< katex display >}}
\begin{aligned}
m = 1 & \qquad & S _{NGP} \star S_{NGP} = \int S_0(x') S_0 (x - x') \dd x' = S_1(x) \\
m = 2 & \qquad & S_1 \star S_{NGP} = S_x(x)
\end{aligned}
{{< /katex >}}

As you go to higher and higher order, \\( S_m(x) \\) approaches a Gaussian.

Let us consider, does the particle shape affect the field distribution? What about the force distribution? Consider a uniform, finite-size ion and an infinitesimal electron (sheet), such that \\( q_i + q_e = 0 \\).

{{< katex display >}}
\int e n_i \dd x + \rho _s = 0
{{< /katex >}}

From Gauss's law,

{{< katex display >}}
\dv{E_x}{x} = \frac{\rho_c}{\epsilon_0}
{{< /katex >}}

with \\( E_x = 0 \\) outside. Solving Gauss's law, we find an electric field like this:

<p align="center"> <img alt="8.png" src="/r/img/545/8.png" /> </p>

From this, we conclude that outside of the particle extent, the field is independent of the particle shape. If we consider a charge sheet with an arbitrary shape \\( \rho_c(x) \\) in an electric field, bounded between \\( x = a, x = b \\), the force on the sheet is

{{< katex display >}}
F = \int_a ^b \rho_c (x) E_x \dd x = \int_a ^b \frac{\epsilon_0}{2} \dv{}{x} (E_x ^2) \dd x \\
= \frac{\epsilon_0}{2} (E_b ^2 - E_a ^2) = \epsilon_0 (E_b - E_a) \left( \frac{E_b + E_a}{2} \right) = \epsilon_0 \Delta E \overline{E} = q \overline{E}
{{< /katex >}}

The particle shape does not affect the physics outside of the particle shape. The force on the particle is only determined by the average electric field.

## Particle Push

Once the source terms have been weighted to the grid, we wish to advance particles' position and velocity based on the Lorentz force.

{{< katex display >}}
m \dv{\vec v}{t} = \vec F \\
\dv{\vec x}{t} = \vec v
{{< /katex >}}

We could solve these using any time integration technique, e.g. Runge-Kutta. But instead, we are going to choose a leap-frog method. It requires the fewest operations for the same order of accuracy (2nd order) and is a symplectic integrator, which means that it is a canonical transformation from one time to another time. Canonical transformations have important conservation properties; symplectic integrators conserve integrators, and are reversible in time.

To push the particles, we will use finite difference operators to approximate the ODEs.

{{< katex display >}}
m \frac{\vec v^{new} - \vec v^{old}}{\Delta t} = \langle \vec F \rangle \\
\frac{\vec x^{new} - \vec x^{old}}{\Delta t} = \langle \vec v \rangle
{{< /katex >}}

The averaging treatment we use to get the RHS determines the numerical accuracy and stability of the scheme.

{{< katex display >}}
\vec v^{new} = \vec v^{old} + \frac{\Delta t \langle F \rangle}{m} \\
\vec x^{new} = \vec x^{old} + \Delta t \langle \vec v \rangle
{{< /katex >}}

Here is where the leap-frog method comes in. We will center the right-hand side in time to get a 2nd order accuracy. By off-setting the velocity and position calculations, we get the average velocity we need for the centered leap-frog:

<p align="center"> <img alt="9.png" src="/r/img/545/9.png" /> </p>

To properly center the force, \\( \vec E \\) and \\( \vec B \\) must be expressed at the same points as position. They are then used to compute the next velocity \\( v(n+1/2) \\), from which we advance the position.

Leap-frog is second order accurate, but can be dispersive. This will give us incorrect wave speeds/frequencies/phase, but correct magnitude. Consider an electrostatic harmonic oscillator (Langmuir oscillations). For a charged particle oscillating around a fixed particle,

{{< katex display >}}
\frac{v^{n + 1/2} - v^{n-1/2}}{\Delta t} = \frac{q}{m} E(x^n)
{{< /katex >}}
{{< katex display >}}
\frac{x^{n+1} - x^n}{\Delta t} = v^{n+1/2} \qquad \text{ and } \qquad \frac{x^n - x^{n-1}}{\Delta t} = v^{n-1/2}
{{< /katex >}}

Gauss's law gives

{{< katex display >}}
\dv{E}{x} = \frac{q n }{\epsilon_0} \rightarrow E(x^n) = \frac{q n }{\epsilon_0} x^n
{{< /katex >}}

Combine to give

{{< katex display >}}
\frac{x^{n+1} - 2 x^n + x ^{n-1}}{\Delta t^2} = \frac{q}{m} E(x^n) = - \frac{q^2 n}{m \epsilon_0} x^n = - \omega_p ^2 x^n
{{< /katex >}}

This equation approximates the ODE for Langmuir oscillations

{{< katex display >}}
\dv{^2 x}{t^2} + \omega_p ^2 x = 0
{{< /katex >}}

which has the solution

{{< katex display >}}
x(t) = C e^{\pm i \omega_p t}
{{< /katex >}}

That's the same finite difference we're using for our leap-frog particle push, which indicates that we're solving the same differential equation. We can assume an oscillating solution to our finite difference equation where

{{< katex display >}}
x^n = c e^{i \omega t^n}
{{< /katex >}}

where \\( t^n = n \Delta t \\). Substituting \\( x^n \\) into the finite difference expression,
{{< katex display >}}
e^{i \omega \Delta t} - 2 + e^{- i \omega \Delta t} = - \omega _p ^2 \Delta t^2
{{< /katex >}}

Some algebraic manipulation leads to

{{< katex display >}}
2\left( \frac{e^{i \omega \Delta t} + e^{- i \omega \Delta t}}{2} - 1 \right) = - \omega_p ^2 \Delta t^2 \\
2 \left( \cos (\omega \Delta t) - 1 \right) = - \omega _p ^2 \Delta t^2\\
\sin ^2 \left( \frac{\omega \Delta t}{2} \right) = \left( \frac{\omega _p \Delta t}{2} \right)^2
{{< /katex >}}

That's interesting. We should have a solution \\( \omega = \pm \omega_p \\), but instead we have this other solution. Plotting \\( (\omega \Delta t / 2) \\) vs \\( (\omega_p \Delta t / 2) \\), we get a plot like this:

<p align="center"> <img alt="10.png" src="/r/img/545/10.png" /> </p>

The deviation from \\( \omega = \omega_p \\) is what's called a phase error. Nominally, we can set \\( \Delta t \\) to whatever we want. Setting \\( \Delta t \\) further out gives an imaginary \\( \omega = \pm i \gamma \\), so

{{< katex display >}}
x = c e^{\gamma t}
{{< /katex >}}

which is an unstable solution. So, if \\( \Delta t \\) is small, the leap frog finite difference gives an accurate solution. Increasing \\( \Delta t \\) enters a region where phase errors become large. Going all the way up to \\( \Delta t = 2/\omega_p \\), we get imaginary solutions to the differential equation and the solution becomes unstable. This is the **Leap-frog instability.**

## Electromagnetic Field Solver

At the field solver step, we need to advance \\( \vec E \\) and \\( \vec B \\) according to Maxwell's equations based on particles' positions and velocities.

In the **electrostatic** case, Faraday's law reduces to
{{< katex display >}}
\curl \vec E = 0 \rightarrow \vec E = - \grad \phi
{{< /katex >}}

Combined with Gauss's law, yields Poisson's equation

{{< katex display >}}
\div \vec E = \rho_c / \epsilon_0 \rightarrow \grad ^2 \phi = - \rho_c / \epsilon_0
{{< /katex >}}

Poisson's equation can be solved with finite differences. In 1D,

{{< katex display >}}
\frac{\phi _{j+1} - 2 \phi_j + \phi_{j-1}}{\Delta x^2} = - \frac{\rho_j}{\epsilon_0}
{{< /katex >}}

In matrix form, this yields a tridiagonal matrix equation.

{{< katex display >}}
\vec A \vec \phi = \vec b \rightarrow \vec \phi = \vec A ^{-1} \vec b
{{< /katex >}}

where

{{< katex display >}}
\vec \phi = \begin{bmatrix}
\phi_1 \\
\phi_2 \\
\vdots \\
\phi_J
\end{bmatrix}
{{< /katex >}}

{{< katex display >}}
\vec A = \frac{1}{\Delta x^2} \begin{bmatrix} \ldots & 1 & -2 & 1 & \ldots \end{bmatrix}
{{< /katex >}}

{{< katex display >}}
\vec b = \begin{bmatrix} - \rho_{j-1} / \epsilon_0 \\
- \rho_j / \epsilon_0 \\
\rho_{j+1} / \epsilon_0 \\
\ldots
\end{bmatrix}
{{< /katex >}}

We can run into some trouble here with periodic domains. For a periodic boundary condition, \\( \vec A \\) looks like


{{< katex display >}}
\vec A \sim \begin{bmatrix}
-2 & 1 & 0 & \\
1 & -2 & 1 & \\
\ldots & \ldots & \ldots & \ldots \\
\ldots & 1 & -2 & 1 \\
1 & \ldots & 1 & -2 \\
\end{bmatrix}
{{< /katex >}}

which is singular. This problem arises from a lack of appropriate boundary conditions. Even with periodic boundary conditions, we know the solution \\( \phi \\) is lacking an appropriate gauge, e.g. \\( \phi_1 = 0 \\) or \\( \sum_j \phi_j = 0 \\). Setting \\( \phi_1 = 0 \\) modifies \\( \vec A \\):

{{< katex display >}}
\vec A \sim \begin{bmatrix}
1 & 0 & 0 & \\
1 & -2 & 1 & \\
\ldots & \ldots & \ldots & \ldots \\
\ldots & 1 & -2 & 1 \\
1 & \ldots & 1 & -2 \\
\end{bmatrix}
{{< /katex >}}

This is no longer singular, and we can invert it.

With \\( \phi_j \\) in hand, we compute the electric field as

{{< katex display >}}
E_{x_{j}} = - \frac{\phi_{j+1} - \phi_{j-1}}{2 \Delta x}
{{< /katex >}}

and solve the Vlasov-Poisson system.

### Periodic Domains - Fourier Series Expansion

For periodic domains, an alternative approach to solving Poisson's equation has some unique advantages compared to the finite difference method. In this approach, we transform from a discrete physical space to Fourier wave space. In wave space, differential operators become multiplications.

{{< katex display >}}
\rho(x) \overbrace{\rightarrow}^{FT} \rho(k)
{{< /katex >}}

using the transformation kernel \\( e^{i k x} \\). Poisson's equation becomes

{{< katex display >}}
k ^2 \phi (k) = \rho(k) / \epsilon_0 \rightarrow \phi(k) = \frac{\rho(k)}{\epsilon_0 k^2}
{{< /katex >}}

With the potential, an inverse fourier transform gives \\( \phi(k) \rightarrow \phi(x) \\). We can get the field either by computing the gradient

{{< katex display >}}
- \grad \phi(x) = \vec E(x)
{{< /katex >}}

or by computing the gradient first in phase space

{{< katex display >}}
i k \phi(k) = \vec E(k) \rightarrow \vec E(x)
{{< /katex >}}

We have a finite number of locations on our grid, so likewise our Fourier series expansion is also truncated at a finite \\( k \\).

{{< katex display >}}
g(k) = \Delta x \sum_{j=0} ^{J-1} g(x_j) e^{-i k x_j}
{{< /katex >}}

The continuous inverse transform is

{{< katex display >}}
g(x_j) = \frac{1}{2\pi} \int_{- \pi / \Delta x} ^{\pi / \Delta x} g(k) e^{i k x_j} \dd k \qquad \text{(infinite k)}
{{< /katex >}}

but for a discrete number of modes \\( k \\),

{{< katex display >}}
g(x_j) = \frac{1}{L} \sum_{n=-J/2} ^{J/2 - 1} g(k) e^{i k x_j}
{{< /katex >}}

where \\( k = 2 \pi n / L \\).

Finite Fourier transformations (FFT) are susceptible to **aliasing** errors. Higher wave numbers than we can resolve are aliased to lower frequencies.

{{< katex display >}}
E(k) = - i k \phi(k) \frac{\sin(k \Delta x)}{k \Delta x} = - i \kappa \phi(k)
{{< /katex >}}

{{< katex display >}}
\phi(k) = \frac{\rho(k)}{\epsilon_0 k^2} \left[ \frac{k \Delta x}{\sin (k \Delta x)}\right]^2 = \frac{\rho(k)}{\epsilon_0 \kappa ^2}
{{< /katex >}}

The discrete effects vanish as \\( k \Delta x \rightarrow 0 \\) (infinite resolution). Aliasing occurs if \\( |k \Delta x| > \pi \\) which appears on the grid as lower values of \\( k \Delta x \\).


## Full Electrostatic PIC Algorithm

Now we've got everything we need to implement an electrostatic PIC model.

- Particle weighting to the grid using shape function (\\( \vec j \\) is not needed for electrostatics)
  {{< katex display >}}
  x_i \rightarrow \rho_j
  {{< /katex >}}
- Electric field solve from Poisson's equation.
  - Finite difference:
  {{< katex display >}}
  \grad ^2 \phi = - \rho / \epsilon_0 \rightarrow \vec E = - \grad \phi
  {{< /katex >}}
  - or FFT:
  {{< katex display >}}
  \rho(x_j) \overbrace{\rightarrow}^{FFT} \rho(k) \overbrace{\rightarrow}^{k^2} \phi(k) \overbrace{\rightarrow}^{k} \vec E(k) \overbrace{\rightarrow}^{IFFT} E(x_j)
  {{< /katex >}}
- Force weighting to particles using shape function
  {{< katex display >}}
   \vec E_j \rightarrow \vec F_i
  {{< /katex >}}
- Leap frog advance to push the particles
  {{< katex display >}}
  \vec F_i \rightarrow \vec v_i \rightarrow \vec x_i
  {{< /katex >}}