## Review Problem 1

!!! question "Current-carrying wire with gap. A large diameter wire of cross-section area \\( A \\)  carries current uniformly over its cross-section. There is a narrow gap of width \\( d \\), forming a parallel-plate capacitor. The current is zero for times \\( t < 0 \\) and the current is \\( I \\) at times \\( t > 0 \\). The charge on the capacitor is zero at \\( t = 0 \\). Neglect fringe fields."
    
    (a) __Find the electric field in the gap.__

    With the normal Gauss' law approach to capacitors
    
{{< katex display >}}
    \vec E = \frac{I t}{\epsilon_0 A} \vu z
    {{< /katex >}}


    (b) __Find the magnetic field in the gap.__

    Faraday's law here
    
{{< katex display >}}
    \int ( \curl \vec B) = \int \mu_0 \epsilon _0 \pdv{ \vec E}{t} \cdot \dd \vec{a}
    {{< /katex >}}

    
{{< katex display >}}
    \rightarrow \oint \vec B \cdot \dd \vec l = \mu_0 \epsilon_0 \frac{I}{\epsilon_0 A} \pi r^2
    {{< /katex >}}

    
{{< katex display >}}
    B \cdot 2 \pi r = \mu_0 \frac{I \pi r^2}{A} \rightarrow \vec B = \frac{\mu_0 I r}{2 A} \vu \phi
    {{< /katex >}}


## Review Problem 2

!!! question "Waves in non-conductors. A laser beam in vacuum has power 20GW and diameter 1 mm. (a) Find the magnitude and direction of the Poynting vector. (b) Find the peak values of the \\( \vec E \\) and \\( \vec B \\) fields. (c) The beam then enters lossless glass having index of refraction 1.6. Assuming no reflection at the air-glass interface and the glass is non-magnetic, find the peak values of the \\( \vec E \\) and \\( \vec B \\) fields. Hint: consider whether the Poynting vector changed."

    To get the magnitude of the Poynting vector, we need to realize that the intensity of the beam is related to the time average of the Poynting vector
    
{{< katex display >}}
    \langle \vec s \rangle = I = \frac{20 \cdot 10^{9}}{\pi (1\text{mm} / 2)^2} \approx 2.5 \cdot 10^{16} \text{W} / \text{m}^2
    {{< /katex >}}

    As for the direction of the Poynting vector, it's always orthogonal to both \\( \vec E \\) and \\( \vec B \\), in the direction of the laser beam (\\( \vu k \\))

    To get the peak values of \\( \vec E \\) and \\( \vec B \\), recall that for monochromatic plane waves (like lasers) the time average of the Poynting vector can be related to the peak value of the field by using the relationship \\( E_0 / B_0 = v \\) and 
    
{{< katex display >}}
    \langle \vec S \rangle = \frac{1}{2} c \epsilon _0 E_0 ^2 \vu {z}
    {{< /katex >}}

    
{{< katex display >}}
    \rightarrow E_0 \approx 4.3 \cdot 10^9 \text{V} / \text{m} 
    {{< /katex >}}

    
{{< katex display >}}
    B_0 = \frac{E_0}{c} \approx 14.3\text{Teslas}
    {{< /katex >}}


    Now, the beam enters a linear medium without any reflection, so the intensity does not change but the electric field will be lessened by the polarization of the material. Note: you could assume that the problem is an artificial scenario (we crank up the intensity of the beam so that the transmission is the same as the original intensity), or we could suppose that the beam enters at the Brewster's angle so that the reflected beam is quenched.

    Within the linear medium, we just replace \\( c \\) with \\( v \\) and \\( \epsilon_0 \\) with \\( \epsilon \\) 
    
{{< katex display >}}
    \langle \vec S \rangle = \frac{1}{2} v \epsilon (E_0 ') ^2
    {{< /katex >}}

    
{{< katex display >}}
    \rightarrow E_0 ' = \sqrt{\frac{2In}{c \epsilon } } = \frac{E_0}{\sqrt{n}}
    {{< /katex >}}

    
{{< katex display >}}
    B_0 = \frac{E_0 '}{v} = \frac{E_0 / \sqrt{n}}{c / n} = B_0 \sqrt{n}
    {{< /katex >}}


## Review Problem 3

!!! question "Waves in conductors. Consider a 1MHz plane wave in a vacuum incident on a thick slab of copper. Copper is a good conductor, non-magnetic, and you can assume its conductivity is \\( 6 \cdot 10^7 \Omega ^{-1}/ m \\). (a) What is the wave's skin depth in the copper? (b) What is the wavelength in vacuum? (c) What is the wavelength in copper? (d) What is the wave's propagation velocity (phase velocity) in vacuum? (e) What is the wave's propagation velocity (phase velocity) in the copper?"

    To get the skin depth, we want \\( d = 1 / \kappa \\). For a good conductor, we simplify the situation with
    
{{< katex display >}}
    \kappa = k  = \sqrt{\frac{\omega \sigma \mu_0}{2}}
    {{< /katex >}}

    
{{< katex display >}}
    \rightarrow d = \sqrt{\frac{2}{\omega \sigma \mu_0}} \approx 65 \mu\text{m}
    {{< /katex >}}


    What wavelength does a 1MHz wave have in vacuum?
    
{{< katex display >}}
    \lambda = \frac{c}{f} = \frac{2 \pi c}{\omega} \approx 300 \text{m}
    {{< /katex >}}


    Now that we're in copper, what is the wavelength?
    
{{< katex display >}}
    \lambda = \frac{2 \pi}{\text{Re}[k]} = 2 \pi d = 2 \pi \sqrt{ \frac{2}{\omega \sigma \mu_0}} \approx 0.4 \text{mm}
    {{< /katex >}}

    So the wavelength has shrunk by a huge factor. The speed of the wave will have dropped significantly in the conductor, while the frequency must match, so it makes sense that the wavelength must also shrink.

    The phase velocity in vacuum is simply \\( c = \omega / k \\) = \\( 3 \cdot 10^8 \\) m/s. In the conductor,
    
{{< katex display >}}
    v = \frac{\omega}{k} = \omega d \approx 400 \text{m}/\text{s}
    {{< /katex >}}


## Review Problem 4

!!! question "Dispersive Gaseous Medium. A dilute gaseous medium is found to exhibit a single optical resonance at frequency \\( \omega_0 = 2\pi \cdot 10^{15} \\) Hz. The electric field of a plane wave at frequency \\( \omega_0 \\) propagating through this medium is attenuated by a factor of two over a distance of 10 meters. The frequency width of the absorption resonance is \\( \Delta \omega \\). (a) What is the absorption coefficient \\( \alpha \\) at resonance? (b) Arrange in ascending order the propagation velocities at frequencies \\( \omega_0, \omega_0 + \Delta \omega / 10 \\), and \\( \omega_0 - \Delta \omega / 10 \\). Show your reasoning. (c) If there were no other resonances in the medium, what are the approximate numerical values of the index of refraction and the propagation velocity on resonance?"

    To recall, for a dilute medium
    
{{< katex display >}}
    n = \tilde{n} = 1 + \frac{Nq^2}{2m\epsilon_0} \sum_j \frac{f_j}{(\omega _j ^2 - \omega_0 ^2 ) - i \gamma_j \omega}
    {{< /katex >}}
 
    
{{< katex display >}}
    \alpha = 2 \kappa \approx \frac{N q^2 \omega^2}{m \epsilon_0 c} \sum_j \frac{ f_j \gamma _j}{(\omega_j ^2 - \omega ^2 ) ^2 + \gamma _j ^2 \omega ^2}
    {{< /katex >}}

    If the field drops by a factor of 2 over 10 meters, and the dissipation goes as \\( E \propto e^{-\kappa z} \\), so
    
{{< katex display >}}
    e^{-\kappa (10m)} = \frac{1}{2} \rightarrow \alpha = 2 \kappa \approx 0.14 m^{-1}
    {{< /katex >}}
 
    To arrange the propagation velocities, we need to remember what the propagation velocity looks like:
    
{{< katex display >}}
    v = \frac{\omega}{k} = \frac{c}{n}
    {{< /katex >}}

    recalling that \\( \dv{n}{\omega} < 0 \\) within the resonance linewidth,
    
{{< katex display >}}
    v( \omega_0 - \Delta \omega / 10 ) < v(\omega_0) < v( \omega_0 + \Delta \omega / 10 ) 
    {{< /katex >}}


    Assuming there are no other resonances, then exactly at resonance \\( n(\omega_0) = 1 \\). Then, \\( v_p(\omega) = \frac{c}{n} = c \\). 


