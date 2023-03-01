---
title: Fluid Models for Plasmas
weight: 60
# bookToc: false
---

{{< katex display >}}

{{< /katex >}}

# Fluid Models for Plasmas

## Motivation for Fluid Models

Up to this point, we've been discussing particle models, and in particular, kinetic descriptions in which we've sampled the distribution function at particular locations to get our particles. We retained detailed information about the distribution function by tracking the positions and velocities of these representative super-particles, which should continue to "represent" the sampled distribution function at all points in time. Tracking this detailed information is computationally expensive, so PIC is limited to small spatial scale or short time scale phenomena. Non-linear waves and wave-plasma interactions are good examples of PIC use cases.

Applying 3D kinetic models to a confined plasma, for example, stretches beyond the current state of the art. This desire motivates the use of reduced models. Fluid models are examples of reduced models.

Other courses (like the course under the "MHD Theory" section of these notes) go into much more detail on fluid models, so this section will not be as complete as the PIC description.

## Moment Reductions

Fluid models reduce the information about the distribution functions, retaining only the minimum required information to characterize the distribution. This is done by retaining velocity moments of \\( f(\vec v) \\).

- 0th moment \\( \int f(v) \dd v \\) is the number density
- 1st moment \\( \int v f(v) \dd v  \\) gives the mean particle velocity, also called the drift or fluid velocity.
- 2nd moment \\( \int (v - v_d)(v - v_d) f(v) \dd v \\) gives the root mean square of the particle velocity, related to the fluid temperature.

These three moments are the only ones required to describe a Maxwellian distribution. A fluid system which tracks only these three moments necessarily assumes a local thermodynamic equilibrium (LTE). We don't have to assume LTE; we can allow for deviations away from a Maxwellian distribution, but we must include additional moments to do so.

- 3rd moment (skewness) is related to the energy flux.
- 4th moment (kurtosis) doesn't have a precise physical meaning, referred to as the "weight of the tail of the distribution."

The higher moments are really just statistical concepts, without real physical meaning.

Fluid models evolve only the moments of \\( f( \vec v) \\) to reduce the dimensionality of a full 6D (3P-3D) kinetic description down to a three-dimensional description

{{< katex display >}}
f(\vec x, \vec v) \rightarrow n(\vec x), v(\vec x), T(\vec x)
{{< /katex >}}

We've gone back down from 6D to 3D, but we have more variables at each point (moment values are scalars, vectors, and even tensors).

Moments for species \\( \alpha \\) are defined as

{{< katex display >}}
{M_{\alpha}}_{n} = \int_{- \infty} ^{\infty} \vec v ^n f_\alpha (\vec x, \vec v) \dd \vec v
{{< /katex >}}

where \\( \vec v^{n} \\) is the vector dyad product of \\( \vec v \\) with itself. This means that in general, \\( {M_{\alpha}}_{n} \\) will be a tensor, for each species \\( \alpha \\) in our system. These are the primary dependent variables of the fluid model.

{{< katex display >}}
n = 0: \qquad \int f_{\alpha} \dd \vec v = n_{\alpha}
{{< /katex >}}
{{< katex display >}}
n = 1: \qquad \frac{\int \vec v f_{\alpha} \dd \vec v}{n_{\alpha}} = \vec v_{\alpha}
{{< /katex >}}
{{< katex display >}}
n = 2: \qquad \int m_{\alpha} ( \vec v - \vec v_{\alpha})( \vec v - \vec v_{\alpha}) f_{\alpha} \dd \vec v = \overline{\vec P_{\alpha}}
{{< /katex >}}
{{< katex display >}}
n = 3: \qquad \frac{1}{n_{\alpha}} \int m_{\alpha} (\vec v - \vec v_{\alpha})(\vec v - \vec v_{\alpha}) ( \vec v - \vec v_{\alpha}) f_{\alpha} \dd \vec v = \overline{\vec H_{\alpha}}
{{< /katex >}}

where \\( n_{\alpha} \\) is a rank 0 tensor, \\( \vec v_{\alpha} \\) is a rank 1 tensor, \\( \overline{ \vec P}_{\alpha} \\) is a rank 2 tensor (with only 6 unique components), \\( \overline{\vec H}_{\alpha} \\) is a rank 3 tensor, and so on.

A common reduction is to define a heat flux vector (tensor contraction)
{{< katex display >}}
\vec h_{\alpha} = \frac{m_{\alpha}}{n_{\alpha}} \int ( \vec v - \vec v_{\alpha}) \cdot ( \vec v - \vec v_{\alpha})(\vec v - \vec v_{\alpha}) f_{\alpha} \dd \vec v
{{< /katex >}}
by contracting a dimension, we get a vector, which is the standard heat flux vector we usually think about. The full system is the 13N-moment plasma model (where N is the number of species). The moments are: \\( n \\), \\( v_x \\), \\( v_y \\), \\( v_z \\), \\( P_{xx} \\), \\( P_{xy} \\), \\( P_{xz} \\), \\( P_{yy} \\), \\( P_{yz} \\), \\( P_{zz} \\), \\( h_z \\), \\( h_y \\), \\( h_z \\) for each species \\( \alpha \\).

To cap off the moments, we need to "close" the model with a closure expression. Typically, we define a closure for the heat flux by defining a Fourier law for the conductivity:

{{< katex display >}}
\vec h = - \kappa \grad T
{{< /katex >}}

This is the 10N-moment plasma model.


### 5N-Moment Model

Another reduction is to define a closure for the anisotropic pressure tensor. This leaves us with the isotropic pressure (and temperature), and the shear stress is related to lower moment variables by a viscosity, like \\( \nu \grad \vec v \\). We then end up with the 5N-moment plasma model, which is one of the most common models for capturing many fluids. It's typically called the multi-fluid plasma model.

The governing equations are derived by taking moments of the Boltzmann equation

{{< katex display >}}
n = 0: \quad \pdv{n_{\alpha}}{t} + \div ( n_{\alpha} \vec v_{\alpha}) = 0
{{< /katex >}}
{{< katex display >}}
n  =1: \quad n_{\alpha} m_{\alpha} \left( \pdv{\vec v_{\alpha}}{t} + \vec v_{\alpha} \cdot \grad \vec v _{\alpha} \right) + \div \overline{\vec P}_{\alpha} - n_{\alpha} q_{\alpha} ( \vec E + \vec v_{\alpha} \cross \vec B) \\
= m_{\alpha} \int \vec v \left. \pdv{f_{\alpha}}{t} \right| _{coll} \dd \vec v \\
= - \sum_ \beta n_{\alpha} m_{\alpha} ( \vec v_{\alpha} - \vec v_\beta) \nu_{\alpha \beta} = \sum_\beta - \vec R_{\alpha \beta}
{{< /katex >}}

Note that this is the full Boltzmann equation, not the Vlasov equation, so we include the collision operator \\( \vec R_{\alpha \beta} \\) between unlike species \\( \alpha \\) and \\( \beta \\).

{{< katex display >}}
\overline{\vec P}_{\alpha} = P_{\alpha} \overline{\vec I} + \overline{\vec \Pi}_{\alpha}
{{< /katex >}}
where the scalar pressure is \\( P_{\alpha} = n_{\alpha} k T_{\alpha} \\)

{{< katex display >}}
n = 2: \quad \frac{1}{\gamma - q} n_{\alpha} \left( \pdv{T_{\alpha}}{t} + \vec v_{\alpha} \cdot \grad T_{\alpha} \right) + P_{\alpha} \div \vec v_{\alpha} = \dot{Q}_{\alpha}
{{< /katex >}}

where \\( \dot{Q} _ {\alpha} \\) includes the thermal conduction (heat flux vector), collisional heating (Ohmic heating), radiation losses, external heating, and so on. In this way, we've used our equations of state (closures) to express the full equations of motion in terms of our 5N moments \\( (n, \vec v, T) _ {\alpha} \\). The closure relations we've used for higher moment variables are
{{< katex display >}}
\overline{\vec \Pi}_{\alpha} = \nu _{\alpha} \grad \vec v_{\alpha}
{{< /katex >}}
{{< katex display >}}
\vec h_{\alpha} = - \kappa _{\alpha} \grad T_{\alpha}
{{< /katex >}}
where the constants \\( \nu_{\alpha} \\) and \\( \kappa_{\alpha} \\) are called "transport coefficients." They represent any physics which are not accurately captured by the LTE system, and so they represent approximations.

### Equations of State

Equations of state are used in defining closure relations. For example, for isothermal conditions, \\( T_{\alpha} \\) is constant, so \\( P_{\alpha} \propto n_{\alpha} \\).

Another assumption might be a force-free, cold assumption, so \\( T_{\alpha} = 0 \\) and therefore \\( P_{\alpha} = 0 \\).

Adiabatic assumption gives \\( P_{\alpha} \propto n_{\alpha} ^\gamma \\) for adiabatic index \\( \gamma \\) (ratio of specific heats).


## Equations of Motion

The fields are governed by Maxwell's equations

{{< katex display >}}
\epsilon_0 \div \vec E = \sum _\alpha q_\alpha n_\alpha
{{< /katex >}}
{{< katex display >}}
\div \vec B = 0
{{< /katex >}}
{{< katex display >}}
\epsilon_0 \pdv{\vec E}{t} = \frac{1}{\mu_0} \curl \vec B - \sum_\alpha q_\alpha n_\alpha \vec v _\alpha
{{< /katex >}}
{{< katex display >}}
\pdv{\vec B}{t} = - \curl \vec E
{{< /katex >}}

The thermal conductivity \\( \vec \kappa \\) and electrical resistivity \\( \vec \eta \\) are often functions of the magnetic field \\( \vec B \\).

# Single-Fluid MHD Model

To reduce the 5N fluid model even further, we work to combine the ions and electrons into a single fluid by applying some asymptotic approximations.

{{< katex display >}}
\epsilon_0 \rightarrow 0 (c \rightarrow \infty) \quad \text{and} \quad m_e \rightarrow 0
{{< /katex >}}
{{< katex display >}}
n_e = Z n_i = n \quad \text{Quasineutrality}
{{< /katex >}}
{{< katex display >}}
Z = 1, q = e \quad \text{Singly-charged}
{{< /katex >}}

We define our MHD variables as the center-of-mass values:

The mass density \\( \rho \\) is approximately the ion density

{{< katex display >}}
\rho = n_i m_i + n_e m_e = n m_i \left( 1 + \frac{m_e}{m_i} \right) \approx n m_i
{{< /katex >}}

The center-of-mass velocity is approximately the ion velocity

{{< katex display >}}
\vec v = \frac{n_i m_i \vec v_i + n_e m_e \vec v_e}{n_i m_i + n_e m_e} = \frac{m_i \vec v_i + m_e \vec v_e}{m_i + m_e} \approx \vec v_i
{{< /katex >}}

The pressure is the sum of the species pressures

{{< katex display >}}
P = P_i + P_e
{{< /katex >}}

And the current density is approximately the electron current density

{{< katex display >}}
\vec j = n e (\vec v_i - \vec v_e) \approx - n e \vec v_e
{{< /katex >}}

We now write the MHD equations in terms of the center of mass quantities

Continuity:

{{< katex display >}}
\pdv{\rho}{t} + \vec v \cdot \grad \rho = - \rho \div \vec v
{{< /katex >}}

Momentum:

{{< katex display >}}
\rho \left[ \pdv{\vec v}{t} + \frac{m_e \vec v_e \cdot \div \vec v_e}{m_i + m_e} + \frac{m_i \vec v_i \cdot \div \vec v_i}{m_i + m_e} \right] + \div P - \vec j \cross \vec B = 0
{{< /katex >}}

We'll want to revisit the negligible electron mass approximation. If we neglect the electron mass, then the \\( m_e \vec v_e \cdot \grad \vec v_e \\) term can not necessarily be dropped. However, if we neglect the electron inertia, then we can drop it. Doing so gives

{{< katex display >}}
\rho \left( \pdv{\vec v}{t} + \vec v \cdot \grad \vec v \right) + \grad P - \vec j \cross \vec B = 0
{{< /katex >}}

The generalized Ohm's law relates current density to the electric field

{{< katex display >}}
\begin{aligned}
\pdv{\vec j}{t} + \div ( \vec v \vec j + \vec j \vec v) & = & n \left( \frac{e^2}{m_e} + \frac{e^2}{m_i} \right) ( \vec E + \vec v \cross \vec B) - \left( \frac{e m_i}{m_e} - \frac{e m_e}{m_i} \right) \\
& & + \frac{\vec j \cross \vec B}{m_i + m_c}- \frac{e}{m_i} \grad P_i + \frac{e}{m_e} \grad P_e + \frac{e}{m_e} \vec R_{ei} - \frac{e}{m_i} \vec R_{ie}
\end{aligned}
{{< /katex >}}

For \\( m_e \ll m_i \\) and \\( m_e v_e \ll m_i v_i \\), we get the single-fluid equation of motion:

{{< katex display >}}
\frac{1}{\epsilon_0 \omega_{p, e} ^2} \pdv{\vec j}{t} = \vec E + \vec v \cross \vec B - \underbrace{\frac{1}{en} \vec j \cross \vec B}_{\text{Hall}} + \underbrace{\frac{1}{en} \div P_e} _ {\text{diamagnetic}} + \underbrace{\frac{1}{en} \vec R_{ei}}_{\text{collisions}}
{{< /katex >}}

### Assumptions / Asymptotic Approximations

Let's be specific about our assumptions, and provide justifications.

The negligible electron mass \\( m_e \ll m_i \\) is okay since
{{< katex display >}}
\frac{m_e}{m_i} < \frac{1}{1836} \approx 0.05 \%
{{< /katex >}}

Quasineutrality \\( n_i = n_e \\) is accurate down to some scale. If we have a globally neutral plasma \\( N_i = N_e \\), then scale is the Debye length \\( L \gg \lambda_D \\).

The negligible electron inertia \\( m_e v_e \ll m_i v_i \\) is not always justified

{{< katex display >}}
j = n e (v_i - v_e) = n e v_i \left( 1 - \frac{v_e}{v_i} \right)
{{< /katex >}}
{{< katex display >}}
\frac{m_e v_e}{m_i v_i} = \frac{m_e}{m_i} \left( 1 - \frac{1}{M} \frac{j}{n e v_{th}} \right)
{{< /katex >}}

where the Mach number \\( M \\) is \\( v_i / v_{th} \\).

Let's see how well this approximation checks out in a laboratory plasma. In the ZaP experiment,

{{< katex display >}}
I = 10^5A \qquad n = 10^{22} m^{-3} \qquad v_{th} = 10^5 m/s
{{< /katex >}}
{{< katex display >}}
M = 1 \qquad a = 0.01m
{{< /katex >}}
Plugging everything in, we get
{{< katex display >}}
\frac{m_e v_e}{m_i v_i} = 0.3\%
{{< /katex >}}

So, not a bad assumption. In contrast, in the HIT-SI3 experiment, we have

{{< katex display >}}
I = 10^4 \qquad n = 10^{19} m^{-3} \qquad v_{th} = 10^4 m/s \\ M = 0.1 \qquad a = 0.1 m
{{< /katex >}}
In this case,
{{< katex display >}}
\frac{m_e v_e}{m_i v_i} = 10\%
{{< /katex >}}
so the single-fluid approximation does not necessarily apply well there. We might think that moving to larger and larger scale lengths inevitably breaks this assumption, but in a really big tokamak (ITER) we do a pretty good job

{{< katex display >}}
I = 10^6 A \qquad n = 10^{20} m^{-3} \qquad v_{th} = 10^6 m/s \\
M =0.1 \qquad a = 1 m
{{< /katex >}}
{{< katex display >}}
\frac{m_e v_e}{m_i v_i} = 0.2 \%
{{< /katex >}}

Ultimately, most of our assumptions boil down to a low frequency assumption, since large spatial scales and slow evolution, such that \\( c \rightarrow \infty \\) imply low frequency evolution, and the quasineutral condition \\( L \gg \lambda_D \\) leads to a large frequency \\( \omega_p = v_{th} / \lambda_D \\). For \\( \omega \ll \omega_p \\), we can drop the left-hand side of the generalized Ohm's law

{{< katex display >}}
\cancel{\pdv{\vec j}{t} + \div ( \vec v \vec j + \vec j \vec v)} = n \left( \frac{e^2}{m_e} + \frac{e^2}{m_i} \right) ( \vec E + \vec v \cross \vec B) - \left( \frac{e m_i}{m_e} - \frac{e m_e}{m_i} \right) \\
+ \frac{\vec j \cross \vec B}{m_i + m_c}- \frac{e}{m_i} \grad P_i + \frac{e}{m_e} \grad P_e + \frac{e}{m_e} \vec R_{ei} - \frac{e}{m_i} \vec R_{ie} = 0

{{< /katex >}}

For quasineutrality, we can also drop the displacement current from Ampere's law

{{< katex display >}}
\mu_0 \epsilon_0 \pdv{\vec E}{t} \approx 0 = \curl \vec B - \mu_0 \vec j
{{< /katex >}}
{{< katex display >}}
c^2 \rightarrow \infty, \quad \mu_0 \epsilon_0 = 1/c^2 \rightarrow 0
{{< /katex >}}
{{< katex display >}}
\epsilon_0 \div \vec E = \rho_c \rightarrow 0
{{< /katex >}}

Taken together, this is the Hall-MHD plasma model, which is the most complete single-fluid MHD model available.

If the Hall and diamagnetic terms are negligible, we have well magnetized ions with small Larmor radius \\( r_{L, i} \\):

{{< katex display >}}
\frac{r_{L, i}}{L} \ll 1
{{< /katex >}}

then the generalized Ohm's law becomes

{{< katex display >}}
0 = \vec E + \vec v \cross \vec B - \eta \vec j
{{< /katex >}}

This is the Resistive MHD model. If we remove collisions entirely (\\( \eta \rightarrow 0 \\)), then we have the Ideal MHD Model.

The energy equation is still:

{{< katex display >}}
\pdv{P}{t} + \vec v \cdot \grad P = - \gamma P \div \vec v
{{< /katex >}}

If we use the definition of energy

{{< katex display >}}
e = \frac{p}{\gamma - 1} + \frac{1}{2} \rho v^2 + \frac{B^2}{2 \mu_0}
{{< /katex >}}

If we take the time derivative of this,

{{< katex display >}}
\pdv{e}{t} = \frac{1}{\gamma - 1} \pdv{p}{t} + \pdv{}{t} \left( \frac{1}{2} \rho v^2 \right) + \pdv{}{t} \left( \frac{B^2}{2 \mu_0} \right)
{{< /katex >}}

To get the second term, it helps to dot \\( \vec v \\) with \\( v \\):

{{< katex display >}}
\vec v \cdot \pdv{(\rho \vec v)}{t} + \ldots \rightarrow \pdv{}{t} \left( \frac{1}{2} \rho v^2 \right)
{{< /katex >}}

and similarly, taking the dot product of \\( \vec B \\) with the induction equation helps to get the third term

{{< katex display >}}
\vec B \cdot \pdv{\vec B}{t} + \ldots  \rightarrow \pdv{}{t} \left( \frac{B^2}{2 \mu_0} \right)
{{< /katex >}}

For all of these assumptions, the single-fluid MHD model is widely applicable to many plasmas.

# Numerical Solution of Fluid Models

The equations of the plasma fluid models result in different characteristics of the dynamics, depending on the model and the physics that are captured by that model. We can get an idea of what those characteristics are by analyzing the governing equation type, which dictates the appropriate numerical algorithm.

## Equation Types

In general, PDEs and systems of PDEs can be classified as elliptic, parabolic, or hyperbolic.

Consider a general second-order ordinary scalar PDE given by

{{< katex display >}}
a \pdv{^2 \psi}{x^2} + b \frac{\partial ^2 \psi}{\partial x \partial y} + c \pdv{^2 \psi}{y^2} + d \pdv{\psi}{x} + e \pdv{\psi}{y} + f \psi = g
{{< /katex >}}

The canonical equation for this PDE in canonical form is

{{< katex display >}}
a \left( \dv{y}{x} \right)^2 - b \left( \dv{y}{x} \right) + c = 0
{{< /katex >}}

The PDE is

- elliptic if \\( b ^2 < 4 a c \\)
- paraboolic if \\( b^2 = 4 a c \\)
- hyperbolic if \\( b^2 > 4 a c \\)

For example, Poisson's equation is an elliptic equation

{{< katex display >}}
\pdv{^2 \phi}{x^2} + \pdv{^2 \phi}{y^2} = - \rho / \epsilon_0
{{< /katex >}}
{{< katex display >}}
b = 0 \quad 4ac = 4 \rightarrow b^2 - 4 a c < 0
{{< /katex >}}

The equation for magnetic diffusion is a parabolic equation

{{< katex display >}}
\pdv{B_z}{t} = \frac{\eta}{\mu_0} \pdv{^2 B_z}{x^2}
{{< /katex >}}
{{< katex display >}}
b = 0 \quad 4 a c = 0 \rightarrow b^2 - 4 ac = 0
{{< /katex >}}

Maxwell's equations in a vacuum are hyperbolic:

{{< katex display >}}
\pdv{\vec E}{t} = c \curl \vec B
{{< /katex >}}
{{< katex display >}}
\pdv{\vec B}{t} = - c \curl \vec E
{{< /katex >}}
{{< katex display >}}
\pdv{^2 \vec B}{t^2} = - c \curl \left( \pdv{\vec E}{t} \right) = c^2 \nabla ^2 \vec B
{{< /katex >}}

In 1D,
{{< katex display >}}
\pdv{^2 B_z}{t^2} = c^2 \pdv{^2 B_z}{x^2}
{{< /katex >}}
{{< katex display >}}
b = 0 \quad 4 a c = - 4 c^2 \rightarrow b^2 - 4 a c > 0
{{< /katex >}}

### Hyperbolic Equations

For hyperbolic PDEs, the solution at any point depends on a subset of the domain (domain of dependence), and it influences a subset of the domain (domain of influence). This is the same concept as a light cone, where only portions of the domain less than \\( \pm c t \\) away from the current time can affect the current state.

<p align="center"> <img alt="30.png" src="/r/img/545/30.png" /> </p>

The slope of the curves that define the domains of influence/dependence are the characteristics of the equation. They are velocities; typically hyperbolic PDEs describe wave-like behavior, where the characteristic is the speed of the wave. The solution at a point does not necessarily depend on the boundary conditions; it will only do so when the domain of dependence intersects the boundary.

### Parabolic Equations

Parabolic PDEs have solutions that depend on the entire domain, but only at previous times. The domain of dependence includes the boundary conditions, and the initial condition.

<p align="center"> <img alt="31.png" src="/r/img/545/31.png" /> </p>

Parabolic PDEs are generally associated with diffusion-like behavior. The heat equation, viscous flow are parabolic equations.

### Elliptic Equations

For elliptic PDEs, the solution depends on and influences every other point in the domain. The boundary conditions and initial conditions determine the solution at every point in the domain.

<p align="center"> <img alt="32.png" src="/r/img/545/32.png" /> </p>

These equations are associated with steady-state and eigenvalue problems.

We've done this analysis assuming that the constants \\( a \\), \\( b \\), \\( c \\), ... are just that, constant. If they depend on \\( x \\), \\( y \\), or the solution \\( \psi \\) itself, then the equation type can change.

## Systems of Equations

As we've written it, the MHD model is not a scalar equation, but rather a system of equations. To deal with systems of PDEs, we typically write the system as a vector equation in conservation form, then examine the eigenvalues:

{{< katex display >}}
\pdv{\vec Q}{t} + \pdv{\vec F}{\vec x} = 0
{{< /katex >}}

where \\( \vec Q \\) is the vector of variables, and \\( \vec F \\) is the vector of fluxes. We can define the flux Jacobian \\( \overline \vec A \equiv \pdv{\vec F}{\vec Q} \\) and rewrite the governing system as an eigenvalue problem

{{< katex display >}}
\pdv{\vec Q}{t} + \overline \vec A \pdv{\vec Q}{\vec x} = 0
{{< /katex >}}

The equation type is given by the characteristics of the flux Jacobian:

- Elliptic if the eigenvalues of \\( \overline \vec A \\) are imaginary.
- Parabolic if eigenvalues of \\( \overline \vec A \\) are repeated and the eigenvectors are not unique.
- Hyperbolic if the eigenvalues of \\( \overline \vec A \\) are real and the eigenvectors are unique.

### Equation type of Ideal MHD Model

Let's apply this analysis to our ideal MHD model.

{{< katex display >}}
\pdv{\vec Q}{t} + \div \overline \vec T = 0
{{< /katex >}}
where the vector of variables is

{{< katex display >}}
\vec Q = \begin{bmatrix} \rho \\ \rho \vec v \\ \vec B \\ e\end{bmatrix} \qquad e = \frac{P}{\gamma - 1} + \frac{\rho v^2}{2} + \frac{B^2}{2 \mu_0}
{{< /katex >}}

and the flux tensor is 

{{< katex display >}}
\overline \vec T = \begin{bmatrix}
\rho \vec v \\
\rho \vec v \vec v - \frac{ \vec B \vec B}{\mu_0} + \left( P + \frac{B^2}{2 \mu_0} \right) \overline \vec 1 \\
\vec v \vec B - \vec B \vec v \\
\left( e + P + \frac{B^2}{2 \mu_0} \right) \vec v - \frac{\vec B \cdot \vec v}{\mu_0} \vec B
 \end{bmatrix}
{{< /katex >}}

Note that the vector of variables expands out to all of the various components of the vectors we've written:

{{< katex display >}}
\vec Q = [ \rho, \rho v_x, \rho v_y, \rho v_z, B_x, B_y, B_z, e]
{{< /katex >}}

We call a system of equations "conservative" if the time derivative of a conserved quantity can be written as a divergence of a flux. The divergence theorem makes this clear

{{< katex display >}}
\pdv{}{t} \int Q \dd V + \oint \dd \vec S \cdot \overline{\vec T} = 0
{{< /katex >}}

Splitting \\( \overline{\vec T} \\) into components along the \\( x \\), \\( y \\), \\( z \\) directions,

{{< katex display >}}
\pdv{\vec Q}{t} + \pdv{\vec F}{x} + \pdv{\vec G}{y} + \pdv{\vec H}{z} = 0
{{< /katex >}}

where
{{< katex display >}}
\vec F = \begin{bmatrix}
\rho u \\
\rho u^2 - B_x ^2 / \mu_0 + p + B^2 / 2 \mu_0 \\
\rho u v - B_x B_y / \mu_0 \\
\rho u w - B_x B_z / \mu_0 \\
0 \\
u B_y - B_x v \\
u B_z - B_x w \\
\left( e + p + \frac{B^2}{2 \mu_0} \right) u - \frac{\vec B \cdot \vec v}{\mu_0} B_x
\end{bmatrix}
{{< /katex >}}

and similar for \\( \vec G \\), \\( \vec H \\). To determine the equation type of our system in 1 dimension, we want to calculate the eigenvalues of the flux Jacobian of \\( \vec F \\)

{{< katex display >}}
\pdv{\vec Q}{t} + \pdv{\vec F}{x} = 0
{{< /katex >}}
{{< katex display >}}
\pdv{\vec Q}{t} + \underbrace{\pdv{\vec F}{\vec Q}}_{\vec A} \pdv{\vec Q}{x} = 0
{{< /katex >}}
where
{{< katex display >}}
\vec A = \begin{bmatrix}
\left. \pdv{F_1}{Q_1} \right|_{Q_i} & \left. \pdv{F_1}{Q_2} \right|_{Q_i} & \ldots \\
\left. \pdv{F_2}{Q_1} \right|_{Q_i} & \ldots  & \ldots \\
\ldots & \ldots & \ldots
\end{bmatrix}
{{< /katex >}}

When we compute these derivatives, we need to be careful to keep our other conserved quantities constant. For example,

{{< katex display >}}
\pdv{F_1}{\rho} = \pdv{}{\rho} (\rho u) = 0
{{< /katex >}}

because \\( (\rho u) \\) is one of the conserved quantities. For \\( F_2 \\),

{{< katex display >}}
F_2 = \frac{(\rho u)^2}{\rho} - \frac{B_x ^2}{2 \mu_0} + \frac{B_y ^2}{2 \mu_0} + \frac{B_z ^2}{2 \mu_0} + p
{{< /katex >}}

{{< katex display >}}
\pdv{F_2}{Q_1} = - \frac{(\rho u )^2}{\rho ^2} + \pdv{p}{Q_1} = - u^2 + \pdv{p}{\rho}
{{< /katex >}}

where we can write the pressure in terms of the conserved quantities as

{{< katex display >}}
p = (\gamma - 1) \left[ e - \frac{(\rho u )^2 + (\rho v)^2 + (\rho w)^2}{2 \rho} - \frac{B_x ^2 + B_y ^2 + B_z ^2}{2 \mu_0} \right]
{{< /katex >}}
{{< katex display >}}
\pdv{p}{Q_1} = (\gamma - 1) \left[ \frac{(\rho u )^2 + (\rho v )^2 + (\rho w )^2}{2 \rho ^2} \right] = (\gamma - 1) \frac{u^2 + v^2 + w^2}{2}
{{< /katex >}}
{{< katex display >}}
\pdv{F_2}{Q_2} = 2 \frac{(\rho u)}{\rho} + \pdv{p}{Q_2} = 2 (2 - \gamma) u
{{< /katex >}}
{{< katex display >}}
\pdv{F_2}{Q_3} = \pdv{p}{Q_3} = 2(1 - \gamma) v
{{< /katex >}}

And so on and so forth for the other elements of \\( \vec A \\). Once we've got the flux Jacobian, we can compute the eigenvalues and eigenvectors of \\( \vec A \\). These will all be real-valued, which tells us that the **ideal MHD equations are hyperbolic**.

The Resistive MHD model can be written as

{{< katex display >}}
\pdv{\vec Q}{t} + \div \overline{\vec T} + \frac{1}{R_m} \div \overline{\vec T_P} = 0
{{< /katex >}}

We know that
{{< katex display >}}
\pdv{\vec Q}{t} + \frac{1}{R_m} \div \overline{\vec T_p} = 0
{{< /katex >}}

If we go through the same process for \\( \overline{\vec T_p} \\), we'll find a parabolic system of equations, which is what we would expect from something with "resistive" in its name. So what sort of system *is* resistive MHD. The answer is, of course, "it depends." Depending on the type of phenomena we expect to see in a particular configuration, we'll have a dominant character associated with either wave phenomena or diffusive phenomena. The dominant character determines the appropriate algorithm to use when solving resistive MHD. For example, a large Reynolds number makes the system more hyperbolic.
