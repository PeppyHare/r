---
title: MHD Stability
bookToc: false
weight: 110
---


# MHD Stability

Equilibrium is simply a balance of forces that results in a steady state. Beyond equilibrium, stability is the tendency of a perturbation to return to equilibrium, rather than increasing. We are very interested in analyzing the stability of MHD equilibria, including the plasma dynamics, so we need to use the complete ideal MHD model. The MHD equations are non-linear, which means that any evolution/dynamics are also going to be non-linear. We can define the initial deviation from equilibrium to be a linear phenomenon. As usual, we perform this linearization by letting {{< katex >}} Q(r, t) = Q_0 + Q_1(r, t) {{< /katex >}} with {{< katex >}} Q_1 {{< /katex >}} being a small first-order perturbation. Since the equilibrium is both time and space independent, the general form of the perturbation is

{{< katex display >}}
Q_1(r, t) = \vu Q_1 e^{-i (\omega t - \vec k \cdot \vec r)}
{{< /katex >}}

{{< katex display >}}
\grad p_0 = \vec j_0 \cross \vec B_0
{{< /katex >}}
{{< katex display >}}
p = p_0 + p_1 \qquad \rho = \rho_0 + \rho_1
{{< /katex >}}
{{< katex display >}}
\vec j  = \vec j_0 + \vec j_1 \qquad \vec B = \vec B_0 + \vec B_1
{{< /katex >}}

and for a static equilibrium
{{< katex display >}}
\vec v = \vec v_1
{{< /katex >}}

In our momentum equations of the perturbed quantities, we assume that the static equilibrium holds, so most of the equilibrium terms drop out. We can define a velocity displacement {{< katex >}} \vec \xi = \int_0 ^t \vec v_1 \dd t {{< /katex >}}. As we integrate the field and pressure in time,

{{< katex display >}}
\pdv{B_1}{t} = \curl (\vec v_1 \cross \vec B_0)
{{< /katex >}}
{{< katex display >}}
\int \pdv{B_1}{t} = \vec B_1 = \curl \int \vec v_1 \cross \vec B_0 \dd t \\
 = \curl (\vec \xi \cross \vec B_0)
{{< /katex >}}

If we do the same for the pressure equation, we get

{{< katex display >}}
p_1 = - \vec \xi \cdot \grad p_0 - \Gamma p_0 \div \vec \xi
{{< /katex >}}
where {{< katex >}} \Gamma {{< /katex >}} is the ratio of specific heats, to avoid confusion with typical perturbation growth rate {{< katex >}} \gamma {{< /katex >}}.

If we combine all of these together, substituting into the momentum equation, we can express the perturbation entirely in terms of {{< katex >}} \vec \xi {{< /katex >}} and the equilibrium properties:

{{< katex display >}}
\rho_0 \pdv{ ^2 \vec \xi }{t^2} = \grad (\vec \xi \cdot \grad p_0 + \Gamma p_0 \div \vec \xi)\\
 + \frac{1}{\mu_0} \left[(\curl \vec B_0) \cross \curl (\vec \xi \cross \vec B_0) \right] \\
 + \frac{1}{\mu_0} \left[ \curl \curl ( \vec \xi \cross \vec B_0) \cross \vec B_0 \right]
{{< /katex >}}

We define the right-hand-side as the linearized forcing function of our equilibrium
{{< katex display >}}
\rho_0 \pdv{ ^2 \vec \xi }{t^2} = \vec F(\vec \xi _i , p_0, \vec B_0)
{{< /katex >}}

For a linear force function, we can also write it in terms of a spring constant tensor

{{< katex display >}}
\rho_0 \pdv{ ^2 \vec \xi }{t^2} = \vec F(\vec \xi) = - \overline \vec K \cdot \vec \xi
{{< /katex >}}

We can determine the stability behavior of a configuration by specifying an initial condition 

{{< katex display >}}
\vec \xi (t = 0) = 0 \qquad \text{and} \qquad \left. \pdv{\xi}{t} \right| _{t = 0} = f(\vec r)
{{< /katex >}}
and boundary conditions. A boundary condition may be a rigid wall
{{< katex display >}}
\vec \xi \cdot \vu n |_{wall} = 0
{{< /katex >}}

One way we can tell whether a given solution is unstable is to assume a variation of the form
{{< katex display >}}
\vec \xi \propto e^{-i \omega t}
{{< /katex >}}
If {{< katex >}} \omega^2 > 0 {{< /katex >}}, the displacement will oscillate in time without growth, and if {{< katex >}} \omega^2 < 0 {{< /katex >}} then the displacement will grow. In other words, if {{< katex >}} \omega {{< /katex >}} is real, then the mode is stable, and if {{< katex >}} \omega {{< /katex >}} is imaginary then the mode is unstable. The eigenvalue equation to be solved is

{{< katex display >}}
- \omega ^2 \rho_0 \vec \xi = \vec F(\vec \xi)
{{< /katex >}}
which we can write as a matrix equation
{{< katex display >}}
\overline \vec A\, \overline X = \lambda \overline X
{{< /katex >}}
{{< katex display >}}
\frac{1}{\rho_0} \vec F (\vec \xi) = - \omega ^2 \vec \xi
{{< /katex >}}

For any arbitrary linear forcing function, we might get an infinite number of eigenvalues. How do we know which ones to look at? It turns out that the linearized force function {{< katex >}} \vec F(\vec \xi) {{< /katex >}} has the property of being self-adjoint, so
{{< katex display >}}
\int \vec \eta \cdot \vec F(\vec \xi) \dd V = \int \xi \cdot \vec F( \vec \eta) \dd V
{{< /katex >}}
where {{< katex >}} \vec \eta {{< /katex >}} and {{< katex >}} \vec \xi {{< /katex >}} are arbitrary displacements that satisfy the same boundary conditions. If {{< katex >}} \vec F {{< /katex >}} is self-adjoint, then the system is Hermitian, which guarantees that we get real eigenvalues ({{< katex >}} \omega^2 {{< /katex >}}) , orthogonal eigenfunctions, and most importantly we are guaranteed to have an ordered spectrum of eigenvalues. That is to say {{< katex >}} \omega_0 ^2 < \omega _1 ^2 < \omega _2 ^2 < \ldots {{< /katex >}}. This means that the eigenvalue of the lowest mode is guaranteed to be the most negative, and therefore dictates the stability of the system. If the lowest eigenvalue is negative, then the system is necessarily unstable, and if the lowest eigenvalue is positive, then we are guaranteed that all modes are stable.

Because {{< katex >}} \vec F {{< /katex >}} is self-adjoint, we can make use of the energy principle to write the variation in the sum of the kinetic and potential energy as:

{{< katex display >}}
0 = \dv{}{t} \left[ \frac{1}{2} \int \rho_0 \left( \pdv{\vec \xi}{t} \right) ^2 \dd V - \frac{1}{2} \int \vec \xi \cdot \vec F ( \vec \xi) \dd V \right]
{{< /katex >}}
The kinetic energy term will always be positive, so we can formulate the stability based on the potential energy, often called a {{< katex >}} \delta W {{< /katex >}} approach
{{< katex display >}}
\delta W = - \frac{1}{2} \int \vec \xi \cdot \vec F ( \vec \xi) \dd V
{{< /katex >}}
is the change in potential energy due to a displacement {{< katex >}} \xi {{< /katex >}}. If the potential energy decreases due to a displacement {{< katex >}} \xi {{< /katex >}}, then the kinetic energy must necessarily increase, so {{< katex >}} \delta W < 0 {{< /katex >}} indicates instability.

We can write the change in kinetic energy for our normal mode decomposition as
{{< katex display >}}
\delta T = \frac{1}{2} \int \rho _0 \left( \pdv{\xi}{t} \right) ^2 \dd V = - \frac{1}{2} \omega ^2 \int \rho _0 \vec \xi ^ \star \cdot \vec \xi \dd V \\
= - \delta W = \frac{1}{2} \int \vec \xi ^\star \cdot \vec F(\vec \xi) \dd V
{{< /katex >}}
{{< katex display >}}
\omega^2 = \frac{- \int \xi ^\star \cdot \vec F \dd V}{\int \rho_0 \xi ^\star \cdot \xi \dd V} = \frac{\delta W}{\frac{1}{2} \int \rho_0 \xi ^\star \cdot \xi \dd V}
{{< /katex >}}

The denominator is strictly positive, so the sign of {{< katex >}} \omega^2 {{< /katex >}} is determined by the sign of {{< katex >}} \delta W {{< /katex >}} 

{{< katex display >}}
\delta W < 0 \rightarrow \omega^2 < 0 \rightarrow  \text{unstable} \\
\delta W > 0 \rightarrow \omega^2 > 0 \rightarrow \text{stable}
{{< /katex >}}

Analyzing the form of {{< katex >}} \delta W {{< /katex >}} (within the plasma volume)

{{< katex display >}}
\delta W = \frac{1}{2} \int_{plasma} \dd V \Gamma p_0(\div \vec \xi) ^2 + \vec \xi \cdot \grad p_0 (\div \vec \xi) \qquad \qquad  \\
\qquad \qquad + \frac{1}{\mu_0} \left[ \curl ( \vec \xi \cross \vec B_0) \right]^2 \\
\qquad \qquad - \frac{1}{\mu_0} \left[\vec \xi \cross ( \curl \vec B_0) \right] \cdot \left[ \curl ( \vec \xi \cross \vec B_0) \right]
{{< /katex >}}

Generally speaking, the plasma volume does not extend to infinity, and we care very much about the boundary. The total {{< katex >}} \delta W {{< /katex >}} is the sum of that in the plasma volume {{< katex >}} \delta W_F {{< /katex >}}, the surface {{< katex >}} \delta W_S {{< /katex >}}, and the vacuum region {{< katex >}} \delta W_V {{< /katex >}}. The vacuum term looks like

{{< katex display >}}
\delta W_V = \frac{1}{2} \int _{vac} \dd V \frac{ (\curl ( \vec \xi \cross \vec B_0))^2}{\mu_0} = \int_{vac} \dd V \frac{\vec B_1 ^2}{\mu_0} > 0
{{< /katex >}}

so the vacuum term is always positive, and has a stabilizing influence. The surface contribution offsets this

{{< katex display >}}
\delta W_S = \frac{1}{2} \oint \dd S ( \vu n \cdot \vec \xi) ^2 \left[ \left[ \grad \left( p_0 + \frac{B_0^2}{2 \mu_0} \right) \right] \right] \cdot \vu n
{{< /katex >}}

Instabilities can be characterized as:

- Internal/fixed boundary {{< katex >}} \delta W = \delta W_F {{< /katex >}} 
- External/free boundary {{< katex >}} \delta W = \delta W_F + \delta W_S + \delta W_V {{< /katex >}} 

The plasma portion can be re-written slightly as

{{< katex display >}}
\delta W_F = \frac{1}{2} \int \dd V \frac{ |B_{1, \perp}|^2}{\mu_0} \quad \leftarrow \text{Shear Alfven} \\
 + \mu_0 \left| \frac{B_{1, \parallel}}{\mu_0}  - \frac{B_0 \xi \cdot \grad p_0}{B_0} ^2 \right|^2 \quad \leftarrow \text{Fast magnetosonic} \\
   + \Gamma p_0 |\div \xi|^2 \quad \leftarrow \text{Acoustic}\\
   + \frac{\vec j_0 \cdot \vec B_0}{B_0 ^2} (\vec B_0 \cross \vec \xi) \cdot \vec B_1  \quad \leftarrow \text{Current-driven (kink)}  \\
- 2 ( \vec \xi \cdot \grad p_0)(\vec \xi \cdot \vec \kappa) \quad \leftarrow \text{pressure-driven (interchange/balooning)}
{{< /katex >}}

where {{< katex >}} \vec \kappa {{< /katex >}} is the curvature vector {{< katex >}} \vu e_B \cdot \grad \vu e_B {{< /katex >}}. If we look at each of these terms, the first three terms are all going to be stabilizing effects, which means that all instability is going to come from the last two terms, the current-driven instability term and the pressure-driven instability term.

Going back to the screw pinch, 
{{< katex display >}}
\dv{p}{r} = j_\theta B_z - j_z B_\theta
{{< /katex >}}
we have current in the same direction as magnetic field ({{< katex >}} j_\theta {{< /katex >}} with {{< katex >}} B_\theta {{< /katex >}} and {{< katex >}} j_z {{< /katex >}} with {{< katex >}} B_z {{< /katex >}}), so kink instabilities are possible. We also have a pressure gradient, so interchange instabilities are also possible.

As a concrete example, look at the pressure driven instability term in a Z-pinch. 
{{< katex display >}}
\kappa = - \frac{ \vu r}{r}
{{< /katex >}}
{{< katex display >}}
\vec \xi = \xi _r \vu r
{{< /katex >}}
{{< katex display >}}
\delta W_{F, pressure} = \int \dd V \xi _r \dv{p_0}{r} \frac{\xi_r}{r} \\
 = \int \dd V \frac{2 \xi _r ^2}{r} \dv{p_0}{r}
{{< /katex >}}

In a Z-pinch, it is always the case that {{< katex >}} \dv{p_0}{r} < 0 {{< /katex >}}. As shown by Kadomtsev (1965) it turns out that these modes can be stabilized by adding {{< katex >}} B_z {{< /katex >}}, but this also introduces kink modes.

Going back to our stabilizing quantities of wellness and shear, current-driven instabilities are generally managed through shear, and pressure-driven instabilities are stabilized by well.

