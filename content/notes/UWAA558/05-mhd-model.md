---
title: Magnetohydrodynamic (MHD) Model
bookToc: false
weight: 50
---


# Magnetohydrodynamic (MHD) Model

Applying approximations to the two-fluid plasma model will allow us to arrive at a single-fluid (center-of-mass) description. The result is the ideal magnetohydrodynamic model (MHD).

First, define the MHD variables:

{{< katex display >}}
\text{mass density:} \qquad \rho = n_i m_i + n_i m_e
{{< /katex >}}

{{< katex display >}}
\text{fluid velocity:} \qquad \vec v = \frac{n_i m_i \vec v_i + n_e m_e \vec v_e}{n_i m_i + n_e m_e}
{{< /katex >}}

{{< katex display >}}
\text{current density:} \qquad \vec j = q_i n_i \vec v_i - e n_e \vec v_e  \rightarrow \vec v_e = \frac{q_i n_i \vec v_i}{e n_e} - \vec j / e n_e
{{< /katex >}}

{{< katex display >}}
\text{total pressure:} \qquad p = p_i + p_e = n_e T_e + n_i T_i
{{< /katex >}}

{{< katex display >}}
\text{total temperature:} \qquad T = \frac{n_i T_i + n_e T_e}{(n_i + n_e)/2}
{{< /katex >}}

Now let's begin applying asymptotic approximations. For the mass density, applying the first approx (charge neutrality) we have

{{< katex display >}}
\rho \approx n (m_i + m_e)
{{< /katex >}}

Using approx 2 (vanishing electron mass) 

{{< katex display >}}
\rho \approx n m_i
{{< /katex >}}
where
{{< katex display >}}
n = n_i \qquad n_e = Z n
{{< /katex >}}

The center-of-mass velocity (charge neutrality) gives

{{< katex display >}}
\vec v \approx \frac{m_i \vec v_i + m_e Z \vec v_e}{m_i + Z m_e}
{{< /katex >}}

with small electron mass approximation:

{{< katex display >}}
\vec v \approx \vec v_i
{{< /katex >}}

The current density is (charge neutrality approx)

{{< katex display >}}
\vec j \approx Z e n (\vec v_i - \vec v_e) \qquad \vec v_e = \vec v_i - \vec j / Z e n
{{< /katex >}}

The pressure and total temperature are (with charge neutrality)

{{< katex display >}}
P \approx n (T_i + Z T_e)
{{< /katex >}}

{{< katex display >}}
T \approx \frac{T_i + Z T_e}{(1 + Z)/2}
{{< /katex >}}

### MHD Momentum Equation

Now we combine the two-fluid equations with these asymptotic approximations to obtain the governing equations for the MHD variables. Multiplying the ion continuity equation by the ion mass gives

{{< katex display >}}
\pdv{}{t} (m_i n_i) + \div (m_i n_i \vec v_i) = 0 \\
\rightarrow \pdv{\rho}{t} + \div (\rho \vec v) = 0 \quad \text{(MHD continuity eq.)}
{{< /katex >}}

If we multiply the two-fluid continuity equations by the charge and sum them, we get

{{< katex display >}}
\pdv{}{t}(q_i n_i - e n_e) + \div (q_i n_i \vec v_i - e n_e \vec v_e) = 0 \\
\rightarrow \div \vec j = 0 \quad \text{(no accumulation of charge)}
{{< /katex >}}

If we add the electron and ion momentum equations and apply the small electron mass approximation, and recognizing that {{< katex >}} \vec R_{ei} = - \vec R_{ie} = n e \eta \vec j {{< /katex >}} 

{{< katex display >}}
\rho_i \left(\pdv{\vec i}{t} + \vec v_i \cdot \grad \vec v_i \right) + \grad (P_i + P_e) + \div (\vec \Pi _i + \vec \Pi_e) \\
\qquad  - (q_i n_i - e n_e) \vec E - (q_i n_i \vec v_i - e n_e \vec v_e) \cross \vec B = 0
{{< /katex >}}
{{< katex display >}}
\text{MHD Momentum Equation} \\
\rightarrow \rho \left(\pdv{\vec v}{t} + \vec v \cdot \grad \vec v \right) + \grad p - \vec j \cross \vec B = - \div (\vec \Pi _i + \vec \Pi _e)
{{< /katex >}}


> [!NOTE]
> 
> **"MHD Momentum Equation"**
> 
> {{< katex display >}}
\rho \left(\pdv{\vec v}{t} + \vec v \cdot \grad \vec v \right) + \grad p - \vec j \cross \vec B = - \div (\vec \Pi _i + \vec \Pi _e)
{{< /katex >}}


If we take the electron momentum equation, apply the small electron mass asymptotic approximation and introduce the current density, then we have

### MHD Ohm's Law

{{< katex display >}}
e n_e (\vec E + \vec v_i \cross \vec B - \vec j \cross \vec B / Z e n) = - \grad P_e - \div \vec \Pi_e + \vec R_{ei}
{{< /katex >}}

Substituting {{< katex >}} \vec R_{ei} = e n_e \eta \vec j {{< /katex >}} 
{{< katex display >}}
\text{MHD Generalized Ohms Law}\\
\vec E + \vec v \cross \vec B = \eta \vec j + \frac{1}{Z e n} \left(\vec j \cross \vec B - \grad p_e - \div \vec \Pi_e \right)
{{< /katex >}}

> [!NOTE]
> 
> **"MHD Generalized Ohms Law"**
> 
> {{< katex display >}}
\vec E + \vec v \cross \vec B = \eta \vec j + \frac{1}{Z e n} \left(\vec j \cross \vec B - \grad p_e - \div \vec \Pi_e \right)
{{< /katex >}}
    


### MHD Energy Equation

The energy equation is found by adding the ion and electron energies, but first we need to manipulate them into a common form. The ion energy equation is 

{{< katex display >}}
\frac{1}{\gamma - 1} \left[ \pdv{}{t} (n_i T_i) + \div (n_i T_i \vec v_i) \right] + n_i T_i \div \vec v_i = RHS_i
{{< /katex >}}

where {{< katex >}} RHS_i \equiv - \vec \Pi_i \cdot \cdot \grad \vec v_i - \div \vec h_i + Q_{ie} {{< /katex >}} 

{{< katex display >}}
\frac{1}{\gamma - 1} \left( \pdv{p_i}{t} + \vec v_i \cdot \grad p_i \right) + \frac{\gamma}{\gamma - 1} p_i (\div \vec v_i) = RHS_i
{{< /katex >}}

Multiply by {{< katex >}} \frac{\gamma - 1}{n_i ^\gamma} {{< /katex >}} and define the total derivative with respect to the ion velocity as

{{< katex display >}}
\dv{}{t} \equiv \pdv{}{t} + \vec v_i \cdot \grad
{{< /katex >}}

{{< katex display >}}
\rightarrow \dv{}{t} \left( \frac{p_i}{n_i ^\gamma} \right) - p_i \dv{}{t} \left( \frac{1}{n_i ^\gamma} \right) + \frac{\gamma p_i}{n_i ^\gamma} \div \vec v_i = \frac{\gamma - 1}{n_i ^\gamma} RHS_i
{{< /katex >}}

Simplify further by recognizing that carrying out the total derivative gives 

{{< katex display >}}
\dv{}{t} \left( \frac{p_i}{n_i ^\gamma} \right) - \frac{\gamma p_i}{n_i ^{\gamma + 1}} \dv{}{t} n_i + \frac{\gamma p_i}{n_i ^\gamma} \div \vec v_i = \frac{\gamma - 1}{n_i ^\gamma} RHS_i
{{< /katex >}}

The continuity equation says
{{< katex display >}}
\dv{}{t} n_i = - n_i \div \vec v_i
{{< /katex >}}
Multiply by {{< katex >}} m_i ^{- \gamma} {{< /katex >}} and use {{< katex >}} \rho = n m_i {{< /katex >}} and the resulting ion energy equation is

{{< katex display >}}
\dv{}{t} \left( \frac{p_i}{\rho ^\gamma} \right) = \frac{\gamma - 1}{\rho ^\gamma} RHS_i
{{< /katex >}}

We want to get the electron energy equation in the same form. The steps are very similar:

{{< katex display >}}
\dv{}{t} \left( \frac{p_e}{n_e ^\gamma} \right) + \vec v_e \cdot \grad \left( \frac{p_e}{n_e ^\gamma} \right) = \frac{\gamma - 1}{n_e ^\gamma} RHS_e
{{< /katex >}}

Since we've defined our center-of-mass reference frame to be that of the ions, we can not use the same total derivative

{{< katex display >}}
\pdv{}{t} + \vec v_e \cdot \grad \neq \dv{}{t}
{{< /katex >}}

We now apply the charge neutrality approximation

{{< katex display >}}
n_e = Z n \qquad \vec v_e = \vec v_i - \frac{1}{Z e n} \vec j
{{< /katex >}}

{{< katex display >}}
\rightarrow \dv{}{t} \left( \frac{p_e}{Z^\gamma n^\gamma} \right) + \vec v_i \cdot \grad \left( \frac{p_e}{Z^\gamma n^\gamma} \right) = \frac{1}{Z e n} \vec j \cdot \grad \frac{p_e}{Z^\gamma n^\gamma} + \frac{\gamma - 1}{Z^\gamma n^\gamma} RHS_e
{{< /katex >}}

Multiply by {{< katex >}} (Z / m_i)^\gamma {{< /katex >}} and the result is

{{< katex display >}}
\dv{}{t} \frac{p_e}{\rho ^\gamma} = \frac{1}{Z e n} \vec j \cdot \grad \frac{p_e}{\rho^\gamma} + \frac{\gamma - 1}{\rho^\gamma} RHS_e
{{< /katex >}}

Finally we can add the ion energy equation to the electron energy equation to get

{{< katex display >}}
\dv{}{t} \left( \frac{p}{\rho^\gamma} \right) = \\
\frac{\gamma - 1}{\rho^\gamma} \left[ Q_{ie} + Q_{ei} - \div (\vec h_i + \vec h_e) - \vec \pi_i \cdot \cdot \grad \vec v_i - \vec \Pi_e \cdot \cdot \grad \vec v_e \right] + \frac{\vec j}{Z e n} \cdot \grad \frac{p_e}{\rho^\gamma}
{{< /katex >}}

> [!NOTE]
> 
> **"MHD Energy Equation"**
> 
> {{< katex display >}}
\dv{}{t} \left( \frac{p}{\rho^\gamma} \right) = \frac{\gamma - 1}{\rho^\gamma} \left[ Q_{ie} + Q_{ei} - \div (\vec h_i + \vec h_e) - \vec \pi_i \cdot \cdot \grad \vec v_i - \vec \Pi_e \cdot \cdot \grad \vec v_e \right] + \frac{\vec j}{Z e n} \cdot \grad \frac{p_e}{\rho^\gamma}
{{< /katex >}}


Obviously, we've retained a number of terms that are specific to the behavior of the electrons. It is possible to incorporate the electron behavior by using a single-fluid MHD model with two temperatures {{< katex >}} T_i \neq T_e {{< /katex >}}. One can imagine a hierarchy of models, in which the most simplified is the single-fluid MHD model in which you evolve {{< katex >}} \rho {{< /katex >}}, {{< katex >}} \vec v {{< /katex >}}, and {{< katex >}} T {{< /katex >}}. Moving up a level, you have a MHD model with two temperatures in which you evolve {{< katex >}} \rho {{< /katex >}}, {{< katex >}} \vec v {{< /katex >}}, {{< katex >}} T_i {{< /katex >}}, and {{< katex >}} T_e {{< /katex >}}. Upwards from there you move back into the realm of multi-fluid models.

Now to relate the fields back to source terms. The low-frequency Maxwell's equations are

{{< katex display >}}
\pdv{\vec B}{t} = - \curl \vec E
{{< /katex >}}
{{< katex display >}}
\vec j = \frac{1}{\mu_0} \curl \vec B
{{< /katex >}}
{{< katex display >}}
\div \vec B = \div \vec E = 0
{{< /katex >}}

Like in the multi-fluid plasma model, we still need to close the system by expressing some of our variables using equations of state ({{< katex >}} \vec h {{< /katex >}}, {{< katex >}} \vec \Pi {{< /katex >}}).

To simplify further, we can make some assumptions about heat flow

{{< katex display >}}
\text{isothermal} \qquad \rightarrow p \propto n \qquad T = \text{const.} \qquad \gamma = 1
{{< /katex >}} 
{{< katex display >}}
\text{adiabatic} \qquad \rightarrow p \propto n^\gamma
{{< /katex >}}
{{< katex display >}}
\text{cols plasma / force-free} \qquad \rightarrow p = \text{const.} \qquad \gamma = 0
{{< /katex >}}

## Ideal MHD Model

The extended MHD equations are simpler than the two-fluid model, but they can still be quite complicated. We can often still get useful analysis from further reductions. The ideal MHD model is such a reduction that we can get by dropping (with justification) several terms from the extended model. We justify the simplifications by comparing the magnitude of the neglected terms to the terms that are retained.

Recall the characteristic speed is {{< katex >}} v_{T, i} {{< /katex >}}. If we say that the characteristic length plasma length is {{< katex >}} L {{< /katex >}}, then we can define characteristic time {{< katex >}} \tau = L / v_{T, i} {{< /katex >}}. 

The derivation of the two-fluid plasma model assumed a Maxwellian velocity distribution. We need the velocity distribution to thermalize, reach local thermodynamic equilibrium, and become Maxwellian. This means that we need many collisions, in fact so many collisions occurring frequently enough that we can ignore collisional effects. There must then be many collisions during the characteristic time {{< katex >}} \tau {{< /katex >}}.

For ions to be thermalized,

{{< katex display >}}
\frac{\tau_{ii}}{\tau} \ll 1
{{< /katex >}}

And similarly for electrons

{{< katex display >}}
\frac{\tau_{e}}{\tau} \ll 1
{{< /katex >}}

The continuity equation remains unchanged from the extended MHD model

> [!NOTE]
> 
> **"Ideal MHD Continuity Equation"**
> 
> {{< katex display >}}
\pdv{\rho}{t} + \div (\rho \vec v) = 0
{{< /katex >}}    

The momentum equation is

{{< katex display >}}
\rho \left( \pdv{\vec v}{t} + \vec v \cdot \grad \vec v \right) + \grad p - \vec j \cross \vec B = - \div (\vec \Pi_e + \vec \Pi_e)
{{< /katex >}}
Drop the anisotropic pressure

> [!NOTE]
> 
> **"Ideal MHD Momentum Equation"**
> 
> {{< katex display >}}
\rho \left( \pdv{\vec v}{t} + \vec v \cdot \grad \vec v \right) + \grad p - \vec j \cross \vec B = 0
{{< /katex >}}

The generalized Ohm's law is

{{< katex display >}}
\vec E + \vec v \cross \vec B = \eta \vec j + \frac{1}{Z e n} \left( \vec j \cross B - \grad p_e - \div \vec \Pi_e \right)
{{< /katex >}}

We're going to drop the entire right hand side

> [!NOTE]
> 
> **"Ideal MHD Generalized Ohm's Law"**
> 
> {{< katex display >}}
\vec E + \vec v \cross \vec B = 0
{{< /katex >}}

For the energy equation we have

{{< katex display >}}
\dv{}{t} \left( \frac{p}{\rho^\gamma} \right) = \frac{\gamma - 1}{\rho^\gamma} [Q_{ie} + Q_{ei} - \div (\vec h_i + \vec h_e) - \vec \Pi_i \cdot \cdot \grad \vec v_i - \vec \Pi_e \cdot \cdot \grad \vec v_e] + \frac{\vec j}{Z e n} \cdot \grad \frac{p_e}{\rho^\gamma}
{{< /katex >}}

We neglect the entire right-hand side

> [!NOTE]
> 
> **"Ideal MHD Energy Equation"**
> 
> {{< katex display >}}
\pdv{\rho}{t} + \div (p \vec v) = (1 - \gamma) p \div \vec v 
{{< /katex >}}

### Collision/Pressure terms

If we assume that the ions and electrons are in thermal equilibrium{{< katex >}} T_i = T_e {{< /katex >}}, we can relate the collision times

{{< katex display >}}
\tau_{ee} : \tau_{ii} : \tau_{ei} = 1 : \left( \frac{m_i}{m_e} \right) ^{1/2} : \frac{m_i}{m_e}
{{< /katex >}}

The collision times are specifically collisional relaxation times of the Boltzmann equation

{{< katex display >}}
\left. \pdv{f}{t} \right|_{coll} = \frac{f - f_{\text{Maxwellian}}}{\tau_{\alpha \beta}}
{{< /katex >}}

For electrons, the thermalization condition is much stricter for the ions

{{< katex display >}}
\frac{\tau_{ee}}{\tau} = \left( \frac{m_e}{m_i} \right)^{1/2} \frac{\tau_{ii}}{\tau} \ll 1
{{< /katex >}}

Neglect the anisotropic pressure tensor in the momentum and generalized Ohm's law, {{< katex >}} \div \vec \Pi {{< /katex >}}. {{< katex >}} \vec \Pi {{< /katex >}} is primarily the shear stress tensor. The ion thermal speed gives us a characteristic velocity for the plasma, so we use it to characterize the shear stress

{{< katex display >}}
\vec \Pi_{i, max} \sim 2 \mu \left( \pdv{u}{x} - \frac{1}{3} \div \vec v \right) \sim \mu \frac{v_{T, i}}{L}
{{< /katex >}}

Standard treatments of the viscosity (Braginskii, etc.) show that viscosity scales with the number density, temperature, and collision time

{{< katex display >}}
\mu \sim n T_i \tau_{ii} \sim p_i \tau_{ii}
{{< /katex >}}

{{< katex display >}}
\Pi_{i, max} \sim p_i \frac{\tau_{ii} v_{T, i}}{L}
{{< /katex >}}

The specific term we want to get rid of is {{< katex >}} \div \vec \Pi {{< /katex >}}, so let's compare it to a term we want to keep {{< katex >}} \grad P {{< /katex >}} 

{{< katex display >}}
\frac{\div \vec \Pi}{\grad p} \sim \frac{p_i \tau_{ii} v_{T, i} / L^2}{p_i / L} \sim \frac{\tau_{ii}}{\tau}
{{< /katex >}}

So, to neglect the anisotropic pressure term in the momentum equation, once again we require

{{< katex display >}}
\frac{\tau_{ii}}{\tau} \ll 1
{{< /katex >}}

In other words, as long as the plasma is collision-dominated, we can drop the ion anisotropic pressure term. What about associated the electron term? If you can assume {{< katex >}} T_i \approx T_e {{< /katex >}}. Then {{< katex >}} p_i \approx p_e {{< /katex >}} for a neutral plasma, and

{{< katex display >}}
\frac{\div \vec \Pi_e}{\grad p} \sim \frac{p_i \tau_{ee} v_{T, i} / L^2}{p_i / L} \sim \frac{\tau_{ee}}{\tau} \ll 1
{{< /katex >}}

### Magnetic terms

In the generalized Ohm's law, the diamagnetic drift term is

{{< katex display >}}
\frac{\grad p_e}{Z e n} \sim \frac{n T_e / L}{Z en} \sim \frac{T_i / L}{Ze} \sim \frac{m_i v_{T, i}^2}{L Z e}
{{< /katex >}}

Compare {{< katex >}} \grad p_e / Z e n {{< /katex >}} to a term that we're going to keep, which is the dynamo term {{< katex >}} \vec v \cross \vec B {{< /katex >}}

{{< katex display >}}
\frac{ \grad p_e / Z en}{|\vec v \cross \vec B|} \sim \frac{m_i v_{T, i}^2}{LZe}{v_{T, i} B} \sim \frac{m_i}{ZeB}\frac{v_{T, i}}{L} = \frac{v_{T, i}}{\omega_{c, i}} \frac{1}{L} \sim \frac{r_{L, i}}{L} \ll 1
{{< /katex >}}

So to neglect the diamagnetic drift term, we need the plasma to be well-magnetized. This means the Larmor radius must be much less than the plasma characteristic length {{< katex >}} r_{L, i} \ll L {{< /katex >}}

Now what can we do with the Hall term {{< katex >}} \frac{\vec j \cross \vec B}{Zen} {{< /katex >}}. For a static plasma (or one with subsonic flows):

{{< katex display >}}
\rho (\pdv{\vec v}{t} + \vec v \cdot \grad \vec v) - \grad p - \vec j \cross \vec B = 0
{{< /katex >}}

so by "subsonic" we mean that the static pressure is much larger than the dynamic pressure and we can discard the {{< katex >}} \vec v {{< /katex >}} terms.

{{< katex display >}}
\vec j \cross \vec B \approx \grad p
{{< /katex >}}

Comparing the Hall term to the dynamo term {{< katex >}} \vec v \cross \vec B {{< /katex >}} also gives the same requirement

{{< katex display >}}
\frac{r_{L, i}}{L} \ll 1
{{< /katex >}}

How well do some real plasmas hold up to the requirements of ideal MHD? Consider field nulls in a Z-pinch or an FRC, and weakly magnetized plasmas (such as those in a Hall thruster). Clearly, the magnetization requirement does not hold up at all points in space, and ideal MHD does not necessarily apply across the whole domain.

### Resistivity

We neglect resistivity and the resistive electric field {{< katex >}} \eta \vec j {{< /katex >}} in the generalized Ohm's law

{{< katex display >}}
\eta \vec j \sim \eta \frac{\grad p}{B} \sim \frac{ \eta n T}{LB}
{{< /katex >}}

{{< katex display >}}
\eta = \frac{m_e \nu_{ei}}{n e^2} = \frac{m_e}{n e^2 \tau_{ei}} = \frac{m_e ^2/ m_i}{n e^2 \tau_{ee}}
{{< /katex >}}

{{< katex display >}}
\rightarrow \eta \vec j \sim \frac{m_e ^2}{e^2 L B} \frac{v_{T, i} ^2}{\tau_{ee}}
{{< /katex >}}

How does it compare to {{< katex >}} \vec v \cross \vec B {{< /katex >}}

{{< katex display >}}
\frac{\eta \vec j}{|\vec v \cross \vec B|} \sim \left(\frac{m_e}{m_i} \right)^2 \frac{m_i}{e ^2 B^2} \frac{v_{T, i} ^2}{L^2} \frac{L}{v_{T, i} \tau_{ee}} \sim \left( \frac{m_e}{m_i}\right)^2 \frac{v_{T, i} ^2}{\omega_{c, i} ^2} \frac{1}{L^2} \sim \left( \frac{m_e}{m_i} \right) ^{3/2} \left( \frac{r_{L, i}}{L} \right) ^{2} \frac{\tau}{\tau_{ii}} \ll 1
{{< /katex >}}

This now places a lower limit on {{< katex >}} \tau_{ii} {{< /katex >}}; to neglect resistivity {{< katex >}} \tau_{ii} {{< /katex >}} cannot be too low

{{< katex display >}}
\left( \frac{m_e}{m_i} \right) ^{3/2} \left( \frac{r_{L, i}}{L} \right) ^{2} \ll  \frac{\tau_{ii}}{\tau} \ll 1
{{< /katex >}}

### Heating sources

Neglect the collisional heating sources {{< katex >}} Q_{ei} {{< /katex >}}, {{< katex >}} Q_{ie} {{< /katex >}} in the energy equation. We do that by assuming that they are equal and opposite, which only happens when the temperatures are equal. In other words, we are again assuming local thermodynamic equilibrium _between_ electrons and ions.

{{< katex display >}}
1 \gg \frac{\tau_{ei}}{\tau} = \left( \frac{m_i}{m_e} \right)^{1/2} \frac{\tau_{ii}}{\tau} \rightarrow \frac{\tau_{ii}}{\tau} \ll \left( \frac{m_e}{m_i} \right) ^{1/2}
{{< /katex >}}

This is a much more restrictive condition than ion collisionality. Alternatively, we could track two temperature independently.

We also neglect the heat flux terms {{< katex >}} \div (\vec h_i + \vec h_e) {{< /katex >}} in the energy equation. Consider parallel (to the magnetic field) heat conduction which dominates since {{< katex >}} \kappa_\perp \ll \kappa_\parallel {{< /katex >}}, so

{{< katex display >}}
\div \vec h \approx \grad_\parallel \cdot (\kappa_\parallel \grad_\parallel T)
{{< /katex >}}

{{< katex display >}}
\grad_\parallel \cdot \left[ ( \kappa_{\parallel, i} + \kappa_{\parallel, e}) \grad_\parallel T \right]
{{< /katex >}}

{{< katex display >}}
\kappa_{\parallel, e} \sim \frac{n T_e}{m_e} \tau_{ee} \qquad \text{ and } \qquad \kappa_{\parallel, i} \sim \frac{n T_i}{m_i} \tau_{ii}
{{< /katex >}}

{{< katex display >}}
\frac{\kappa_{\parallel, e}}{\kappa_{\parallel, i}} \sim \frac{\tau_{ee}}{\tau_{ii}} \frac{m_i}{m_e} \sim \left( \frac{m_i}{m_e} \right) ^{1/2}
{{< /katex >}}

Compare the thermal conductivity to the rate of pressure change {{< katex >}} \pdv{p}{t} {{< /katex >}} 

{{< katex display >}}
\frac{\grad_\parallel \cdot (\kappa_{\parallel, e} \grad_\parallel T)}{\pdv{p}{t}} \sim \frac{n T^2 \tau_{ee}/m_e L^2}{nT/\tau} \sim \left( \frac{m_i}{m_e} \right)^{1/2} \frac{\tau_{ii}}{\tau} \ll 1
{{< /katex >}}

We're back to the same requirement that we have ion-electron local thermodynamic equilibrium.

### Anisotropic pressure terms in energy equation

Neglect the anisotropic pressure terms in the energy equation. That is, {{< katex >}} \vec \Pi_i \cdot \cdot \grad \vec v_i {{< /katex >}} and {{< katex >}} \vec \Pi_e \cdot \cdot \grad \vec v_e {{< /katex >}}.  Skipping ahead, the result is

{{< katex display >}}
\frac{\tau_{ii}}{\tau} \ll 1 
{{< /katex >}}
{{< katex display >}}
\left( \frac{m_e}{m_i} \right)^{1/2} \frac{\tau_{ii}}{\tau} \frac{r_{L, i}}{L} \ll 1
{{< /katex >}}

### Electron convection term

Lastly, we neglect the electron convection term in the energy equation {{< katex >}} \frac{\vec j}{Zen} \cdot \grad \frac{P_e}{\rho^\gamma} {{< /katex >}}. The result is

{{< katex display >}}
\frac{r_{L, i}}{L} \ll 1
{{< /katex >}}


## Conservation Law Form of MHD

{{< katex display >}}
\pdv{}{t} q + \div \vec f = 0
{{< /katex >}}

We can express momentum in conservation law form:

{{< katex display >}}
\pdv{}{t} (\rho \vec v) + \div \left[ \rho \vec v \vec v - \frac{ \vec B \vec B}{\mu_0} + (p + \frac{B^2}{2 \mu_0})\vec 1 \right] = 0
{{< /katex >}}

The conservation law form for the magnetic field looks like

{{< katex display >}}
\pdv{ \vec B}{t} + \div \left[ \vec v \vec B - \vec B \vec v \right ] = 0
{{< /katex >}}

And of course the energy equation for

{{< katex display >}}
E = \frac{1}{\gamma - 1} p + \frac{1}{2} \rho v^2 + \frac{ B^2}{2 \mu_0}
{{< /katex >}}

{{< katex display >}}
\pdv{E}{t} + \div \left[ \left( E + p + \frac{B^2}{2 \mu_0} \right) - \left( \frac{ \vec B \cdot \vec v}{\mu_0} \right) \vec B \right] = 0
{{< /katex >}}

Conservation law forms are particularly useful when considering equilibrium steady-state force balance. This means that in steady-state equilibrium we have

{{< katex display >}}
\div \left[ \rho \vec v \vec v - \frac{ \vec B \vec B}{\mu_0} + \left( p + \frac{B^2}{2 \mu_0} \right) \vec 1 \right] = 0
{{< /katex >}}

We can use this relationship and integrate over various volumes to determine the relationship between the various force balance terms

### Examples of equilibrium plasma confinement

For a plasma in static equilibrium {{< katex >}} \vec v = 0 \rightarrow \vec j \cross \vec B = \grad p {{< /katex >}} 

{{< katex display >}}
 \div \vec T = 0 = \div \left( \right) 
 {{< /katex >}}

{{< katex display >}}
\vec j \cross \vec B = \frac{1}{\mu_0} (\curl \vec B) \cross \vec B = \frac{1}{\mu_0} (\vec B \cdot \grad \vec B - \frac{1}{2} \grad B^2) \\
= \frac{1}{\mu_0} ( B^2 \vu e_B \cdot \grad \vu e_B + \frac{1}{2} \vu e_B \vu e_B \cdot \grad B^2 - \frac{\grad B^2}{2} )
{{< /katex >}}

where {{< katex >}} \vu e_B = \vec B / B {{< /katex >}} 

{{< katex >}} \vu e_B \cdot \grad \vu e_B {{< /katex >}} is the curvature of {{< katex >}} \vec B {{< /katex >}}. Write it like a curvature

{{< katex display >}}
\vec K = - \vu r / R_c
{{< /katex >}}

{{< katex display >}}
\vu e_B \vu e_B \cdot \grad B^2
{{< /katex >}}
is gradient of {{< katex >}} B^2 {{< /katex >}} that is parallel to B. Multiply by {{< katex >}} e_B {{< /katex >}} gives the component of gradient along {{< katex >}} e_B {{< /katex >}}. The difference between that and {{< katex >}} \grad B^2 / 2 {{< /katex >}} gives you the perpendicular gradient

{{< katex display >}}
\vec j \cross \vec B = \frac{1}{\mu_0} (B^2 \vec \kappa - \frac{1}{2} \grad _\perp B^2) = \grad p = \grad_\perp p
{{< /katex >}}

identify {{< katex >}} B^2 \vec \kappa {{< /katex >}} is magnetic tension resulting from having a bent magnetic field line. {{< katex >}} \frac{1}{2} \grad_\perp B^2  {{< /katex >}} is magnetic pressure. They have to balance the plasma pressure at equilibrium.

For example, consider a cylindrical plasma that's in equilibrium with a helical magnetic field
{{< katex display >}}
\vec B = B_\theta (r) \vu \theta + B_z (r) \vu z
{{< /katex >}}

How is plasma pressure profile determined by the different components of the magnetic field? If we want to maximize the amount of pressure we confine, what should be maximized/minimized?

{{< katex display >}}
\frac{B^2}{\mu_0} \vu \kappa = \grad _\perp ( p + \frac{B^2}{2 \mu_0} ) 
{{< /katex >}}

{{< katex >}} B_z {{< /katex >}} is straight and has no curvature, so the only magnetic tension comes from {{< katex >}} B_\theta {{< /katex >}}, so the magnetic tension from {{< katex >}} B_\theta {{< /katex >}} must balance the total pressure.

<p align="center"> <img alt="Figure 12.6" src="/r/img/12.6.png" /> </p>

The role of {{< katex >}} B_z {{< /katex >}} is displacing plasma pressure. The utility in defining {{< katex >}} \beta {{< /katex >}} as

{{< katex display >}}
\beta = \frac{\text{plasma pressure}}{\text{magnetic pressure}}
{{< /katex >}}

### Conditions of Ideal MHD Validity

The conditions for ideal MHD to be valid are

1. High Ion Collisionality: {{< katex >}} \frac{\tau_{ii}}{\tau} \ll 1 {{< /katex >}} 
2. Small ion Larmor radius: {{< katex >}} \frac{r_{L, i}}{L} \ll 1 {{< /katex >}} 
3. Low resistivity: {{< katex >}} \left(\frac{m_e}{m_i} \right)^{3/2} \left( \frac{r_{L, i}}{L} \right)^2 \ll 1 {{< /katex >}} 

For a given plasma in force balance, we can relate the plasma pressure to the magnetic pressure

{{< katex display >}}
\beta = \frac{n T}{B^2 / 2 \mu_0} = 4 \times 10^{-16} \frac{n_{cm^{-3}} T_{keV}}{B^2 _{T}}
{{< /katex >}}

Ion collision time is (Spitzer collisionality)

{{< katex display >}}
\tau_{ii} = 2.09 \times 10^{7} \frac{T_{eV} ^{3/2} \mu ^{1/2}}{\ln \Lambda n_{cm ^{-3}}} \left[\text{s}\right]
{{< /katex >}}
where {{< katex >}} \mu \equiv m_i / m_p {{< /katex >}}.

Putting the conditions for ideal MHD in terms of {{< katex >}} \beta {{< /katex >}}  and {{< katex >}} \tau_{ii} {{< /katex >}}, 

1. High collisionality:
{{< katex display >}}
\frac{\tau_{ii}}{\tau} = 2.14 \times 10^{12} \frac{T^2}{n L} \ll 1 
{{< /katex >}}
{{< katex display >}}
\rightarrow T_{eV} \ll 6.8 \times 10^{-7} L_{cm} ^{1/2} n_{cm^{-3}} ^{1/2}
{{< /katex >}}
2. Small gyroradius:
{{< katex display >}}
\frac{r_{L, i}}{L} = 2.3 \times 10^7 \frac{1}{Z L} \sqrt{ \frac{\mu B}{n}} \ll 1
{{< /katex >}}
{{< katex display >}}
\rightarrow n_{cm^{-3}} \gg 5.3 \times 10^{14} \frac{\mu B_{T}}{Z^2 L_{cm} ^2}
{{< /katex >}}
3. Low resistivity:
{{< katex display >}}
\left( \frac{m_e}{m_i} \right) ^{3/2} \left( \frac{r_{L, i}}{L} \right) ^2 \frac{\tau}{\tau_{ii}} = 5.65 \frac{\mu B}{Z^2 L T^2}
{{< /katex >}}
{{< katex display >}}
\rightarrow T_{eV} \gg 2.4 \frac{\mu ^{3/2} \beta^{1/2}}{Z L _{cm} ^{1.2}}
{{< /katex >}}

<p align="center"> <img alt="Figure 12.7" src="/r/img/12.7.png" /> </p>


## Perpendicular MHD

For most configurations for magnetic fusion confinement, we are able to satisfy 2. and 3. but often have densities much too low to meet the high collisionality constraint. However, in practice ideal MHD does accurately model macroscopic behavior of many plasmas. At the same time, magnetized / fusion plasmas are often largely collisionless. We can understand why by re-writing the collisionality requirement as

{{< katex display >}}
1 \gg \frac{\tau_{ii}}{\tau} = \frac{\tau_{ii} v_{T, i}}{\tau v_{T, i}} \sim \frac{\lambda}{L}
{{< /katex >}}

where {{< katex >}} \lambda {{< /katex >}} is the mean free path. The ratio {{< katex >}} \lambda / L {{< /katex >}} is also known as the **Knudsen number**. In magnetized plasmas, the mean free path is often very long, but the path between collisions can cover a great distance only by following magnetic field lines. Motion {{< katex >}} \perp {{< /katex >}} to the magnetic field is constrained by {{< katex >}} r_{L, i} {{< /katex >}}. This suggests an approach wherein we divide the plasma model into a 1-D kinetic model to be solved along the magnetic field and a 2-D MHD model {{< katex >}} \perp {{< /katex >}} to the magnetic field. 

We consider diffusivity (terms like viscosity, conductivity) parallel and perpendicular to {{< katex >}} \vec B {{< /katex >}} 
{{< katex display >}}
k_\parallel \sim \frac{\lambda ^2}{\tau_{ii}}
{{< /katex >}}
{{< katex display >}}
k_\perp \sim \frac{r_{L, i} ^2}{\tau_{ii}}
{{< /katex >}}
{{< katex display >}}
\frac{k_\parallel}{k_\perp} \sim \left( \frac{\lambda}{r_{L, i}} \right)^2 \sim (\omega_{c, i} \tau_{ii} )^2
{{< /katex >}}

This changes one of our conditions for validity. Specifically, we can write

{{< katex display >}}
\frac{r_{L, i}}{L} \frac{1}{ \omega_{c, i} \tau_{i i}} = 254 \frac{\mu \beta}{Z^2 L_{cm} T_{eV} ^2}
{{< /katex >}}

or

{{< katex display >}}
T_{eV} \gg 16 \frac{\mu ^{1/2} \beta^{1/2}}{Z L^{1/2}}
{{< /katex >}}

This is now only slightly more restrictive than the low-resistivity condition. In fact, most of the plasmas that we looked at before (large tokamaks & toruses, propulsion systems) which had temperatures above the validity range now fall comfortably within the region of validity. The perpendicular MHD model is equivalent to a collisionless model, giving a much wider applicability than the collisional MHD model.

What about the parallel component? Our collisionality condition still isn't valid parallel to the field. Basically, we ignore the parallel component, which is the same as assuming that {{< katex >}} \rho {{< /katex >}}, {{< katex >}} T {{< /katex >}}, {{< katex >}} p {{< /katex >}} are constant along magnetic field lines, with {{< katex >}} \div \vec v = 0 {{< /katex >}} . Let's write out the expressions for collision-less MHD and for ideal MHD and compare:

|  | Collisionless MHD | Ideal MHD |
| --- | --- | --- |
| Continuity | {{< katex >}} \pdv{\rho}{t} = 0 {{< /katex >}} | {{< katex >}} \pdv{\rho}{t} = - \rho \div \vec v {{< /katex >}} |
| Momentum | {{< katex >}} \rho \dv{\vec v_\perp}{t} = \vec j \cross \vec B - \grad_\perp p {{< /katex >}} | {{< katex >}} \rho \dv{\vec v}{t} = \vec j \cross \vec B - \grad p {{< /katex >}} |
| Parallel constraint  | {{< katex >}} \vec B \cdot \grad \frac{v_\parallel}{B} = - \div \vec v _\perp {{< /katex >}} | |
| Energy | {{< katex >}} \dv{p}{t} = 0 {{< /katex >}} | {{< katex >}} \dv{p}{t} = - \gamma p \div \vec v {{< /katex >}} |

Collisionless MHD reproduces many of the effects of ideal MHD but has a wider region of validity. Corollary: ideal MHD is accurate beyond its region of validity, unless results lead to parallel gradients. For example, we know that MHD is not valid when representing confinement of a plasma confined in a magnetic mirror, which is an inherently kinetic phenomenon. But ideal MHD _can_ generate parallel gradients within its region of validity, and we need to be careful. Ideal MHD does not require different models {{< katex >}} \parallel {{< /katex >}} and {{< katex >}} \perp {{< /katex >}} to the magnetic field, and is therefore preferred. We will continue to use ideal MHD outside of its region of validity.
