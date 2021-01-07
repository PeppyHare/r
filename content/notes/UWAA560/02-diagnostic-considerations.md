---
title: General Diagnostic Considerations
weight: 20
---

# General Diagnostic Considerations

{{< katex display >}}

{{< /katex >}}

First, let us categorize some broad categories of items to consider when we think about plasma diagnostics by asking a few questions:

**Which plasma properties do we want to measure?**

- Densities for individual species, velocity, temperature (moment measurements). In the case where a plasma is not thermal (Maxwellian), we may need to measure species distribution function \\( f_s (\vec v) \\)
- Plasma content, i.e. species concentrations, \\( Z_{eff} \\) (which is a determining factor in resistivity and radiation power)
- Plasma currents, current densities, electromagnetic fields. Note: some properties are inferred from other properties, e.g.
{{< katex display >}}
\vec j = \sum_s q_s n_s \vec v_s = \frac{1}{\mu_0} \curl \vec B \quad \text{if} \quad \tau \gg L/c
{{< /katex >}}
{{< katex display >}}
\div \vec E = \frac{1}{\epsilon_0} \sum_s q_s n_s
{{< /katex >}}
- Global measurements: input power, radiative power, energy confinement time, thrust, fusion reaction rate/yield.

**What spatial resolution is needed?**
- Some plasma diagnostics are spatially integrated, and some are chord-integrated, single-point measurements, 1D spatial resolution \\( f(r) \\), 2D \\( f(r, z) \\), 3D \\( f(x, y, z) \\), and 6D \\( f(\vec x, \vec v) \\)
- How many points in space are sufficient to resolve? 4, 10, 1000...
- Typically, "spatially-resolved" means a measurement at a particular location (not volume-integrated or chord-integrated).

**What temporal resolution is needed?**
- Time-integrated over pulse, once/twice during a pulse, gate time (how long is the shutter open?), continuous acquisition, sample rate and bandwidth
- "Temporally-resolved" includes all these except time-integrated measurements

**What other things do we need to take into consideration?**

- Does measurement require plasma access? Ports are usually small and expensive. What if the plasma is contained in a flux conserver, and what if the ports are far from the plasma? Some diagnostics require multiple ports and may be constrained to be coaxial (laser diagnostics) or orthogonal (scattering measurements).
- Data analysis: Many properties are inferred from measurements indirectly, data has to be processed to extract plasma properties. Analysis/processing often applies assumptions which can increase the uncertainty of the measurement.
- Suitability of detectors, lasers, and circuitry of detector itself. Often introduce sample rate, resolution, uncertainty limitations.
- Signal noise from detector and cabling
- Plasma reproducibility, shot-to-shot variability

The limitations and challenges with making experimental measurements of plasmas can be compensated by computational modeling, which have different, and often complementary, limitations. NIF is a good example: each pulse has a dedicated set of simulations for how much energy is deposited, how the target implodes, etc. Measurements (neutron yield, X-ray measurements, etc.) are compared with computational models to find agreement and to understand what happened in the experiment itself.

## Types of Plasma Diagnostics

### Passive Diagnostics

Passive diagnostics do not interact with the plasma and are non-perturbative. Self-emission spectroscopy, imaging, and X-ray and neutron detectors are examples.

### Active Diagnostics

Active diagnostics are external means to interact with the plasma and measure its response. These are further divided by the extent of perturbation. For an example, laser scattering at lower power often doesn't change the plasma properties appreciably, but Thompson scattering can require high enough power to significantly perturb the plasma.