---
title: Fluid Models for Plasmas
weight: 60
# bookToc: false
---

{{< katex display >}}

{{< /katex >}}

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
where \\( \dot{Q} _{\alpha} \\) includes the thermal conduction (heat flux vector), collisional heating (Ohmic heating), radiation losses, external heating, and so on. In this way, we've used our equations of state (closures) to express the full equations of motion in terms of our 5N moments \\( (n, \vec v, T) _{\alpha} \\). The closure relations we've used for higher moment variables are
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
