---
title: Syllabus
weight: 10
---


## Syllabus

The course topics planned for this section are (in rough order):

Particle Model, Boltzmann-Maxwell Model, Magnetohydrodynamic (MHD) Model, Region of Validity, Common Assumptions, Ideal MHD Model, General Properties (Equilibrium, Boundary Conditions, Conservation Laws, "Frozen-In" Flux)

Ideal MHD Equilibrium, Virial Theorem, Magnetic Flux Surfaces

One-Dimensional Equilibria, Theta-Pinch, Z-Pinch, Screw-Pinch, Safety Factor q

Two-Dimensional Equilibria, Toroidal Geometry, Grad-Shafranov Equation, Closed Flux Surfaces, Safety Factor q, Magnetic Shear, Magnetic Well, Shafranov Shift, Spheromak, Reversed Field Pinch (RFP), Tokamaks, Stellarators (Elmo Bumpy Torus)

MHD Stability, General Concepts, Linearized MHD, Exponential (Linear) Stability, Force Operator and Properties, Variational Formulation, Energy Principle, Intuitive Form of delta W, Classification of Instabilities (internal/external, pressure-drive/current-driven, kink/interchange/ballooning)

Stability of One-Dimensional Equilibria, Modal Analysis, Rayleigh-Taylor, Theta-Pinch, Z-Pinch (Kadomtsev Condition), Screw-Pinch (Kruskal-Shafranov Condition, Suydam Criterion), RFP, "Straight" Tokamak

Stability of Two-Dimensional Equilibria, Tokamak, Mercier Criterion, Elmo Bumpy Torus

Resistive (Tearing) Instabilities, Stability of Non-static Equilibria, Nonlinear Stability Effects

## Course Motivation

Plasma phenomena tend to be hard to treat because of the span of relevant scales. You have ions, electrons, and photons interacting through electromagnetic interactions. There is a tremendous variation in mass across species, which leads to a large span of both spatial and temporal scales. The species can interact through both short scale collisions and long range interactions through EM forces. In contrast, in normal gas dynamics you may consider only the short-scale interactions. As a consequence, we can describe dispersive plasma waves.

For comparison, remember in gas dynamics, the speed of sound is 


{{< katex display >}}
\frac{\omega}{k} = v_s = \pdv{\omega}{k} \qquad \text{(gas)}
{{< /katex >}}

Here the phase velocity {{< katex >}} \frac{\omega}{k} {{< /katex >}} is equal to the phase velocity {{< katex >}} \pdv{\omega}{k} {{< /katex >}}. In a plasma, we can have non-linear dispersion relations in which the phase and group velocity are different.

{{< katex display >}}
\frac{\omega}{k} = v(\omega, k) \neq \pdv{\omega}{k} \qquad \text{(plasma)} 
{{< /katex >}}

The number of particles we typically deal with in a laboratory plasma is roughly on the order of a mole of particles

{{< katex display >}}
\text{particles} \sim O(10^{23})
{{< /katex >}}

With long-range interactions, we have a combinatorial explosion of interacting particles! It is not possible to track individual particles at such a scale, so we need much simpler plasma descriptions. These are the plasma models we will discuss in the next chapter. When simplifying our models, we need to pay careful attention to the simplifications we are making because in general, inaccurate physics lead to incorrect conclusions.