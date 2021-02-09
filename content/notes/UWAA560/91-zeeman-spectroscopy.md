---
title: My class lecture
weight: 910
bookToc: false
---

{{< katex display >}}

{{< /katex >}}

# Zeeman Spectroscopy

## Motivation

In high-energy-density plasmas, the current density distribution is strongly tied to the magnetic field distribution, and in some regions measurement of the B-field is the only way to obtain current density measurements. The magnetic field also determines resistivity, plasma dynamics, and energy balance.

The diagnostic methods to measure localized magnetic fields in plasma make use of the Zeeman effect, the Stark effect, Faraday rotation, or Faraday's law. 

## Zeeman Splitting

The Zeeman effect is the effect of a magnetic field on the states of a bound electron. Discovered by Pieter Zeeman in 1896 when there was very little understanding of quantum mechanics, it was the subject of the 1902 Nobel prize. It was discovered that spectral lines seemed to split in a magnetic field, and the satisfactory explanation had to wait until the development quantum mechanics. A bound electron has two magnetic moments, one associated with the orbital motion

{{< katex display >}}
\vec \mu_l = - \frac{e}{2 m c} \vec L
{{< /katex >}}

and the magnetic moment due to the spin

{{< katex display >}}
\vec \mu_s = - \frac{e}{m c} \vec S
{{< /katex >}}

the classical Hamiltonian of this magnetic moment interacting with an external magnetic field \\( \vec B \\) is

{{< katex display >}}
H_{Zeeman} = - (\vec \mu_l + \vec \mu _s) \cdot \vec B \\
= \frac{e}{2 m c} (\vec L + 2 \vec S) \cdot \vec B \\
= \frac{e}{2 m c} (L_z + 2 S_z) B
{{< /katex >}}

where \\( \hat \mu \\) is the magnetic moment of the electron, \\( m_e \\) is the electron mass, \\( c \\) is the speed of light, \\( \hat L \\) is the angular momentum operator, \\( \hat S \\) is the spin operator, and \\( \vec B \\) is the externally-applied magnetic field we wish to measure. By convention, we choose the z direction to align with \\( \vec B \\). This term is treated as an addition to the "un-perturbed" Hamiltonian

{{< katex display >}}
H = H_0 + H_{fine-structure} + H_{Zeeman}
{{< /katex >}}

Things would be rather simple without incorporating the fine structure term, but alas we cannot discount it entirely. In the fine structure term, there is something like an internal magnetic field in the atom which is responsible for the spin-orbit coupling term. We can treat separately the cases where the external magnetic field is either much smaller or much larger than this internal magnetic field. In the weak case, we treat \\( H_{Zeeman} \\) as a perturbation atop the result of the fine-structure states. In the strong case, the Zeeman effect is assumed to be much stronger than the spin-orbit coupling, so we then take the fine structure Hamiltonian as a perturbation atop \\( H^{(0)} + H_{Zeeman} \\). For the fields which we wish to measure in plasma diagnostics, it is the "weak" Zeeman effect which generally applies. In the "strong" Zeeman effect, known as the Paschen-Back effect, the spin-orbit coupling is broken by the externally applied field, and the line splitting reverts to the normal (total spin 0) Zeeman effect.

For the weak effect, we calculate the expectation values of the perturbing Hamiltonian, which will add to the known energy levels:

{{< katex display >}}
E_{Zeeman} = \frac{e B}{2 m c} \langle \psi | L_z + 2 S_z | \psi \rangle
{{< /katex >}}

As it turns out, this product is completely diagonalizable and the energy level splitting is given by:

{{< katex display >}}
\langle \psi | L_z + 2 S_z | \psi \rangle = \frac{g_J m_j}{\hbar}
{{< /katex >}}
{{< katex display >}}
E_{Zeeman} = g_J \mu_B m_j B
{{< /katex >}}

where \\( g_J \\) is the Landé g-factor
{{< katex display >}}
g_J = 1 + \frac{ j (j+1) + s (s+1) - l (l+1)}{2 j (j+1)}
{{< /katex >}}

and \\( \mu_B = \frac{e \hbar}{2 m_e c} \\) is the Bohr magneton. Two features are of key importance: First, the energy level splitting is proportional to \\( B \\), inviting a measurement of the field by a direct observation of the level splitting. Unfortunately, for most applications the Doppler and Stark broadening are an order of magnitude greater than the Zeeman splitting. Fortunately, conservation of angular momentum gives us another useful property: the polarization of the emitted radiation is dependent on \\( \Delta m \\) (the projection of the total angular momentum in the direction of \\( \vec B \\)). Emission is only possible for \\( \Delta m = [-1, 0, 1] \\). The components for which \\( \Delta m = 0 \\) are called the \\( \pi \\) components, and the components for which \\( \Delta m = \pm 1 \\) are the \\( sigma \\) components. When emission is viewed parallel to \\( \vec B \\), only the \\( \sigma \\) components are observable and the emission is circularly polarized, right handed direction for \\( \Delta m = +1 \\) and circularly polarized, left handed for \\( \Delta m = -1 \\). When viewed perpendicular to \\( \vec B \\), the emission is linearly polarized, with \\( \pi \\) components polarized parallel to \\( \vec B \\) and the \\( \sigma \\) components polarized perpendicular to \\( \vec B \\). Since the Doppler and other broadening effects do not change the polarization of the light, these properties allow for resolution of the Zeeman splitting in the presence of substantial broadening using polarization discrimination techniques.

<p align="center"> <img alt="pres4.png" src="/r/img/560/pres4.png" /> [https://doi.org/10.1029/1999RG900011] </p>

## Low-density magnetic field measurement

Early spectroscopic measurement of the magnetic field in a low-density (\\( \sim 10^{15} cm^{-3} \\)) plasma was carried out by directly measuring the Zeeman splitting in a high-power diode plasma [PhysRevA.39.5856]. At low density high temperature, the Doppler broadening is the main broadening effect. The Zeeman splitting can overcome the Doppler broadening by observing the splitting of long-wavelength emissions (the Zeeman splitting is proportional to \\( \lambda _0 \\)) from heavier ions, in this case BA-II.

## Neutral beam injector

Zeeman spectroscopy can be achieved with the help of neutral beam injection. This is particularly useful in a configuration in which spectral observation of impurity species is not feasible, or when large intrinsic radial electric fields preclude the use of the motional Stark effect (MSE). In a neutral beam injection diagnostic, a neutral beam is injected radially into the plasma. The beam becomes excited by collisions with the plasma, emitting characteristic line radiation which is split by the magnetic field. The optical setup is arranged vertically, perpendicular to the beam injection, in order to obtain radially-resolved measurements with maximum sensitivity to the longitudinal magnetic field.

Considerations for the neutral beam injector:
  - The beam should be of a high enough energy to penetrate well into the plasma. The beam penetration determines the radial extent of the measurement.
  - Extremely low intrinsic ion temperatures are preferable. Doppler broadening is the main obstacle to overcome in resolving the Zeeman splitting, and beam temperature is a major contributor to the linewidth. Sources of \\( \sim 0.1 eV \\) have been demonstrated.
  - The beam current must strike a balance between signal strength and perturbation of the plasma. An extremely low beam current will not produce sufficient line emission, but an excessive beam current has the potential to disrupt the system under study.
  - A tightly focused beam improves the volumetric resolution.

<p align="center"> <img alt="pres3.png" src="/r/img/560/pres3.png" /> [doi:10.1063/1.1526928]</p>

With a sufficiently high signal/noise ratio, the direction and magnitude of the magnetic field can be determined. For example, in the DIII-D diagnostic configuration shown here, the ratio of circular to linear polarization in the \\( \sigma^- \\) line is sufficient to determine the direction of the magnetic field.

Pros:
  - High spatial resolution
  - Applicable even when direction of magnetic field is not known

Cons:
  - Neutral beam injector itself is a substantial addition to the experimental setup. Beam injector requires its own set of diagnostics.
  - Can be perturbative, depending on beam strength

## Measurements of magnetic field in Z-pinches

In a Z-pinch configuration, the magnetic field has a well-defined (azimuthal) direction, and polarization techniques can be used to resolve the Zeeman splitting even when smeared by Doppler and pressure broadening. With a magnetic field of known direction, we have a choice between measuring emissions parallel to the field direction (perpendicular to the axis of symmetry) or perpendicular to the field direction ("end-on" measurements). In the cylindrical geometry, this decision amounts to choosing between chord-integrated and radially-resolved measurements.

### End-on observations

Observing the splitting of line emission end-on allows for radially-resolved measurements:

<p align="center"> <img alt="pres1.png" src="/r/img/560/pres1.png" /> [doi:10.1063/5.0009432] </p>

The polarization of Zeeman-split emissions perpendicular to the magnetic field is completely linear, and both \\( \pi \\) and \\( \sigma \\) components are visible. This was the method used in one of the first measurements of the B-field in a Z-pinch experiment [doi:10.1063/1.872637]. The \\( \sigma \\) and \\( \pi \\) components are orthogonally polarized, so their relative contributions can be determined. The difference between the spectral linewidths is proportional to the magnitude of the magnetic field. In general, the linewidth difference is very small, and the diagnostic requires a very high signal/noise ratio. In this experiment, such a signal/noise ratio required averaging over many discharges, so this measurement is highly dependent on shot reproducibility. Stark and Doppler broadening also limit the applicability of the method; at small radius and high pressure, the linewidth difference becomes too small to determine.

<p align="center"> <img alt="pres2.png" src="/r/img/560/pres2.png" /> [doi:10.1063/5.0009432] </p>

### Vertical (chordal) observations

For a line of sight parallel to the magnetic field, only the circularly polarized \\( \sigma^+ \\) and \\( \sigma ^- \\) components are visible. By combining a quarter-wave plate and a polarizer, we can discriminate between the \\( \sigma^+ \\) and \\( \sigma^- \\) components and observe the wavelength separation. The Doppler and Stark broadenings are polarization independent, so the wavelength shift can still be measured after polarization discrimination. Of the Zeeman splitting diagnostic methods, this has the highest sensitivity to B since it relies on the line positions rather than their shapes.

<p align="center"> <img alt="pres5.png" src="/r/img/560/pres5.png" /> [doi:10.1063/5.0009432] </p>

In a cylindrical geometry like a z-pinch, at first glance it appears that we can only obtain a single measurement along the chord at the outer-most radius of the plasma extent. At other positions, the magnetic field is not parallel to the line of sight, so the emission is elliptically polarized. This has the effect of lowering the perceived Zeeman shift, since the transverse components appear as un-shifted lines. We could perform an Abel inversion of the chord-integrated measurements to recover the radial magnetic field distribution, but in most imploding plasma experiments there is a lack of sufficient azimuthal symmetry and Abel inversion gives misleading results.

There is a significant radial temperature gradient 

<p align="center">
<iframe src="/r/img/560/charge-state-distribution.pdf" width="100%" height="500px"> </iframe>
</p>


## Remote sensing of solar magnetic field

The Zeeman effect provides the most common and useful diagnostic of solar magnetic fields [https://doi.org/10.1029/1999RG900011]. The spectral shapes of emission and absorption lines are altered by the solar magnetic field, and circular and linear polarization are imparted according to the direction of the field. Analysis of the absorption and emission spectra requires assumptions about the structure of the solar atmosphere. Neutral iron (Fe I) is a particularly good source of data about sunspots, as ferromagnetic atoms are especially Zeeman-sensitive and the long-wavelength 630.2 nm absorption lines enhance the splitting effect. By decomposing the polarization of absorbed emission, the direction and strength of the solar magnetic field can be recovered. This is how it was discovered that sunspots are regions of high magnetic flux; weak magnetic fields away from sunspot, then suddenly when you look at the spot the lines split.

## Refs

```
@article{https://doi.org/10.1029/1999RG900011,
  author = {Lites, Bruce W.},
  title = {Remote sensing of solar magnetic fields},
  journal = {Reviews of Geophysics},
  volume = {38},
  number = {1},
  pages = {1-36},
  doi = {https://doi.org/10.1029/1999RG900011},
  url = {https://agupubs.onlinelibrary.wiley.com/doi/abs/10.1029/1999RG900011},
  eprint = {https://agupubs.onlinelibrary.wiley.com/doi/pdf/10.1029/1999RG900011},
  abstract = {New techniques for remote sensing of solar magnetic fields now provide measures of the magnetic field vector within the solar atmosphere with high angular resolution and high precision. These measurements have enabled a much improved physical understanding of magnetic processes and phenomena in the solar atmosphere, processes that drive the variability of the Sun's radiative and particulate output. The new techniques are reviewed here in the context of the scientific advances they have fostered. Emphasis is given to techniques for inferring the field vector. The quantitative nature of the information needed to explore the solar phenomena sharply constrains the needed precision and angular resolution of the observations. These requirements are reviewed here, along with an assessment of how future improvements in observing capabilities will address these requirements. One may also attribute much of the recent advance in our understanding of solar magnetic fields to ongoing progress in techniques for analysis of the polarization measurements that underlie solar magnetometry. The status and prospects of analysis techniques are also reviewed.},
  year = {2000}
}

@article{PhysRevA.39.5856,
  title = {Time-dependent spectroscopic observation of the magnetic field in a high-power-diode plasma},
  author = {Maron, Y. and Sarid, E. and Nahshoni, E. and Zahavi, O.},
  journal = {Phys. Rev. A},
  volume = {39},
  issue = {11},
  pages = {5856--5862},
  numpages = {0},
  year = {1989},
  month = {Jun},
  publisher = {American Physical Society},
  doi = {10.1103/PhysRevA.39.5856},
  url = {https://link.aps.org/doi/10.1103/PhysRevA.39.5856}
}

@article{doi:10.1063/1.872637,
  author = {Davara,G.  and Gregorian,L.  and Kroupp,E.  and Maron,Y. },
  title = {Spectroscopic determination of the magnetic-field distribution in an imploding plasma},
  journal = {Physics of Plasmas},
  volume = {5},
  number = {4},
  pages = {1068-1075},
  year = {1998},
  doi = {10.1063/1.872637},
  URL = {https://doi.org/10.1063/1.872637},
  eprint = {https://doi.org/10.1063/1.872637}
}

@article{Fantz_2006,
  doi = {10.1088/0963-0252/15/4/s01},
  url = {https://doi.org/10.1088/0963-0252/15/4/s01},
  year = 2006,
  month = {oct},
  publisher = {{IOP} Publishing},
  volume = {15},
  number = {4},
  pages = {S137--S147},
  author = {U Fantz},
  title = {Basics of plasma spectroscopy},
  journal = {Plasma Sources Science and Technology},
  abstract = {These lecture notes are intended to give an introductory course on plasma spectroscopy. Focusing on emission spectroscopy, the underlying principles of atomic and molecular spectroscopy in low temperature plasmas are explained. This includes choice of the proper equipment and the calibration procedure. Based on population models, the evaluation of spectra and their information content is described. Several common diagnostic methods are presented, ready for direct application by the reader, to obtain a multitude of plasma parameters by plasma spectroscopy.}
}

@article{Rosenzweig_2017,
  doi = {10.1088/1748-0221/12/09/p09004},
  url = {https://doi.org/10.1088/1748-0221/12/09/p09004},
  year = 2017,
  month = {sep},
  publisher = {{IOP} Publishing},
  volume = {12},
  number = {09},
  pages = {P09004--P09004},
  author = {G. Rosenzweig and E. Kroupp and A. Fisher and Y. Maron},
  title = {Measurements of the spatial magnetic field distribution in a z-pinch plasma throughout the stagnation process},
  journal = {Journal of Instrumentation},
  abstract = {We report on measurements, made for the first time for an imploding plasma at its stagnation, of the magnetic field spatial distribution. Utilized for the measurements is a spectroscopic technique based on simultaneous recording of each of the left- and right-handed circularly polarized Zeeman emissions. While this method allows for overcoming the Stark- and Doppler-broadenings that obscure the Zeeman splitting, it requires a line of sight that is parallel to the magnetic field lines. To this end, the radial charge-state distribution in the stagnating z-pinch plasma was measured, and the method was employed for emission lines of several selected charge states located in various radial locations. This also allowed for measuring the time-resolved magnetic field radial distribution in a single discharge, which is advantageous for high-energy-density plasma experiments. These distributions were measured at various locations along the pinch axis.}
}

@article{doi:10.1063/5.0009432,
  author = {Maron,Yitzhak },
  title = {Experimental determination of the thermal, turbulent, and rotational ion motion and magnetic field profiles in imploding plasmas},
  journal = {Physics of Plasmas},
  volume = {27},
  number = {6},
  pages = {060901},
  year = {2020},
  doi = {10.1063/5.0009432},
  URL = {https://doi.org/10.1063/5.0009432},
  eprint = {https://doi.org/10.1063/5.0009432}
}

@article{doi:10.1063/1.1526928,
  author = {Thomas,D. M. },
  title = {Poloidal magnetic field measurements and analysis with the DIII-D LIBEAM system (invited)},
  journal = {Review of Scientific Instruments},
  volume = {74},
  number = {3},
  pages = {1541-1546},
  year = {2003},
  doi = {10.1063/1.1526928},
  URL = {https://doi.org/10.1063/1.1526928},
  eprint = {https://doi.org/10.1063/1.1526928}
}

@inproceedings{McGonigle2015SimultaneousSD,
  title={Simultaneous Spectroscopic Determination of Ion Temperature, Electron Density, and Magnetic Field for the ZaP-HD Experiment},
  author={Lorcan McGonigle},
  year={2015}
}

```