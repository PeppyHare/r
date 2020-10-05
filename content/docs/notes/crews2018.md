---
title: "Crews (2018)"
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

