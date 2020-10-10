---
title: Equilibrium for Fusion
bookToc: false
weight: 70
---


# Equilibrium for Fusion ({{< katex >}} \beta {{< /katex >}})

For a fusion device we would like to determine a magnetic configuration that confines plasma while it fuses. At fusion temperatures, the power required to maintain the equilibrium will be substantial. For a device to be useful, the power required to sustain the equilibrium must be less than the power released from fusion. Important loss terms for a confined plasma are transport (thermal conduction primarily) and radiation terms. The scaling factors are {{< katex >}} P_{Brem} \sim n^2 T^{1/2} {{< /katex >}} and {{< katex >}} P_{cycl} \sim n^2 T^2 {{< /katex >}} for radiation, and {{< katex >}} P_L \sim \frac{3nT}{\tau_E} {{< /katex >}} for thermal losses.

We know that the fusion source term will primarily come from the DT fusion reaction

{{< katex display >}}
\text{D} + \text{T} \rightarrow \text{He}^4 (3.5\, MeV) + \text{n} (14.1\, MeV)
{{< /katex >}}

The primary fusion reaction releases an {{< katex >}} \alpha {{< /katex >}}-particle and a high-energy neutron. The concept of ignition is that the neutron leaves the plasma, and the {{< katex >}} \alpha {{< /katex >}} (with energy {{< katex >}} E_\alpha = 3.5 MeV) {{< /katex >}} remains to heat the plasma.

{{< katex display >}}
P_\alpha = \frac{1}{4} n^2 \langle \sigma v \rangle E_\alpha \qquad \text{(assuming} \quad n_D = n_T = n/2 \text{)}
{{< /katex >}}


{{< katex display >}}
P_\alpha > P_L \quad \rightarrow \quad n \tau_E > \frac{12 T}{E_\alpha \langle \sigma v \rangle}
{{< /katex >}}

To sustain fusion, we set the fusion heating term above the thermal loss term. The reaction cross-section {{< katex >}} \sigma {{< /katex >}} can be maximized to give the Lawson criterion

{{< katex display >}}
n \tau_E > 10^{14} s / cm^3
{{< /katex >}}

The Lawson criterion only applies at fusion temperatures, but it is a useful parameter even outside of ignition since it gives a ratio of fusion power to lost power

| {{< katex >}} T_i (keV) {{< /katex >}} | {{< katex >}} \langle \sigma v \rangle (cm^3 / s) {{< /katex >}} | Required {{< katex >}} n \tau_E (s / cm^3) {{< /katex >}} |
| --- | --- | ---|
| 1 | {{< katex >}} 7 \cdot 10^{-21} {{< /katex >}} | {{< katex >}} 5 \cdot 10^{17} {{< /katex >}} |
| 5 | {{< katex >}} 1.4 \cdot 10^{-17} {{< /katex >}} | {{< katex >}} 1.2 \cdot 10^{15} {{< /katex >}} |
| 20 | {{< katex >}} 4.3 \cdot 10^{-16} {{< /katex >}} | {{< katex >}} 1.6 \cdot 10^{14} {{< /katex >}} |
| 60 | {{< katex >}} 8.7 \cdot 10^{-16} {{< /katex >}} | {{< katex >}} 2.4 \cdot 10^{14} {{< /katex >}} |

We can see that the required {{< katex >}} n \tau_E {{< /katex >}} actually has a minimum around {{< katex >}} 20 keV {{< /katex >}} (at least, as far as the data in the table goes). Even though the maximum cross-section is at a much higher temperature, what we're really concerned with is the ratio of the fusion source term to the thermal loss term, which is linear in temperature.

MHD equilibrium does not place a limit on the density {{< katex >}} n {{< /katex >}}. Instead, it places a limit on {{< katex >}} \beta {{< /katex >}} in order to achieve equilibrium force-balance {{< katex >}} (\beta = 1) {{< /katex >}}

{{< katex display >}}
\beta = \frac{n (T_e + T_i)}{B^2 / 2 \mu_0} \rightarrow n = \frac{ \beta B^2}{4 \mu_0 T}
{{< /katex >}}

In this form, we can more clearly see what our options are to achieve MHD equilibrium. Some devices (large-scale tokamaks) are able to achieve the requisite confinement time at a low {{< katex >}} \beta {{< /katex >}} by making use of very strong magnetic fields. Other devices are able to make use of more modest magnetic fields by working at a higher {{< katex >}} \beta {{< /katex >}}.

Therefore,

{{< katex display >}}
\tau_E > \frac{1}{\beta B^2} \frac{48 \mu_0}{E_\alpha} \frac{T^2}{\langle \sigma v \rangle}
{{< /katex >}}

The term {{< katex >}} \frac{T^2}{\langle \sigma v \rangle} {{< /katex >}} has a minimum at {{< katex >}} 10-20 keV {{< /katex >}}. At 15 keV and a magnetic field of {{< katex >}} 5T {{< /katex >}} (many actual components cannot reasonably exceed such magnetic fields) then

{{< katex display >}}
\tau_E > \frac{0.1}{\beta} \text{s}
{{< /katex >}}

For a large-scale toroidal device with {{< katex >}} \beta = 1\% {{< /katex >}}, the confinement time {{< katex >}} \tau_E > 10s {{< /katex >}}. If we consider a common diffusivity (how fast energy will leave due to thermal conductivity) {{< katex >}} D_E \approx 1 m^2 / s{{< /katex >}}, so for a characteristic radius {{< katex >}} a {{< /katex >}} 

{{< katex display >}}
\tau_E \approx \frac{a^2}{4 D_E} \rightarrow a > 6.3 \text{m}
{{< /katex >}}

This gives you a sense of why low-{{< katex >}} \beta {{< /katex >}} devices need to be so large. Instead, if we consider {{< katex >}} \beta \sim 50\% {{< /katex >}}, {{< katex >}} \tau_E > 0.2 \text{s} {{< /katex >}} and

{{< katex display >}}
\beta \sim 50\% \rightarrow a > 0.9 \text{m}
{{< /katex >}}

When you consider that the cost of a device (to first order) scales with the volume of the device, achieving a high {{< katex >}} \beta {{< /katex >}} is very important for fusion equilibrium. However, when we consider MHD stability we are generally forced into lower {{< katex >}} \beta {{< /katex >}} to avoid destructive instabilities. Configuration optimization is the process of balancing this trade-off.

## Virial Theorem

Application of the virial theorem to energy balance for the stress tensor {{< katex >}} \vec T {{< /katex >}} tells us that MHD equilibria must be supported by externally supplied currents.  Many times you'll hear of theoretical designs for compact toroid devices which can maintain stability under their own currents, but they are the MHD stability equivalent of a perpetual motion machine. A compact toroid cannot exist unsupported.

Writing static equilibrium:

{{< katex display >}}
\div \left[ - \frac{ \vec B \vec B}{\mu_0} + \left( p + \frac{B^2}{2 \mu_0}\right) \vec I \right] = \div \vec T = 0
{{< /katex >}}

If we define the direction of the magnetic field to be {{< katex >}} \vu e _B = \vu z {{< /katex >}} then

{{< katex display >}}
\vec T = p_\perp ( \vec I - \vu e_B \vu e_B ) + p_\parallel \vu e_B \vu e_B \\
= \begin{bmatrix} p_\perp & 0 & 0 \\ 0 & p_\perp & 0 \\ 0 & 0 & p_\parallel \end{bmatrix}
{{< /katex >}}
where

{{< katex display >}}
p_\perp = p + \frac{B^2}{2 \mu_0}
{{< /katex >}}

and
{{< katex display >}}
p_\parallel = p - \frac{B^2}{2 \mu_0}
{{< /katex >}}

A gradient vector identity gives

{{< katex display >}}
\div (\vec r \cdot \vec T) = \vec r \cdot ( \div \vec T) + \vec T \cdot \cdot \grad \vec r
{{< /katex >}}

Integrating this expression over a volume and assuming that the volume contains a confined MHD equilibrium that is self-contained and self-supported:

<p align="center"> <img alt="Figure 12.10" src="/r/img/12.10.png" /> </p>

{{< katex display >}}
\int_V \div ( \vec r \cdot \vec T) \dd V = \int_V (\vec r \cdot \overbrace{\cancel{(\div \vec T)}}^{\text{MHD equil.}} + \vec T \cdot \cdot \grad \vec r) \dd V
{{< /katex >}}

{{< katex display >}}
\grad \vec r = \vec I
{{< /katex >}}

so 
{{< katex display >}}
\vec T \cdot \cdot \grad \vec r = p_\perp + p_\perp + p_\parallel \\
= 3p + \frac{B^2}{2 \mu_0}
{{< /katex >}}

{{< katex display >}}
\int_V (3p + \frac{B^2}{2 \mu_0} ) \dd V = \int _V \div ( \vec r \cdot \vec T) \dd V = \oint _S (\vec r \cdot \vec T) \cdot \vu n \dd S \\
= \oint _S  \left[ \vec r \cdot \vec I p_\perp + \vec r \cdot \vu e_B \vu e_B (p_\parallel - p_\perp) \right]\cdot \vu n \dd S \\
=\oint \left[ \left( \cancel{p} + \frac{B^2}{2 \mu_0} \right) \vu r \cdot \vu n - \frac{B^2}{\mu_0} (\vec r \cdot \vu e_B)(\vu e_B \cdot \vu n) \right] \dd S
{{< /katex >}}

Beyond where the plasma is contained, the pressure does not contribute {{< katex >}} p = 0 {{< /katex >}}. If all current sources are contained in the configuration, the magnetic field {{< katex >}} \sim 1/r^3 {{< /katex >}} for a dipole, {{< katex >}} \sim 1/r^4 {{< /katex >}} for a quadrupole, etc. Therefore the right-hand side will fall off like

{{< katex display >}}
RHS \propto \oint_S B^2 r \dd S \propto \left( \frac{1}{r^3} \right) ^2 r r^2 \propto \frac{1}{r^3} \text{(dipole)}
{{< /katex >}}
so {{< katex >}} RHS \rightarrow 0 {{< /katex >}} as {{< katex >}} r \rightarrow \infty {{< /katex >}}. But what about the left-hand side? Both of the terms in the volume integral are positive definite, so the LHS must be positive finite and the equality can't possibly hold. The assumption that the plasma is self-contained must be invalid. This tells us that we must have external currents. 

## Magnetic Flux Surfaces

The vast difference in thermal conductivity parallel and perpendicular to the magnetic field in a plasma confinement configuration leads to an avoidance of any open field lines. Magnetic equilibria are generally toroidal to eliminate end losses from open configurations. In general fusion confinement devices, magnetic field lines lie on a set of closed nested toroidal surfaces. This means that we can no longer describe any equilibria in a solely 1D geometry. The minor radius is no longer the only important scale length.

From {{< katex >}} \vec j \cross \vec B = \grad p {{< /katex >}}, we know that the pressure gradient is perpendicular to {{< katex >}} \vec j {{< /katex >}} and {{< katex >}} \vec B {{< /katex >}}, and therefore both {{< katex >}} \vec B {{< /katex >}} and {{< katex >}} \vec j {{< /katex >}} lie on surfaces of uniform pressure. We call these toroidal surfaces either magnetic surfaces or **flux surfaces**. We can use these surfaces to build a 1-dimensional description.

<p align="center"> <img alt="Figure 12.11" src="/r/img/12.11.png" /> </p>

As a brief aside, some geometrical vocabulary will be useful when describing toroidal geometry. A toroid is any surface of revolution with a hole in the middle. A torus is the particular case of a toroid in which the revolved figure is a circle.

We will define our global toroidal coordinate system to consist of the major axis {{< katex >}} (z) {{< /katex >}}, the distance from the major axis {{< katex >}} (R) {{< /katex >}}, and the azimuthal angle around the major axis {{< katex >}} (\phi) {{< /katex >}}.

<p align="center"> <img alt="Figure 12.13" src="/r/img/12.13.png" /> </p>

We will also make use of a poloidal coordinate system measured by minor radius (distance from the minor axis) {{< katex >}} r {{< /katex >}} and the poloidal angle from the minor axis {{< katex >}} \theta {{< /katex >}}. We will generally refer to a point on the torus relative to the major axis {{< katex >}} (R, z, \phi) {{< /katex >}}, or relative to the minor axis {{< katex >}} (r, \theta, \phi) {{< /katex >}}, or in spherical coordinates {{< katex >}} (R, \theta, \phi) {{< /katex >}}. The major radius {{< katex >}} R_0 {{< /katex >}} is the distance from the major axis to the minor axis. The minor radius {{< katex >}} a {{< /katex >}} is the characteristic distance from the minor axis to the exterior of the revolved figure. Usually we will find symmetry under {{< katex >}} \phi {{< /katex >}}.

The aspect ratio of a torus is the ratio of the major radius to the minor radius.

{{< katex display >}}
A = \frac{R_0}{a}
{{< /katex >}}

When we talk about a "toroidal surface," we mean a cross-section of the toroidal rotation. When we talk about a "poloidal surface" we mean a surface which is coplanar with the minor axis:

<p align="center"> <img alt="Figure 12.14" src="/r/img/12.14.png" /> </p>

The poloidal flux is determined by the size of the poloidal surface and the poloidal magnetic field:

{{< katex display >}}
\Psi _p = \int_{S_p} \vec B \cdot \dd \vec S
{{< /katex >}}

and the toroidal flux is determined by the size of a toroidal surface and the toroidal magnetic field:

{{< katex display >}}
\Psi_t = \int_{S_t} \vec B \cdot \dd \vec S
{{< /katex >}}

Considering the poloidal flux, we can see that if we expand the size of the surface towards the minor radius, the flux will increase until eventually we come to a point where the flux begins to decrease. The position of this maximum is called the **magnetic axis**, which does not necessarily correspond to the minor axis. In fact, it is generally displaced from the minor axis.

<p align="center"> <img alt="Figure 12.15" src="/r/img/12.15.png" /> </p>

To refer back to something more familiar, we'll define the same terms for a cylindrical geometry {{< katex >}}(r, \theta, z)  {{< /katex >}}. An axial surface corresponds with a toroidal surface, and an azimuthal surface corresponds with a poloidal surface:

<p align="center"> <img alt="Figure 12.16" src="/r/img/12.16.png" /> </p>

If we consider the trajectory of a single field line, what sorts of surfaces will it trace out? What surface will contain the field line? As it turns out, there are three options:

1. Rational surface - the field line closes on itself, and it does so after a finite number of revolutions. One way to quickly visualize such a surface is to draw a Poincaré puncture plot. Choose a toroidal plane and plot a point wherever the field line punctures the surface. A Poincaré puncture plot of a rational surface contains a finite number of points and no continuous curves.
2. Ergodic surface - the field line completely covers an entire surface, which is to say the field line punctures any toroidal surface an infinite number of times. In other words, it never closes on itself and defines an irrational curve.
3. Stochastic region - In this case, there is no definite surface and the field line fills a volume.

<p align="center"> <img alt="Figure 12.17" src="/r/img/12.17.png" /> </p>

Generally rational surfaces and ergodic surfaces are largely equivalent, but by introducing a small amount of resistivity a rational surface can lead to magnetic islands. One can imagine the addition of resistivity equivalent to allowing a small degree of motion of the magnetic field lines. In an ergodic surface, a flux surface is defined by a single (irrational) field line. If it moves toward itself in one location it will necessarily move away from itself in another location. But in a rational surface, different field lines can lie on the same constant pressure surface and will tend to move towards each other. By concentrating into magnetic islands, the flux surfaces are now more closely spaced, and the pressure gradient increases (a bad thing!)

<p align="center"> <img alt="Figure 12.18" src="/r/img/12.18.png" /> </p>

**Surface quantities**: Since pressure, current (not current density!), and _flux_ (not field!) are constant along a flux surface, it is convenient to use flux {{< katex >}} \Psi_p {{< /katex >}} as a coordinate. A particular poloidal flux itself uniquely determines a poloidal surface with constant pressure and current. The flux surface quantities are {{< katex >}} p, \, \Psi_p, \, \Psi_t, \, I_p = \int_{S_p} \vec j \cdot \dd \vec S, \, I_t = \int_{S_t} \vec j \cdot \dd \vec S{{< /katex >}}.

Surface quantities are not independent. The poloidal current {{< katex >}} I_p {{< /katex >}} affects the toroidal field {{< katex >}} B_t {{< /katex >}} and toroidal flux {{< katex >}} \Psi_t {{< /katex >}}. The toroidal current affects the poloidal field {{< katex >}} B_p {{< /katex >}} and poloidal flux {{< katex >}} \Psi_p {{< /katex >}}.

{{< katex display >}}
B_t = \vec B \cdot \vu \phi
{{< /katex >}}

{{< katex display >}}
\vec B_p = B_\theta \vu \theta + B_z \vu z \\
= B_r \vu R + B_z \vu z
{{< /katex >}}

## Toroidal Force Balance


Toroidal equilibria solves the end losses of linear equilibrium, but generates a new force which must be balanced. This is a result of the virial theorem.

### Poloidal Fields (Tire Tube Pressure Force)

If you think of a flexible bike tire being inflated, as the pressure within the inner tube increases, the major radius will increase! Why is this? The pressure within the tire is isotropic. As we pump up the tire, the pressure increase causes a force imbalance with the atmospheric pressure that causes the tube to expand. To simplify, we can consider a square tube with inner "radius" {{< katex >}} a {{< /katex >}}. The radial force scales with the pressure over the outer and inner surfaces

{{< katex display >}}
F_r = p S_{outer} - p S_{inner} \\
\sim p (R_0 + a) a - p (R_0 - a) a \sim 2 a^2 p
{{< /katex >}}

{{< hint info >}}
**"Missing content here on how to balance radial forces for purely poloidal fields (axisymmetric) with a conducting wall"**
{{< /hint >}}


Alternatively, we can use vertical external field coils to increase the field strength near the outer wall. They will also tend to center the plasma between the coils, so they have the advantage of preventing the plasma from drifting upwards or downwards

<p align="center"> <img alt="Figure 12.19" src="/r/img/12.19.png" /> </p>

### Toroidal Fields

Now let's consider driving a toroidal field in the plasma using a central coil on the major axis. Driving a toroidal field {{< katex >}} B_\phi {{< /katex >}} will also create a poloidal current {{< katex >}} j_\theta {{< /katex >}}. We know that the driven field will decay as {{< katex >}} 1/R {{< /katex >}} through the plasma. In actuality, the relationship is not perfectly {{< katex >}} 1/R {{< /katex >}} because of the generated poloidal current, which will modify the field within the plasma. Depending on the orientation of {{< katex >}} j_\theta {{< /katex >}}, it could either increase or decrease the poloidal field within the plasma. These are two different operations by which the plasma interacts with the magnetic field. When the induced plasma current tends to increase the field, we have a paramagnetic effect. In the opposite case (decrease) there is a diamagnetic effect. Generally, plasmas are diamagnetic, but there are certain situations where they become paramagnetic.

<p align="center"> <img alt="Figure 12.20" src="/r/img/12.20.png" /> </p>

Here again, we have a larger field on the in-bore side than on the out-bore side, so there will be a force imbalance tending to push the plasma towards larger radii. We might consider surrounding the plasma with a conducting wall, as we did previously, but we run into a difficulty determining a current distribution in the wall which would balance the radial effect. Any current distribution must be circular; because of the geometry of a torus such a current distribution would have the same force contribution on both the inside and outside edges. There is no way to stabilize the distribution with purely toroidal fields.
