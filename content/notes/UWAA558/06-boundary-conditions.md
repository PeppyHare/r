---
title: Boundary Conditions
bookToc: false
weight: 60
---


# Boundary Conditions

Mathematically, a well-posed problem requires both governing equations and a complete set of boundary conditions (the Cauchy data for the problem). The most common boundary conditions we use are perfectly conducting walls (flux surfaces) or a vacuum region.

### Perfectly Conducting Wall

For the case where the plasma extends out to a perfectly conducting (impermeable) wall. Perfectly conducting walls do not support tangential electric field:

{{< katex display >}}
\left. \vec E_t \right|_{wall} = 0 \quad \rightarrow \quad \left. \vu n \cross \vec E \right| _{wall} = 0
{{< /katex >}}

Applying Faraday's law at the wall,

{{< katex display >}}
\left. \vu n \cdot \pdv{\vec B}{t} \right|_{wall} = \left. - \vu n \cdot \curl \vec E \right|_{wall} = \left. \div (\vu n \cross \vec E) \right| _{wall} = 0
{{< /katex >}}
{{< katex display >}}
\pdv{}{t} \vu n \cdot \vec B |_{wall} = 0
{{< /katex >}}
If initially there is no normal magnetic field, then
{{< katex display >}}
\vu n \cdot \vec B|_{wall} = 0 \quad \text{if initially true}
{{< /katex >}}

And of course, for an impermeable wall,

{{< katex display >}}
\vu n \cdot \vec v |_{wall} = 0
{{< /katex >}}

Is this a sufficient set of boundary conditions? Think back to the governing equations in conservation form
{{< katex display >}}
\pdv{}{t} \vec Q + \div \vec F = 0
{{< /katex >}}
The boundary conditions come into play when defining {{< katex >}} \vec F {{< /katex >}} at the boundary. In particular, we need to know what {{< katex >}} \dd \vec S \cdot \vec F |_{wall} {{< /katex >}} is. In our governing equations, this will involve {{< katex >}} \vec E {{< /katex >}}, {{< katex >}} \vec B {{< /katex >}}, and {{< katex >}} \vec v {{< /katex >}}.

### Insulating Boundary

As a slight modification, an insulating boundary can have a tangential electric field. Consider a simple geometry of parallel electrodes with an insulating wall between them.

<p align="center"> <img alt="Figure 12.8" src="/r/img/12.8.png" /> </p>

From Ohm's law
{{< katex display >}}
\vec E + \vec v \cross \vec B = 0
{{< /katex >}}
so the only way an electric field tangential to the wall can exist is if {{< katex >}} \vu n \cdot \vec v \neq 0 {{< /katex >}}.

For either a perfectly conducting or an insulating boundary, the other variables are arbitrary: {{< katex >}} \rho {{< /katex >}} , {{< katex >}} p {{< /katex >}}, {{< katex >}} \vec v_t {{< /katex >}}, {{< katex >}} \vec B_t {{< /katex >}}.

### Vacuum Region

The plasma (radius {{< katex >}} R_p {{< /katex >}})  is supported by a region of vacuum out to a perfectly conducting wall at some radius {{< katex >}} R_w {{< /katex >}}. We assume that there is no plasma in the vacuum region. The governing equations in vacuum are just Maxwell's equations

{{< katex display >}}
\curl \vec B_{vac} = 0 \qquad \text{and} \qquad \div \vec B_{vac} = 0
{{< /katex >}}

At the wall, 
{{< katex display >}}
\vu n \cross \vec E |_{wall} = 0
{{< /katex >}}
{{< katex display >}}
\left. \vu n \cdot \pdv{\vec B}{t} \right|_{wall} = 0
{{< /katex >}}

What happens at the plasma-vacuum interface? We need to specify jump conditions and continuity conditions. Let's use square brackets to signify a jump:

{{< katex display >}}
\left[ X \right] = \left. X \right|_{R_p + dr} - \left. X \right|_{R_p - dr}
{{< /katex >}}

The normal magnetic field has to be continuous.

{{< katex display >}}
[\vu n \cdot \vec B]_{R_p} = 0
{{< /katex >}}

The tangential magnetic field jump is given by the surface current density at the jump

{{< katex display >}}
\left[ \vu n \cross \vec B \right] _{R_p} = \mu_0 \vec K 
{{< /katex >}}

Integrating {{< katex >}} \grad_\perp (p + \frac{B^2}{2 \mu_0}) = \frac{B^2}{\mu_0} \vec \kappa {{< /katex >}} over a differential volume across the surface gives

{{< katex display >}}
\left[ p + \frac{B^2}{2 \mu_0} \right] _{R_p} = 0
{{< /katex >}}

The plasma shape is determined self-consistently by the wall shape and surface current. This is a free-boundary problem. Another option is to specify the plasma shape, and then determine the required wall shape. This is a fixed-boundary problem.

The most realistic case includes externally applied magnetic fields coming from source coils, perhaps computed by Biot-Savart law. The vacuum magnetic field is then {{< katex >}} \vec B_{vac} = \vec B_{ext} + \vec B_{plasma} {{< /katex >}}. The crazy coil shapes in the stellarator design come from the 3D geometry computations solving this problem.

### Conservation of Magnetic Flux ("Frozen-In" Flux)

Locally, {{< katex >}} \vec E + \vec v \cross \vec B = 0 {{< /katex >}} with Faraday's law
{{< katex display >}}
\pdv{B}{t} = - \curl \vec E = - B \div \vec v + \vec B \cdot \grad \vec v - \vec v \cdot \grad B
{{< /katex >}}
From the continuity equation,
{{< katex display >}}
\pdv{\rho}{t} + \vec v \cdot \grad \rho = - \rho \div \vec v
{{< /katex >}}
Combining we find that
{{< katex display >}}
\dv{\vec B}{t} = \frac{\vec B}{\rho} \dv{\rho}{t} + \vec B \cdot \grad \vec v
{{< /katex >}}
{{< katex display >}}
\rightarrow \dv{}{t} \left( \frac{\vec B}{\rho} \right) = \frac{\vec B}{\rho} \cdot \grad \vec v
{{< /katex >}}

This says that the field and plasma density move together. Locally, if the magnetic field increases then mass density increases, such that the ratio {{< katex >}} \vec B / \rho {{< /katex >}} remains constant. In the direction parallel to the magnetic field we have a term that involves field line twisting, which is a bit more complicated, but in the perpendicular direction
{{< katex display >}}
\dv{}{t} \left( \frac{\vec B}{\rho} \right) _\perp = 0
{{< /katex >}}

If we consider globally the magnetic flux through a moving surface S at velocity {{< katex >}} \vec u {{< /katex >}}. The magnetic flux penetrating the surface is
{{< katex display >}}
\Psi = \int \vec B \cdot \dd \vec S
{{< /katex >}}
or
{{< katex display >}}
\dv{\Psi}{t} = \int \dv{\vec B}{t} \cdot \vu n \dd S
{{< /katex >}}
{{< katex display >}}
= \int \pdv{\vec B}{t}\cdot \vu n \dd S + \oint \vec B \cross \vec u \dd \vec l
{{< /katex >}}
Using Faraday's law

{{< katex display >}}
\dv{\Psi}{t} = \int - \curl \vec E \cdot \vu n \dd S + \oint \vec B \cross \vec u \cdot \dd \vec l
{{< /katex >}}
{{< katex display >}}
= \oint (- \vec E + \vec B \cross \vec u) \cdot \dd \vec l
{{< /katex >}}
Using the electric field from Ohm's law
{{< katex display >}}
\dv{\Psi}{t} = \oint(\vec v - \vec u) \cross \vec B \cdot \dd \vec l
{{< /katex >}}
This tells us that if the surface moves with the plasma {{< katex >}} \vec u = \vec v {{< /katex >}} then 
{{< katex display >}}
\dv{\Psi}{t} = 0
{{< /katex >}}
the flux through the surface is constant, and the flux is a constant of the topology. This is a direct consequence of ideal MHD. If we add even a small amount of resistivity, we dramatically alter the results in a process called "tearing" where the magnetic field "tears" and reconnects with itself.