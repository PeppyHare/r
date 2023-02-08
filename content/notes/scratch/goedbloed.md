---
title: "Goedbloed (2019)"
bookToc: false
---

{{< katex display >}}

{{< /katex >}}

## Thermonuclear fusion and plasma confinement

Nuclear reactions release net energy if there is a mass defect, i.e. if

{{< katex display >}}
(m_A) + m_B) c ^2 > (m_C + m_D) c^2
{{< /katex >}}

In laboratory fusion, hydrogen isotopes are considered, where the deuterium-tritium reaction is the most promising one for future reactors:

{{< katex display >}}
D^2 + T^3 \rightarrow He ^4 (3.5 MeV) + n (14.1 MeV)
{{< /katex >}}

This yields two kinds of products, viz. \\( \alpha \\) particles which are charged so that they can be captured by a confining magnetic field, and neutrons which are electrically neutral so that they can escape from the magnetic configuration. The former contribute to the heating of the plasma (so-called \\( \alpha \\) particle heating) and the latter have to be captured in a surrounding \\( Li ^6 \\) or \\( Li ^7 \\) blanket, which recovers the fusion energy and also breeds new \\( T^3 \\).

Deuterium abounds in the oceans: out of 6500 molecules of water one molecule contains a deuteron and a proton instead of two protons. Thus, in principle, 1 litre of sea water contains \\( 10^{10} \\)J of deuterium fusion energy. This is a factor of about 300 more than the combustion energy of 1 litre of gasoline, which yields \\( 3 \cdot 10^7 \\)J.

A number of other reactions also occur, in particular reactions producing \\( T^3 \\) and \\( He ^3 \\) which may be burned again. Complete burn of all available \\( D^2 \\) would involve the following reactions:

{{< katex display >}}
\begin{aligned}
D^2 + D^2 & \rightarrow & He ^3 (0.3 MeV) + n (2.5 MeV) \\
D^2 + D^2 & \rightarrow & T^3 (1.0 MeV) + p (3.0 MeV) \\
D^2 + T^3 & \rightarrow & He ^4 (3.5 MeV) + n (14.1 MeV) \\
D^2 + He ^3 & \rightarrow & He ^4 (3.7 MeV) + p (14.6 MeV)
\end{aligned}
{{< /katex >}}

so that in effect

{{< katex display >}}
6D^2 \rightarrow 2He^4 + 2p + 2n + 43.2 MeV
{{< /katex >}}

In the liquid Li blanket, fast neutrons are moderated, so that their kinetic energy is converted into heat, and the following reactions occur:

{{< katex display >}}
\begin{aligned}
n + Li ^6 & \rightarrow & T^3 (2.1 MeV) + He ^4 (2.8 MeV) \\
n (2.5 MeV) + Li ^7 & \rightarrow & T^3 + He ^4 + n
\end{aligned}
{{< /katex >}}

This provides the necessary tritium fuel for the main fusion reaction. Typical numbers associated with thermonuclear fusion reactors, as currently envisaged, are:

|  |  |
| --- | --- |
|  temperature | \\( T \sim 10^8 K (10 keV) \\) |
| particle density | \\( n \sim 10^{21} m^{-3} \\) |
| power density | \\( \sim 10 MW m^{-3} \\) |
| time scale | \\( \tau \sim 100s \\) |

### Conditions for Fusion

Thermonuclear fusion happens when a gas of, e.g., deuterium and tritium atoms is sufficiently heated for the thermal motion of the nuclei to become so fast that they may overcome the repulsive Coulomb barrier and come close enough for the attractive nuclear forces to bring about the fusion reactions discussed above. This requires particle energies of \\( \sim 10 keV \\), i.e. temperatures of about \\( 10^8 K \\). At these temperatures the electrons are completely stripped from the atoms (the ionization energy of hydrogen is \\( \sim 14 eV \\)) so that a plasma rather than a gas is obtained.

Because the charged particles (occurring in about equal numbers of opposite charge) are freely moving and rarely collide at these high temperatures, a plasma may be considered as a perfectly conducting fluid for many purposes. In such fluids, electric currents are easily induced and the associated magnetic fields in turn interact with the plasma to confine or to accelerate it. The appropriate theoretical description of this state of matter is called magnetohydrodynamics (MHD), i.e. the dynamics of magneto-fluids.

Why are magnetic fields necessary? To understand this, we need to discuss the power requirements for fusion reactors. This involves three contributions:

(a) The thermonuclear output power per unit volume:

{{< katex display >}}
P_T = n ^2 f (\tilde{T})
{{< /katex >}}
{{< katex display >}}
f(\tilde{T}) \equiv \frac{1}{4} \langle \sigma v \rangle E_T
{{< /katex >}}
{{< katex display >}}
E_T \approx 22.4 MeV
{{< /katex >}}

where \\( n \\) is the particle density, \\( \sigma \\) is the cross-section of the D-T fusion reactions, \\( v \\) is the relative speed of the nuclei, \\( \langle \sigma v \rangle \\) is the average nuclear reaction rate, which is a well-known function of temperature, and \\( E_T \\) is the average energy released in the fusion reactinos (i.e. more than the \\( 17.6 MeV \\) of the D-T reaction, but of course less than the \\( 43.2 MeV \\) released for the complete burn)

(b) the power loss by Bremsstrahlung, i.e. the radiation due to electron-ion collisions

{{< katex display >}}
P_B = \alpha n^2 \tilde{T} ^{1/2}
{{< /katex >}}
{{< katex display >}}
\alpha \approx 3.8 \cdot 10^{-29} J^{1/2} m^3 s^{-1}
{{< /katex >}}

(c) the losses by heat transport through the plasma:

{{< katex display >}}
P_L = \frac{3 n \tilde{T}}{\tau _E}
{{< /katex >}}

where \\( 2 n \tilde{T} \\) is the total plasma kinetic energy density (electrons + ions) and \\( \tau_E \\) is the energy confinement time (an empirical quantity). The latter estimates the usually anomalous (i.e. deviating from classical transport by Coulomb collisions between the charged particles) heat transport processes. Here, we have put a tilde on the temperature to indicate that energy units of keV are exploited:

{{< katex display >}}
\tilde{T} (keV) = 8.62 \cdot 10^{-8} T(K)
{{< /katex >}}

since \\( \tilde{T} = 1 keV = 1.60 \cdot 10^{-16} J \\) corresponds with \\( T = 1.16 \cdot 10^{7} K \\) (using Boltzmann's constant \\( k \\)).

If the three power contributions are considered to become externally available for conversion into electricity and back again into plasma heating, with efficiency \\( \eta \\), the Lawson criterion

{{< katex display >}}
P_B + P_L = \eta (P_T + P_B + P_L)
{{< /katex >}}

tells us that there should be power balance between the losses from the plasma (LHS) and what is obtained from plasma heating (RHS). Typically \\( \eta \approx 1/3 \\). Inserting the explicit expressions leads to a condition to be imposed on the product of the plasma density and the energy confinement time:

{{< katex display >}}
n \tau _E = \frac{3 \tilde{T}}{[\eta / (1-\eta)] f(\tilde{T}) - \alpha \tilde{T} ^{1/2}}
{{< /katex >}}

Since Bremsstrahlung losses dominate at lower temperatures and transport losses dominate at high temperatures, there si a minimum in the curve at about

{{< katex display >}}
n \tau_E = 0.6 \cdot 10^{20} m ^{-3} s \quad \text{for} \tilde{T} = 25 keV
{{< /katex >}}

This should be considered to be the threshold for a fusion reactor under the given conditions.

By a rather different, more recent, approach of fusion conditions, _ignition_ occurs when the total amount of power losses is balanced by the total amount of heating power. The latter consists of \\( \alpha \\) particle heating \\( P_\alpha \\) and additional heating power \\( P_H \\) e.g. by radio-frequency waves or neutral beam injection. The latter heating sources are only required to bring the plasma to the ignition point, when \\( \alpha \\)-particle heating may take over. Hence, at ignition we may put \\( P_H = 0 \\) and the power balance becomes

{{< katex display >}}
P_B + P_L = P_\alpha =  \frac{1}{4} \langle \sigma v \rangle n^2 E_\alpha \quad E_\alpha \approx 3.5 MeV
{{< /katex >}}

Formally, this may be described by the same equation, taking now \\( \eta \approx 0.135 \\) so that a 2.5 times higher threshold for fusion is obtained:

{{< katex display >}}
n \tau _E = 1.5 \cdot 10^{20} m^{-3} s \quad \tilde{T} = 30 keV
{{< /katex >}}

Roughly speaking then, products of density and energy confinement time \\( n \tau_E \sim 10^{20} m ^{-3} s \\) and temperatures \\( \tilde{T} \sim 25 keV \\) or \\( T \sim 3 \cdot 10^{8} K \\), are required for fusion reactions. As a figure of merit for fusion experiments one frequently constructs the product of these two quantities, which should approach

{{< katex display >}}
n \tau_E \tilde{T} \sim 3 \cdot 10^{21} m^{-3} s ke V
{{< /katex >}}

for a fusion reactor. To get rid of the radioactive tritium component, one might consider pure D-D reactions in a more distant future. This would require yet another increase of the temperature by a factor of 10. Considering the kind of progress obtained over the past 40 years, one may hope that this difficulty eventually will turn out to be surmountable.

Returning to our question on the magnetic fields: no material containers can hold plasmas with densities of \\( 10^{20} m^{-3} \\) and temperatures of \\( 100-300 \\) million K during times on the order of minutes, or at least seconds, without immediately extinguishing the 'fire.' One way to solve this problem is to make use of the confining properties of magnetic fields, which may be viewed from quite different angles:

(a) the charged particles of the plasma rapidly and tightly gyrate around the magnetic field lines (they 'stick' to the field lines)

(b) fluid and magnetic field move together (the magnetic field is frozen into the plasma), so that engineering the geometry of the magnetic field configuration also establishes the geometry of the plasma;

(c) the thermal conductivity of plasmas is extremely anisotropic with respect to the magnetic field, \\( \kappa_\perp \ll \kappa _ \parallel \\), so that heat is easily conducted along the field lines and the magnetic surfaces they map out, but not across.

Consequently, what one needs foremost is a closed magnetic geometry facilitating stable, static plasma equilibrium with roughly bell-shaped pressure and density profiles and nested magnetic surfaces. This is the subject of the next section.