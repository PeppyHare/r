---
title: Formulary
weight: 999
bookToc: false
---

{{< katex >}} {{< /katex >}}

# Formulary

{{< hint info >}}
**Kinetic Description**


{{< katex display >}}
\dv{\vec v}{t} = \frac{q_i}{m_i} (\vec E + \vec v_i \cross \vec B) + \sum_{j \neq i} \left[ \left. \dv{\vec v_{ij}}{t} \right|_{coll} \delta(\vec r_i - \vec r_j) \right]
{{< /katex >}}

{{< katex display >}}
\pdv{\vec B}{t} = - \curl \vec E
{{< /katex >}}

{{< katex display >}}
\frac{1}{c^2} \pdv{\vec E}{t} = \curl \vec B - \mu_0 \sum_i q_i \vec v_i \delta (\vec r - \vec r_i)
{{< /katex >}}

{{< katex display >}}
\div \vec{B} = 0
{{< /katex >}}

{{< katex display >}}
\div \vec E = \frac{1}{\epsilon_0} \sum_i q_i \delta (\vec r - \vec r_i)
{{< /katex >}}

Klimontovich equation:

{{< katex display >}}
\dv{N}{t} = 0 = \pdv{N}{t} + \pdv{}{q_i} \cdot (\dot{q_i} N) \\
N \equiv \sum_i \delta (p - p_i) \delta(q - q_i)
{{< /katex >}}

{{< /hint >}}

{{< hint info >}}
**Plasma Fluid Description**
    
Boltzmann Equation

{{< katex display >}}
\pdv{f_\alpha}{t} + \vec v \cdot \pdv{f_\alpha}{t} + \frac{q_\alpha}{m_\alpha} (\vec E + \vec v \cross \vec B) \cdot \pdv{f_\alpha}{\vec v} = \left. \pdv{f_\alpha}{t} \right|_{coll} = \sum_{\beta \neq \alpha} C_{\alpha \beta}
{{< /katex >}}

Maxwellian distribution:

{{< katex display >}}
f_\alpha (\vec v) = n_\alpha \left( \frac{m_\alpha}{2 \pi T} \right)^{3/2} e^{- \frac{m_\alpha(\vec v - \vec v_\alpha)^2}{2T}}
{{< /katex >}}
Moments of fluid model (moments of distribution \\( \rightarrow \\) moments of Boltzmann equation:

{{< katex display >}}
\text{Continuity:} \qquad n_\alpha = \int f_\alpha \dd \vec v \\
\quad \rightarrow \pdv{n_\alpha}{t} + \div (n_\alpha \vec v_\alpha) = 0
{{< /katex >}}

{{< katex display >}}
\text{Momentum:} \qquad n_\alpha \vec v_\alpha = \int \vec v f_\alpha \dd v \\
\quad \rightarrow \quad \pdv{}{t} (n_\alpha \vec v_\alpha ) + \div (n_\alpha \vec v_\alpha \vec v_\alpha) + \frac{1}{m_\alpha} \div \vec P_\alpha - \frac{q_\alpha}{m_\alpha} n_\alpha ( \vec E + \vec v _\alpha \cross \vec B) = \sum_{\beta \neq \alpha} \int \vec w C_{\alpha \beta} \dd \vec v
{{< /katex >}}

{{< katex display >}}
\rightarrow \rho_\alpha \left(\pdv{\vec v_\alpha}{t} + \vec v_\alpha \cdot \grad \vec v_\alpha \right) + \grad \vec P_\alpha + \div \vec \Pi_\alpha - q_\alpha n_\alpha (\vec E + \vec v_\alpha \cross \vec B) = \sum_{\beta \neq \alpha} \vec R_{\alpha \beta}
{{< /katex >}}

{{< katex display >}}
\text{Energy:} \qquad \int \vec v \vec v \pdv{f_\alpha}{t} \dd \vec v = \pdv{}{t} \int \vec v \vec v f_\alpha \dd \vec v = \pdv{}{t} \vec E_\alpha / m_\alpha \rightarrow \pdv{}{t} \vec P_\alpha
{{< /katex >}}

{{< katex display >}}
\rightarrow \quad \frac{3}{2} n_\alpha \left( \pdv{T_\alpha}{t} + \vec v_\alpha \cdot \grad T_\alpha \right) + P_\alpha \div \vec v_\alpha + \vec \Pi_\alpha \cdot \cdot \grad \vec v_\alpha + \div \vec h_\alpha = \sum_{\beta \neq \alpha} Q_{\alpha \beta}
{{< /katex >}}
Closure relations

{{< katex display >}}
\vec h_\alpha = - \kappa \grad T_\alpha
{{< /katex >}}

{{< katex display >}}
\overline \Pi_ \alpha = \nu \grad \vec v_\alpha
{{< /katex >}}

{{< /hint >}}

## Ideal MHD

{{< hint info >}}
**Ideal MHD**

Continuity:

{{< katex display >}}
\pdv{\rho}{t} + \div (\rho \vec v) = 0
{{< /katex >}}
Momentum:

{{< katex display >}}
\rho \left( \pdv{\vec v}{t} + \vec v \cdot \grad \vec v \right) + \grad p - \vec j \cross \vec B = 0
{{< /katex >}}
Generalized Ohm's Law

{{< katex display >}}
\vec E + \vec v \cross \vec B = \frac{1}{Zen}\cancel{(\vec j \cross \vec B - \grad p_e)} = 0
{{< /katex >}}
Energy

{{< katex display >}}
\dv{}{t} \left( \frac{p}{\rho^\gamma} \right) = 0
{{< /katex >}}

{{< /hint >}}

{{< hint info >}}
"Lawson Criterion"


{{< katex display >}}
n \tau_E > 10^4 s/m^3
{{< /katex >}}

{{< /hint >}}

{{< hint info >}}
**Conservation Law Form of Ideal MHD**

Continuity:

{{< katex display >}}
\pdv{\rho}{t} + \div (\rho \vec v) = 0
{{< /katex >}}
Momentum:

{{< katex display >}}
\pdv{(\rho \vec v)}{t} + \div \left[ \rho \vec v \vec v - \frac{\vec B \vec B}{\mu_0} + \left( p + \frac{B^2}{2 \mu_0} \right) \overline{I} \right] = 0
{{< /katex >}}
Energy:

{{< katex display >}}
\pdv{\epsilon}{t} + \div \left[ \left( \epsilon + p + \frac{B^2}{2 \mu_0} \right) \vec v - (\vec B \cdot \vec v) \frac{\vec B}{\mu_0} \right] = 0
{{< /katex >}}

{{< katex display >}}
\pdv{\vec B}{t} + \div ( \vec v \vec B - \vec B \vec v) = 0
{{< /katex >}}
where

{{< katex display >}}
\epsilon = \frac{1}{\gamma - 1} p + \frac{1}{2} \rho v^2 + \frac{B^2}{2\mu_0}
{{< /katex >}}

Static Equilibrium:

{{< katex display >}}
\vec j \cross \vec B = \grad p
{{< /katex >}}

{{< katex display >}}
\frac{B^2}{\mu_0} \vec K = \grad_\perp (p + \frac{B^2}{2 \mu_0})
{{< /katex >}}

{{< katex display >}}
\vec K \equiv \frac{\vec B}{|B|} \cdot \grad \frac{ \vec B}{|B|}
{{< /katex >}}

Conservation of flux:

{{< katex display >}}
\vec E + \vec v \cross \vec B = 0
{{< /katex >}}

{{< katex display >}}
\pdv{\vec B}{t} = - \curl \vec E
{{< /katex >}}

{{< katex display >}}
\rightarrow \dv{}{t} \left( \frac{\vec B}{\rho} \right) = \frac{\vec B}{\rho} \cdot \grad \vec v
{{< /katex >}}

{{< /hint >}}

## 1D Equilibria

{{< hint info >}}
**\\( \theta \\)-pinch**


{{< katex display >}}
B_\theta = 0
{{< /katex >}}

{{< katex display >}}
j_\theta B_z = \dv{p}{r}
{{< /katex >}}

{{< katex display >}}
j_\theta = - \frac{1}{\mu_0} \dv{B_z}{r}
{{< /katex >}}

{{< katex display >}}
\rightarrow p + \frac{B_z ^2}{2 \mu_0} = \frac{B_0 ^2}{2 \mu_0}
{{< /katex >}}

{{< katex display >}}
\langle \beta \rangle = \frac{2}{a^2} \int_0 ^a \frac{r p}{B_0 ^2 / 2 \mu_0} \dd r
{{< /katex >}}

{{< katex display >}}
q = \infty
{{< /katex >}}

{{< katex display >}}
W = \frac{\mu_0 r}{B_z ^2} \dv{}{r} \left( p + \frac{B_z ^2}{2 \mu_0} \right) = 0
{{< /katex >}}

{{< /hint >}}

{{< hint info >}}
**Z-pinch**


{{< katex display >}}
B_z =0
{{< /katex >}}

{{< katex display >}}
\grad p = \dv{p}{r} = - j_z B_\theta
{{< /katex >}}

{{< katex display >}}
- \dv{}{r} \left( p + \frac{B_\theta ^2}{2 \mu_0} \right) = \frac{B_\theta ^2}{\mu_0 r}
{{< /katex >}}

{{< katex display >}}
\langle \beta \rangle = \frac{2 \mu_0}{B_0 ^2 \pi a^2} \int _0 ^a 2 \pi r p \dd r = 1 \quad \text{ if } \quad p(a) = 0
{{< /katex >}}

{{< katex display >}}
q = S = 0
{{< /katex >}}

{{< katex display >}}
W = 1
{{< /katex >}}

{{< /hint >}}

{{< hint info >}}
**Screw pinch**


{{< katex display >}}
\dv{}{r} \left( p + \frac{B^2}{2 \mu_0} \right) = - \frac{B_\theta ^2}{\mu_0 r}
{{< /katex >}}

{{< katex display >}}
\beta_t = \frac{2 \mu_0}{B_z (a) ^2} \left( \frac{1}{\pi a^2} \int_0 ^a 2 \pi r p \dd r \right)
{{< /katex >}}

{{< katex display >}}
\beta_p = \left( 1 - \frac{\alpha_t}{\beta _t} \right)^{-1} \qquad \alpha_t \equiv \frac{2}{a^2} \int_0 ^a \left(1 - \frac{B_z ^2}{B_0 ^2} \right) r \dd r
{{< /katex >}}

{{< katex display >}}
q = \frac{2 \pi r B_z}{L B_\theta}
{{< /katex >}}

{{< katex display >}}
q_a = \frac{4 \pi ^2 a^2 B_0}{\mu_0 I_a}
{{< /katex >}}

{{< katex display >}}
S = \frac{r}{q} \dv{q}{r}
{{< /katex >}}

{{< katex display >}}
W = - \frac{B_\theta ^2}{B_\theta ^2 + B_z ^2}
{{< /katex >}}

{{< /hint >}}

{{< hint info >}}
**Stability**

Shear:

{{< katex display >}}
S = 2 \frac{ dq / q}{dV / V} = 2 \frac{d \ln q}{d \ln V}
{{< /katex >}}

{{< katex display >}}
q = \frac{\text{\# long windings}}{\text{\# short windings}} = \dv{\psi_t}{\psi_p}
{{< /katex >}}
Shear for toroid

{{< katex display >}}
q = \frac{r B_\phi}{R B_\theta}
{{< /katex >}}
Shear for cylinder

{{< katex display >}}
q = 2 \pi \frac{r B_z}{L B_\theta}
{{< /katex >}}
Well

{{< katex display >}}
W = \frac{ d \langle p + B^2 / 2 \mu_0 \rangle / \langle B^2 / 2 \mu_0 \rangle}{dV / V}
{{< /katex >}}
For stabilization, \\( B^2 / 2 \mu_0 \\) should increase faster than \\( p \\) decreases
{{< /hint >}}

## 2D Equilibria

{{< hint info >}}
**Grad-Shafranov Equation: Static toroidal equilibrium**


{{< katex display >}}
\grad p = \vec j_\theta \cross \vec B_\phi + \vec j_\phi \cross \vec B_\theta
{{< /katex >}}

{{< katex display >}}
A_\phi = \frac{\phi}{R} \vu \phi
{{< /katex >}}

{{< katex display >}}
\phi = \frac{\phi_p}{2 \pi}
{{< /katex >}}

{{< katex display >}}
\vec B_\theta = - \frac{\vu R}{R} \pdv{\psi}{z} + \frac{ \vu z}{R} \pdv{\psi}{R} = \frac{ \grad \psi}{R} \cross \vu \phi
{{< /katex >}}

{{< katex display >}}
F \equiv R B_\phi
{{< /katex >}}

{{< katex display >}}
\Delta ^\star \equiv R \pdv{}{R} \frac{1}{R} \pdv{}{R} + \pdv{^2}{z^2}
{{< /katex >}}

{{< katex display >}}
\Delta ^\star \psi = \pdv{^2 \psi}{z^2} + \pdv{^2 \psi}{R^2} - \frac{1}{R} \pdv{\psi}{R}
{{< /katex >}}

{{< katex display >}}
\vec j_\phi = - \frac{1}{\mu_0 R} \Delta ^\star \psi \vu \phi
{{< /katex >}}

{{< katex display >}}
\vec j_\theta = \frac{1}{\mu_0 R} \grad (F) \cross \vu \phi
{{< /katex >}}

{{< katex display >}}
R^2 \mu_0 \pdv{p}{\psi} = - \Delta ^\star \psi - F \pdv{F}{\psi}
{{< /katex >}}

{{< katex display >}}
q(\psi) = \frac{F(\psi)}{2 \pi} \oint_{p} \frac{r \dd \theta}{R^2 B_\theta}
{{< /katex >}}
Limits:

{{< katex display >}}
\text{Force-free:} \qquad \vec j \parallel \vec B
{{< /katex >}}

{{< katex display >}}
\rightarrow \Delta ^\star \psi + F F' = 0
{{< /katex >}}

{{< katex display >}}
\text{Connected $\theta$ pinch:} \qquad FF' \gg \Delta ^\star \psi
{{< /katex >}}

{{< katex display >}}
\rightarrow \grad p \approx \vec j_\theta \cross \vec B_\phi
{{< /katex >}}

{{< katex display >}}
\text{Connected Z-pinch:} \qquad FF' \ll \Delta ^\star \phi
{{< /katex >}}

{{< katex display >}}
\rightarrow \grad p \approx j_\phi \cross B_\theta
{{< /katex >}}

{{< /hint >}}

## MHD Stability

{{< hint info >}}
**Linear stability**
    

{{< katex display >}}
\pdv{\rho_1}{t} = - \vec v_1 \grad \rho_0 - \rho_0 \div \vec v_1
{{< /katex >}}

{{< katex display >}}
\pdv{\vec B_1}{t} = \curl ( \vec v_1 \cross \vec B_0)
{{< /katex >}}

{{< katex display >}}
\rho_0 \pdv{\vec v_1}{t} = - \grad p_1 + \vec j_0 \cross \vec B_1 - \vec j_1 \cross \vec B_0
{{< /katex >}}

{{< katex display >}}
\pdv{p_1}{t} = - \vec v_1 \cdot \grad p_0 - \gamma p_0 \div \vec v_1
{{< /katex >}}
For linear perturbation \\( \vec \xi = \int_0 ^t \vec v_1 \dd t \\) the momentum equation becomes

{{< katex display >}}
\rho_0 \pdv{^2 \xi}{t^2} = \vec F(\xi)
{{< /katex >}}
where

{{< katex display >}}
F(\xi) = \grad (\xi \cdot \grad p_0 + \gamma p_0 \div \xi) + \frac{1}{\mu_0} \left[ ( \curl \vec B_0) \cross \curl (\xi \cross \vec B_0) + \curl \curl (\xi \cross \vec B_0) \cross \vec B_0 \right]
{{< /katex >}}

Eigenvalues of \\( \frac{1}{\rho_0} \vec F (\xi) = \omega^2 \xi \\) are real and ordered. Only need to check \\( n=0 \\) to determine stability/instability of configuration.

{{< /hint >}}

{{< hint info >}}
**\\( \delta W \\) Approach**

\\( \delta W = \\) change in potential energy due to a displacement \\( \xi \\)

{{< katex display >}}
\delta W < 0  \rightarrow \text{instability}
{{< /katex >}}

{{< katex display >}}
\delta W = - \frac{1}{2} \int \xi \cdot F(\xi) \dd V = \delta W_F + \delta W_S + \delta W_V
{{< /katex >}}
Surface term:

{{< katex display >}}
\delta W_s = \frac{1}{2} \oint \dd S (\vu n \cdot \xi) ^2 \left( \vu n \cdot \grad p_0 + \left[ \vu n \cdot \grad \frac{B_0 ^2}{2 \mu_0} \right]_{jump} \right)
{{< /katex >}}
Vacuum term:

{{< katex display >}}
\delta W_V = \int_{vac} \dd V \frac{B_1 ^2}{\mu_0}
{{< /katex >}}
Plasma (free) term:

{{< katex display >}}
\delta W_F = \frac{1}{2} \int \dd V \frac{ |B_{1, \perp}|^2}{\mu_0} \quad \leftarrow \text{Shear Alfven} \\
+ \mu_0 \left| \frac{B_{1, \parallel}}{\mu_0}  - \frac{B_0 \xi \cdot \grad p_0}{B_0} ^2 \right|^2 \quad \leftarrow \text{Fast magnetosonic} \\
+ \Gamma p_0 |\div \xi|^2 \quad \leftarrow \text{Acoustic}\\
+ \frac{\vec j_0 \cdot \vec B_0}{B_0 ^2} (\vec B_0 \cross \vec \xi) \cdot \vec B_1  \quad \leftarrow \text{Current-driven (kink)}  \\
- 2 ( \vec \xi \cdot \grad p_0)(\vec \xi \cdot \vec \kappa) \quad \leftarrow \text{pressure-driven (interchange/balooning)}
{{< /katex >}}
Shear Alfven, fast magnetosonic, and acoustic modes are stabilizing. Current-driven and pressure-driven modes can lead to instability.
{{< /hint >}}
