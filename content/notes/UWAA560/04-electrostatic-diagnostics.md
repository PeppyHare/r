---
title: Electrostatic Diagnostics
weight: 40
bookToc: false
---

{{< katex display >}}

{{< /katex >}}

# Langmuir Probes

Langmuir probes are the oldest and simplest plasma diagnostic: You simply insert an electrode into the plasma and measure the \\( I \\)-\\( V \\) curve. Doing so is fairly simple, but the probe measurements are often difficult to interpret, since extracting accurate plasma properties from measurements can be challenging.

Consider a probe inserted into a steady-state plasma. We assume that there is an electrode (e.g. the wall of the vacuum chamber) which is essentially in electrical contact with the plasma, and we will treat that as ground.

<p align="center"> <img alt="20.png" src="/r/img/560/20.png" /> </p>

Assuming a thermal plasma (Maxwellian) with \\( T_i \approx T_e \\), ions and electrons strike the probe in all directions. Assume the bulk plasma is static (the bulk velocity is zero). Then the particle flux for each species \\( s \\) is

{{< katex display >}}
\Gamma_s=\frac{1}{4} n_s \overline{v}_s
{{< /katex >}}

where \\( \overline{v}_s \\) is the mean particle speed. A probe of area \\( A \\) initially at zero potential inserted in a singly charged, quasi-neutral plasma will emit a current

{{< katex display >}}
I = - e A \frac{1}{4} (n_i \overline v _i - n_e \overline v _e) \\
\approx \frac{1}{4} e A n_e \overline v_e > 0
{{< /katex >}}

A positive current here means the probe absorbs electrons. The probe potential, which started at ground, drops and repels incoming electrons until \\( \Gamma _e = \Gamma _i \\) such that \\( I = 0 \\). When this happens, we can measure the probe voltage to give what we call the "**floating potential**" \\( V_f \\). If the probe potential can be externally controlled, then we can find the floating potential without depleting the plasma of electrons. We can start out with a negative probe \\( V \\) and adjust it until the probe current vanishes.

A thermal plasma by definition has a probability distribution of speed of the form

{{< katex display >}}
f(v) = \left( \frac{m}{2 \pi k T} \right) ^{3/2} 4 \pi v^2 e^{- \frac{m v^2}{2T}}
{{< /katex >}}

Since the electron mass is small, the speed distribution is higher than that of the ions for \\( T_i \approx T_e \\):

<p align="center"> <img alt="21.png" src="/r/img/560/21.png" /> </p>

As the probe potential is more positive, eventually no electrons are repelled. This potential is the **plasma potential** (or space potential) \\( V_p \\). Increasing \\( V > V_p \\) further produces no increase in current, because at \\( V_p \\) the probe is already absorbing all of the incoming electrons.

As a point of reference, the plasma potential is approximately 5 times the electron temperature

{{< katex display >}}
V_p \approx 5 k T_e
{{< /katex >}}

An idealized I-V characteristic looks like this:

<p align="center"> <img alt="22.png" src="/r/img/560/22.png" /> </p>

Since \\( m_i \gg m_e \\), \\( I_{is} \ll I_{es} \\). If \\( T_i = T_e \\) then

{{< katex display >}}
\frac{I_{is}}{I_{es}} = \left( \frac{m_e}{m_i} \right)^{1/2}
{{< /katex >}}

The transition region is where we make most of our measurements of plasma parameters. As \\( V \\) is adjusted between \\( (V_f, V_p) \\), the electron current varies exponentially as

{{< katex display >}}
I_e = I_{es} e^{\frac{ V - V_p}{k T_e}}
{{< /katex >}}

where
{{< katex display >}}
I_{es} = \frac{1}{4} e A n_e \overline{v}_e = e n_e A \left( \frac{k T_e}{2 \pi m_e} \right)^{1/2}
{{< /katex >}}

If we measure the electron current \\( I_e \\) vs. \\( V \\), this allows us a measurement to get the electron temperature \\( T_e \\). Note that \\( I_e \\) is not the total current; we need to subtract the ion current \\( I_e = I - I_i \\). So to recover the electron temperature, we plot \\( \ln (I) \\) vs. \\( V \\) and check the slope in the transition region:

<p align="center"> <img alt="23.png" src="/r/img/560/23.png" /> </p>

Since \\( I_{is}  \\) is fairly constant at low \\( V \\), it is often easier to adjust \\( I_i \\) until the linear portion is maximized. With \\( T_e \\) determined, the density could be extracted from the electron saturation current \\( I_{es} \\). Looking at the form of \\( I_{es} \\), you can see that it depends only on the probe geometry, electron temperature, and density. So we could measure the density as

{{< katex display >}}
n_e = \frac{I_{es}}{e A} \left( \frac{k T_e}{2 \pi m_e} \right) ^{1/2}
{{< /katex >}}

but besides being difficult to measure, \\( I_{es} \\) can be very large, leading to Bad Things like altering the plasma properties, damaging the probe, or destroying the probe circuitry.

Instead, we take a look at the other end of the \\( I \\)-\\( V \\) curve and determine the ion density \\( n_i \\) from the ion saturation current, which is generally less than \\( 10 \\% \\) of the electron saturation current.

If the electrons have an energetic population (e.g. a beam or other population of high-temperature electrons) in addition to the thermal population, then the distribution is not Maxwellian. Useful information can still be obtained from the \\( I \\)-\\( V \\) characteristic, but it will contain additional inflection points

<p align="center"> <img alt="24.png" src="/r/img/560/24.png" /> </p>