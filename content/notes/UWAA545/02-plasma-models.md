---
title: Plasma Models
weight: 20
bookToc: false
---

# Plasma Models

{{< katex display >}}

{{< /katex >}}

First, let's get a working definition of "plasma": "a quasi-neutral gas of charged and neutral particles that exhibit collective behavior." Many of the approaches we will describe will also apply to non-neutral plasmas. Plasmas are composed of particles (electrons, ions, neutrals) which interact through electric and magnetic fields and through collisions. Therefore, the plasma _can_ be modeled as individual particles.

Plasmas exhibit collective behavior due to the long-range forces from EM field interactions. As a consequence of this collective behavior, the plasma can alternately be modeled as an electrically conducting fluid. These seemingly conflicting models can be married together by taking a statistical approach to convert from particles to a continuous distribution, or by defining fluid elements to treat as particles.

We will see that these statements are partially correct and partially incorrect. The accuracy of a particular sort of model depends on the length scales and time scales of interest, which are themselves determined by the plasma parameters. Consider a typical tokamak plasma which has a lifetime on the order of \\( 10^2 \\) seconds and electron plasma period on the order of \\( 10^{-12} \\) seconds. The physical dimensions are on the order of \\( 1 m \\) with a Debye length of \\( 10^{-5} m \\). We have quite a large range of parameters to handle!

Sometimes the large range of scales allows a separation between "fast" and "slow" dynamics, but generally this presents a challenge because the scales interact with each other (challenging multi-scale problem). At very fast time scales, the slower effects can be roughly approximated as equilibria.

## Hierarchy of Plasma Time Scales

In broad terms, we can define a hierarchy of plasma time scales.

-  \\( \omega_{pe} \\) \\( (10^{-12} s) \\) If we consider the fastest time scale, we think of the electron plasma frequency. It is associated with high frequency electromagnetic waves (~light speed). Associated with this time scale, but perhaps a little slower, we have electron dynamics, wave propagation (both electrostatic and electromagnetic).

- \\( \omega_{p, i} \\) \\( (10^{-9} s) \\) The next-fastest time scale is the ion plasma frequency. It is associated with ion oscillations, which become important in magnetized plasmas where electrons can move along magnetic fields in response to charge separation.

- \\(k v_A (10^{-9} - 10^{-6} s) \\) Ion cyclotron waves: electrostatics (Bernstein waves), electromagnetic (Alfvén waves)

- \\(k v_s (10^{-6}s) \\) Ion acoustic waves 

- \\( \omega ^\star (10^{-4}s) \\) Drift waves (\\( \omega ^\star = \\) drift frequency \\( \approx \grad p_e / e B n \\))

- \\( (k v_a \nu)^{1/2} (10^{-3}s) \\) Collisional effects (resistivity): magnetic reconnection, tearing instabilities, plasma disruptions

- \\( (\sim s) \\) Energy and plasma confinement time scales, including transport phenomena, which depend on effects from shorter time scales, and drift waves

## Hierarchy of Plasma Models

We can define a hierarchy of plasma models, which does not correspond directly with the hierarchy of time scales, but is related.

- **N-Body Model**
