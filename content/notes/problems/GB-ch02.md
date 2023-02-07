---
title: Gurnett and Battacharjee - Chapter 2
weight: 40
bookToc: false
---

{{< katex display >}}

{{< /katex >}}

### 2.1

{{< tabs "2.1" >}}
{{< tab "Q" >}}

Consider a plasma consisting of electrons and ions of equal number densities, \\( n = n_e = n_i \\), and temperatures \\( T_e \\) and \\( T_i \\). Assume that the electron density is determined by a term of a form \\( e^{e \Phi / k T_e} \\) and that the ion density is determined by a term of the form \\( e^{- e \Phi / kT_i} \\). Show that the Debye length \\( \lambda_D \\) is given by

{{< katex display >}}
\frac{1}{\lambda_D ^2} = \frac{1}{\lambda_{De}^2} + \frac{1}{\lambda_{Di} ^2}
{{< /katex >}}

How do the electron and ion Debye length terms \\( \lambda_{De} \\) and \\( \lambda_{Di} \\) compare if \\( T_e = T_i \\)? Can you find any reason to criticize the basic model used in this calculation?

{{< /tab >}}
{{< tab "A" >}}


Following the method used in the text, we insert a test charge \\( Q \\) and see what the effect on the potential is. But now, we allow both the electrons and ions to move:

{{< katex display >}}
\grad ^2 \Phi = \frac{n}{\epsilon_0} \left( \frac{(-e)(-e) \Phi}{k T_e} + \frac{(e)(e) \Phi}{k T_i} \right)
{{< /katex >}}
{{< katex display >}}
\grad ^2 \Phi = \left(\frac{n e^2}{\epsilon_0 T_e k} + \frac{n e^2}{\epsilon_0 T_i k} \right)\Phi
{{< /katex >}}

The characteristic length of the differential equation is

{{< katex display >}}
\kappa ^2 = \frac{1}{\lambda ^2} = \left(\frac{n e^2}{\epsilon_0 T_e k} + \frac{n e^2}{\epsilon_0 T_i k} \right) = \frac{1}{\lambda_{De}^2} + \frac{1}{\lambda_{Di} ^2}
{{< /katex >}}

If \\( T_e = T_i \\), then \\( \lambda_{De} = \lambda_{Di} \\), but if the electrons and ions have equivalent temperatures and velocity distributions, then they must have the same mass, which definitely isn't the case.

{{< /tab >}}
{{< /tabs >}}

### 2.2

{{< tabs "2.2" >}}
{{< tab "Q" >}}

Consider two superposed slabs of electrons of mass \\( m_e \\) and ions of mass \\( m_i \\). Using the same type of analysis performed in the text, show that the natural oscillation frequency is

{{< katex display >}}
\omega_p ^2 = \omega_{pe} ^2 + \omega_{pi}^2
{{< /katex >}}

where \\( \omega_{pe} \\) and \\( \omega_{pi} \\) are the electron and ion plasma frequencies (assume the ions have charge \\( e \\))


{{< /tab >}}
{{< tab "A" >}}


Let's position the center of the electron slab at \\( x_e \\), and the slab of ions at position \\( x_i \\). The distance we really care about is their separation \\( x \equiv x_i - x_e \\), since this is what determines the electric field between the two.

If \\( x \neq 0 \\), an electric field develops, pointing from the positive slab to the negatively charged slab. We assume the charge density \\( n \\) of each slab is equivalent, so there is no net charge. The field strength is

{{< katex display >}}
E = \frac{n e (x_i - x_e)}{\epsilon_0}
{{< /katex >}}

The equations of motion for the two slabs are:

{{< katex display >}}
m_e \pdv{^2 x_e}{t^2} = - e E
{{< /katex >}}

{{< katex display >}}
m_i \pdv{^2 x_i}{t^2} = e E
{{< /katex >}}

Subtracting the equations of motion,

{{< katex display >}}
\pdv{^2 x_i}{t^2} - \pdv{^2 x_e}{t^2} = \frac{e E}{m_i} + \frac{eE}{m_e}
{{< /katex >}}
{{< katex display >}}
\pdv{^2}{t^2} (x_i - x_e) \frac{e E}{m_i} + \frac{eE}{m_e}
{{< /katex >}}
{{< katex display >}}
\pdv{^2 x}{t^2} \frac{e E}{m_i} + \frac{eE}{m_e}
{{< /katex >}}

{{< katex display >}}
\pdv{^2 x}{t^2} = (\frac{n e^2}{\epsilon_0 m_i} + \frac{n e^2}{\epsilon_0 m_e})x
{{< /katex >}}

Transforming to the frequency domain,

{{< katex display >}}
\omega ^2 = (\frac{n e^2}{\epsilon_0 m_i} + \frac{n e^2}{\epsilon_0 m_e})
{{< /katex >}}
{{< katex display >}}
\omega ^2 = (\frac{1}{\omega_{p e} ^2} + \frac{1}{\omega_{pi}^2})
{{< /katex >}}

{{< /tab >}}
{{< /tabs >}}

### 2.3

{{< tabs "2.3" >}}
{{< tab "Q" >}}

Demonstrate the following relationship between the electron plasma frequency \\( \omega_{pe} \\), the electron thermal speed \\( C_e \\), and the Debye length \\( \lambda_{De} \\):

{{< katex display >}}
C_e = \omega_{pe \lambda_{De}}
{{< /katex >}}

Or, equivalently, defining \\( k_D = 1 / \lambda_D \\),

{{< katex display >}}
k_{De} C_e = \omega_{pe}
{{< /katex >}}

{{< /tab >}}
{{< tab "A" >}}

We just plug in the expressions:

{{< katex display >}}
\omega_{pe}^2 = \frac{n e^2}{\epsilon_0 m_e}
{{< /katex >}}

{{< katex display >}}
\lambda_{De}^2 = \frac{\epsilon_0 k T}{n e^2}
{{< /katex >}}

{{< katex display >}}
C_e ^2 = \frac{kT}{m}
{{< /katex >}}

{{< katex display >}}
C_e ^2 = \frac{kT}{m}
{{< /katex >}}
{{< katex display >}}
C_e ^2 = \frac{\epsilon_0 k T}{n e^2} \frac{n e^2}{\epsilon_0 m} 
{{< /katex >}}
{{< katex display >}}
C_e ^2 = \lambda_{De}^2 \omega_{pe}^2
{{< /katex >}}
{{< katex display >}}
C_e = \omega_{pe \lambda_{De}}
{{< /katex >}}

{{< /tab >}}
{{< /tabs >}}

### 2.4

{{< tabs "2.4" >}}
{{< tab "Q" >}}

A Maxwellian velocity distribution has the form

{{< katex display >}}
f(\vec v) = n_0 \left( \frac{m}{2 \pi k T}\right) ^{3/2} e^{- m v^2 / 2 k T}
{{< /katex >}}

where \\( v^2 = v_x ^2 + v_y ^2 + v_z ^2 \\).

Show that

{{< katex display >}}
\int _{-\infty} ^{\infty} f(\vec v) \dd v_x \dd v_y \dd v_z = n_0
{{< /katex >}}

Show that

{{< katex display >}}
\langle \frac{1}{2} m v_x ^2 \rangle = \frac{1}{2} k T
{{< /katex >}}

Show that 

{{< katex display >}}
\langle \frac{1}{2} m v ^2 \rangle = \frac{3}{2} k T
{{< /katex >}}


{{< /tab >}}
{{< tab "A" >}}

We'll need some Gaussian integrals

{{< katex display >}}
\int _{-\infty} ^{\infty} e^{-ax^2} \dd x = \sqrt{\pi/a}
{{< /katex >}}

So the 0th moment of the Maxwellian velocity distribution is

{{< katex display >}}
\int _{-\infty} ^{\infty} f(\vec v) \dd v_x \dd v_y \dd v_z = \int _{-\infty} ^{\infty} n_0 \left( \frac{m}{2 \pi k T}\right) ^{3/2} e^{- m v^2 / 2 k T} \dd v_x \dd v_y \dd v_z
{{< /katex >}}

{{< katex display >}}
= n_0 \left( \frac{m}{2 \pi k T}\right) ^{3/2} \int _{-\infty} ^{\infty} e^{- m v^2 / 2 k T} \dd v_x \dd v_y \dd v_z
{{< /katex >}}

{{< katex display >}}
= n_0 \left( \frac{m}{2 \pi k T}\right) ^{3/2} \int _{-\infty} ^{\infty} e^{- m (v_x ^2 + v_y ^2 + v_z ^2) / 2 k T} \dd v_x \dd v_y \dd v_z
{{< /katex >}}

{{< katex display >}}
= n_0 \left( \frac{m}{2 \pi k T}\right) ^{3/2} \left(\frac{2\pi kT}{m} \right)^{1/2} \int _{-\infty} ^{\infty} e^{- m (v_x ^2 + v_y ^2) / 2 k T} \dd v_x \dd v_y
{{< /katex >}}

{{< katex display >}}
= n_0 \left( \frac{m}{2 \pi k T}\right) ^{3/2} \left(\frac{2\pi kT}{m}\right) \int _{-\infty} ^{\infty} e^{- m (v_x ^2) / 2 k T} \dd v_x
{{< /katex >}}

{{< katex display >}}
= n_0 \left( \frac{m}{2 \pi k T}\right) ^{3/2} \left(\frac{2\pi kT}{m}\right)^{3/2}
{{< /katex >}}
{{< katex display >}}

\int _{-\infty} ^{\infty} f(\vec v) \dd v_x \dd v_y \dd v_z = n_0
{{< /katex >}}

The average of \\( \frac{1}{2} m v_x ^2 \\) is

{{< katex display >}}
\langle \frac{1}{2} m v_x ^2 \rangle = \frac{\int _{-\infty} ^{\infty} \frac{1}{2} m v_x ^2 f(\vec v) \dd v_x \dd v_y \dd v_z}{\int _{-\infty} ^{\infty} f(\vec v) \dd v_x \dd v_y \dd v_z}
{{< /katex >}}

{{< katex display >}}
= \frac{1}{2} m \left( \frac{m}{2 \pi k T}\right) ^{3/2} \int _{-\infty} ^{\infty} v_x ^2 e^{- m (v_x ^2 + v_y ^2 + v_z ^2) / 2 k T} \dd v_x \dd v_y \dd v_z
{{< /katex >}}

The indefinite quadratic Gaussian integral we'll need is

{{< katex display >}}
\int _{-\infty} ^{\infty} x^2 e^{-ax^2} \dd x = \sqrt{\pi / 4 a^3}
{{< /katex >}}

{{< katex display >}}
\langle \frac{1}{2} m v_x ^2 \rangle =  \frac{1}{2} m \left( \frac{m}{2 \pi k T}\right) ^{3/2} \int _{-\infty} ^{\infty} v_x ^2 e^{- m (v_x ^2 + v_y ^2 + v_z ^2) / 2 k T} \dd v_x \dd v_y \dd v_z
{{< /katex >}}

{{< katex display >}}
= \frac{1}{2} m \left( \frac{m}{2 \pi k T}\right) ^{3/2} \left( \frac{2 \pi k T}{m} \right)^{1/2} \int _{-\infty} ^{\infty} v_x ^2 e^{- m (v_x ^2 + v_y ^2) / 2 k T} \dd v_x \dd v_y
{{< /katex >}}

{{< katex display >}}
= \frac{1}{2} m \left( \frac{m}{2 \pi k T}\right) ^{3/2} \left( \frac{2 \pi k T}{m} \right) \int _{-\infty} ^{\infty} v_x ^2 e^{- m v_x ^2/ 2 k T} \dd v_x
{{< /katex >}}

{{< katex display >}}
= \frac{1}{2} m \left( \frac{m}{2 \pi k T}\right) ^{3/2} \left( \frac{2 \pi k T}{m} \right) \left(\frac{2 \pi k^3 T^3}{m^3} \right)^{1/2}
{{< /katex >}}

{{< katex display >}}
= \frac{1}{2} k T
{{< /katex >}}

The average of the kinetic energy is just

{{< katex display >}}
\langle \frac{1}{2} m v^2 \rangle = \langle \frac{1}{2} m (v_x ^2 + v_y ^2 + v_z ^2) \rangle
{{< /katex >}}

{{< katex display >}}
= \langle \frac{1}{2} m v_x ^2 \rangle + \langle \frac{1}{2} m v_y ^2 \rangle + \langle \frac{1}{2} m v_z ^2 \rangle
{{< /katex >}}

{{< katex display >}}
= \frac{1}{2} k T + \frac{1}{2} k T + \frac{1}{2} k T
{{< /katex >}}

{{< katex display >}}
= \frac{3}{2} k T
{{< /katex >}}

{{< /tab >}}
{{< /tabs >}}

### 2.5

{{< tabs "2.5" >}}
{{< tab "Q" >}}

When we compute the equilibrium potential of a metal object in a plasma (assumed to be a flat plate, i.e. one-dimensional) we need to compute the electron and ion currents incident on the plate.

Assuming that the velocity distribution functions of the electrons and ions are Maxwellians, show that the incident currents are

{{< katex display >}}
J_e = \frac{1}{\sqrt{2 \pi}} e n_e \sqrt{ \frac{k T_e}{m_e}}
{{< /katex >}}

and

{{< katex display >}}
J_i = \frac{1}{\sqrt{2 \pi}} e n_i \sqrt{ \frac{k T_i}{m_i}}
{{< /katex >}}

Assuming that the ion density is \\( n_i = n_0 \\) and that the electron density varies as \\( n_e = n_0 \exp[e \Phi / k T_e ] \\), show that the equilibrium potential \\( V \\) of the plate (i.e. when \\( J_e + J_i = 0 \\)) is given by

{{< katex display >}}
V = - \frac{k T_e}{2e} \left[ \ln \frac{m_i}{m_e} + \ln \frac{T_e}{T_i} \right]
{{< /katex >}}


{{< /tab >}}
{{< tab "A" >}}

We assume that the velocity distributions are

{{< katex display >}}
f(\vec v_e) = n_0 \left( \frac{m_e}{2 \pi k T_e} \right) ^{3/2} e^{(- \frac{1}{2} m_e v^2)/ k T_e}
{{< /katex >}}

{{< katex display >}}
f(\vec v_i) = n_0 \left( \frac{m_i}{2 \pi k T_i} \right) ^{3/2} e^{(- \frac{1}{2} m_i v^2)/ k T_i}
{{< /katex >}}

At thermal equilibrium, we can find the current to the metal plate embedded in the plasma due to random particle motion is

{{< katex display >}}
J _e = e n_e \langle \vec{v}_e \cdot \vu x \rangle 
{{< /katex >}}

where \\( \vu x \\) is normal to the surface. By symmetry we can see that \\( \langle v_e \rangle = 0 \\) if we consider both directions, but at the surface we only take the flux from a single direction and disregard the flux from the wall into the plasma. In spherical coordinates,

{{< katex display >}}
\int _{\text{plate}} \dd \vec v = \int_0 ^\infty \dd v \int _0 ^{\pi / 2} \dd \theta \int _0 ^{2 \pi} \dd \phi v^2 \sin \theta
{{< /katex >}}

and

{{< katex display >}}
\vec{v}_e \cdot \vu x = v \cos \theta
{{< /katex >}}

To find the one-sided flux, we take the inner product from \\( 0 \leq v_e \leq \infty \\) instead of \\( \infty \leq v_e \leq \infty \\):

{{< katex display >}}
J_e = \frac{1}{n_e} \int _{0} ^{\infty} e n_e (\vec{v}_e \cdot \vu x) f(v_e) (\dd \vec v) \\
= e n_e \int _{0} ^{\infty} \dd v \int _{0} ^{\pi / 2} \dd \theta \int _0 ^{2 \pi } \dd \phi (v \cos \theta ) \left( \frac{m_e}{2 \pi k T_e} \right) ^{3/2} e^{(- \frac{1}{2} m_e v^2)/ k T_e} (v^2 \sin \theta) \dd \theta \dd \phi \dd v \\
= e n_e \left( \frac{m_e}{2 \pi k T_e} \right) ^{3/2} \int _0 ^{2 \pi} \dd \phi \int _0 ^ {\pi / 2} \cos \theta \sin \theta \dd \theta \int _0 ^\infty v^3 e^{- \frac{1}{2} m_e v^2 / k T_e} \dd v \\
= e n_e \left( \frac{m_e}{2 \pi k T_e} \right) ^{3/2} (2 \pi) (\frac{1}{2}) \int _0 ^\infty v^3 e^{- \frac{1}{2} m_e v^2 / k T_e} \dd v \\
= e n_e \left( \frac{m_e}{2 \pi k T_e} \right) ^{3/2} (2 \pi) (\frac{1}{2}) \left( \frac{2 k^2 T_e ^2}{m_e ^2} \right) \\
= e n_e \sqrt{\frac{k T_e}{2 \pi m_e}}
{{< /katex >}}

We can carry out the same calculation for the ion current to find

{{< katex display >}}
J_i = e n_i \sqrt{\frac{k T_i}{2 \pi m_i}}
{{< /katex >}}

If we assume that the ion density is \\( n_i = n_0 \\) and the electron density varies as \\( n_e = n_0 \exp[e \phi / k T_e] \\), we can find the potential \\( V = \phi | _{\text{wall}} \\) by equating the electron and ion currents

{{< katex display >}}
J_i + J_e = 0 \\
\frac{1}{\sqrt{2 \pi}} (-e) n_e \sqrt{ \frac{k T_e}{m_e}} + \frac{1}{\sqrt{2 \pi}} e n_i \sqrt{ \frac{k T_i}{m_i}} = 0 \\
n_e \sqrt{ \frac{k T_e}{m_e}} = n_i \sqrt{ \frac{k T_i}{m_i}} \\
n_0 e^{e \phi / k T_e} \left(\frac{k T_e}{m_e}\right)^{1/2} = n_0 \left( \frac{k T_i}{m_i} \right)^{1/2} \\
e^{e \phi / k T_e} = \left( \frac{T_i m_e}{T_e m_i} \right)^{1/2} \\
\frac{e \phi}{k T_e} = \ln \left( \frac{T_i m_e}{T_e m_i} \right)^{1/2} \\
\phi = \frac{k T_e}{e} \ln \left( \frac{T_i m_e}{T_e m_i} \right)^{1/2} \\
\phi = \frac{k T_e}{2e} \ln \left( \frac{T_i m_e}{T_e m_i} \right) \\
\phi = \frac{k T_e}{2e} \left( \ln\frac{T_i}{T_e} + \ln \frac{m_e}{m_i} \right) \\ 
\phi = - \frac{k T_e}{2e} \left( \ln \frac{m_i}{m_e} + \ln\frac{T_e}{T_i} \right) \\ 
{{< /katex >}}

{{< /tab >}}
{{< /tabs >}}

### 2.6

{{< tabs "2.6" >}}
{{< tab "Q" >}}

An infinite plate is immersed in a plasma of number density \\( n_0 \\) and temperature \\( T \\). The plate is located in the \\( x, y \\) plane and is held at a potential \\( V_0 \\) (negative) relative to the potential at a large distance from the plate. By following a procedure very similar to the Debye sheath problem, show that the potential in the plasma is given by

{{< katex display >}}
\Phi = V_0 \exp [- z / \lambda_D]
{{< /katex >}}

where \\( \lambda_D \\) is the Debye length.

{{< /tab >}}
{{< tab "A" >}}



{{< /tab >}}
{{< /tabs >}} 