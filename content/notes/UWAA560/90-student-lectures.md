---
title: Student Lectures
weight: 900
bookToc: false
---

{{< katex display >}}

{{< /katex >}}

# Particle Diagnostics: Neutron diagnostics (Aria)

Start from the basics: what is a neutron? It's a spin \\( 1/2 \\) baryon which interacts with all forces. Primarily decays into usually an electron and an antielectron neutron as well as a proton. Another decay process with 1/1000 of intensity decays to gamma. Mass is \\( 939.6 MeV/c^2 \\), very comparable to proton.

### Where do neutrons come from? They decay quite rapidly - 15 minute lifetime.

 - One of the ways you can make a neutron is through inverse beta decay - a rare process in which an electron antineutrino collides with a proton creating a neutron and positron
 - Spallation from atmospheric muons - creates a background of neutrinos
 - Neutron emission - larger unstable nuclei can produce free daughter neutrons (spontaneous fission, induced fission, photoneutron, spontaneous neutron emission, beta-delayed neutron emission)
 - Nuclear fusion - depending on the size of the nuclei fused, neutrons of a specific energy are emitted. This is the focus of this talk and the focus of neutron diagnostics in fusion plasmas.

In a fusion reaction, neutrons come from the parent nuclei, although not every fusion reaction creates a free daughter neutron. D+T fusion in particular produces a 14.1 MeV daughter neutron and neutral \\( 4He \\). D+D produces a daughter neutron of 2.45 MeV and 3He about 50\% of the time.

### Neutron spectroscopy

You can count the neutrons that come from a fusion reaction, and you can also look at their spectra. One of the best ways to look at the energy of the neutrons is to measure the response in a scintillator which releases a proportional number of photons

{{< katex display >}}
E_p = E_n \sin ^2 \theta
{{< /katex >}}

### Neutron energy classification

The general strategy for detecting neutrons is to collide them with a target nucleus, to produce a charged particle or electromagnetic interaction that can be detected. These processes are
 - recoil nucleus: scintillating materials for fast neutron spectroscopy
 - proton: proportional counters with high pressure He fill gas
 - alpha particle: 6Li and B
 - Fission fragments: 233U, 235U, 239P are the target nuclei
 - Neutron energy dictates a specific detector's desirability

Two major categories of techniques for measuring fast neutrons:
- fast neutron spectroscopy
- cool fast neutrons through mediation before counting

Neutrons of different energies are detected in different ways. Fast neutrons are our main concern (1-20MeV), as they are the products of nuclear reactions. 

In the scintillator, an incident neutron causes an emission of photons from the scintillating material, which make their way to the photocathode. The photocathode feeds into the photomultiplier which feeds a substantial electric pulse. Measurement is done in a time window. The scintillator material might have a characteristic time of some tens of nanoseconds. A few common types used for fast neutron counting and spectroscopy are
- Liquid organic scintillators
- Plastic scintillators
- 3He scintillators

### Liquid organics

- Pros
  - Can distinguish neutrons from x-rays by pulse shape
  - Robust to radiation
  - Cost effective for really big detectors
- Cons
  - Slower response time (100s of ns) makes high count rate applications unreliable
  - Liquid needs a container
  - Oxygen impurity removal

### 3He Scintillator

- Pros
  - Several nanosecond decay time
  - Robust to radiation
- Cons
  - Rare element using 3He
  - Hard to contain as it outgasses readily
  - Under pressure (up to 150 atm)
  - Liquid Ni cold
  - Poor pulse height resolution
  - Cross section for faster neutrons becomes small with increasing energy

### Plastic Scintillator

- Pros
  - Fast pulse response
  - Maintains its own shape
  - Easy to assemble
  - Great cross section with neutrons because of high hydrogen content and fast neutron energy range considerations
  - Decay time is generally 1-4 ns
- Cons
  - No pulse shape discrimination
  - Degrades from radiation exposure

## Photodetectors used for neutron detection

Scintillating materials make a range of photon wavelengths and numbers specific to the material and incident radiation known as a Compton spectrum

Pairing scintillators with photomultipliers requires that they have matching geometry, similar maximum emission (scintillator) and peak (PM) wavelengths

Photomultipliers have different time responses dictating their pulse resolution in time, and thus reliability with high neutron incidence. Increasing distance from source reduces incidence, increasing reliability, however more detectors need to be used for reliable counting measures.

## Photomultiplier Tubes

- Pros
  - Large range of types and characteristics available
  - Slightly higher gain and robustness to temp than a SiPM
  - Generally cheaper than SiPM
- Cons
  - Fragile and light sensitive, even when not in operation
  - Requires stable high voltage supply
  - Active area per dead time is generally greater than SiPMs
  - Some types require magnetic shielding
  - Can have smaller active area, but even with this has larger profile than SiPM

Useful PMT Terminology:
- Dynodes: produce a measurable current at anode of the photomultiplier. Usually a conductor with insulated coating.
- Gain: Total amplification of electron across PM, \\( G = \delta ^n \\)
- Secondary emission factor: gain of each electrode \\( \delta = K V_d \\)
- Linearity: when each stage in PM is proportional to initial cathode current
- Dead time (Pulse width): the finite time required by the detector to process an event
  - Extendable (paralyzable) - detector becomes insensitive to events
  - Non-extendable (non-paralyzable) - detector is still sensitive to events
- Pulse pile up: Non-extendable dead time is a distortion of signal caused by two events with overlapping dead time

## Silicon Photomultipliers (SiPMs)

- Pros
  - Small active area
  - Insensitive to magnetic fields
  - Good photo detection efficiency
- Cons
  - False positives (afterpulse/crosstalk)
  - Finite dynamic range (quasi-analog)
  - Excess voltage dependent noise
  - Strong temperature dependence

## Activation Detectors

Using the daughter particles of neutron collision in a scintillating detector is the strategy of activation detectors. Here, neutrons collide with an arsenic loaded epoxy making gamma of 304, 280, and 24 keV energies. Active detectors have a pulse or current signal produced by a neutron. As you increase neutron energy, cross-section goes way down.

## Neutron Counting

Discarding neutron energy information allows for easier counting. We "thermalize" the neutrons in order to make their cross-section better for counting them up. Proportional tubes used for slow neutron detection. Fill tube with say 3He and \\( BF_3 \\). Charged daughter particles created from the neutron interacting with the fill gas are accelerated to either anode or cathode. The electrons created from the ionizing event collect on the anode producing a readable signal. The applied voltage amplifies the number of ion-electron pairs created in a cascade. To prevent runaway events, a quenching gas is added.

## CHERS (Charge exchange recombination spectroscopy)

Charge exchange process in which an electron from a (usually) neutral atom or molecule (B on LHS) loses an electron to an ion (A on LHS)

{{< katex display >}}
A^+ + B \rightarrow A^\star + B^+
{{< /katex >}}

As a result of this exchange, the ion has become neutralized without losing (much) momentum. Within the context of plasma, injecting a neutral species the same as the plasma ion species prevents plasma contamination.

For an electron associated with an injected neutral beam of hydrogen, the fully stripped impurity ion has a more attractive electric potential than the hydrogen's singly charged nucleus. Still, the electron needs sufficient energy to cross the saddle point to become associated with the impurity ion, that is, its binding energy is approximately the size of the saddle.

How it works: A neutral beam of (usually) hydrogen atoms is injected into a stream of plasma. The neutral beam becomes ionized, while impurity ions gain an electron that then radiates giving us temperature, density, and flow velocity for this otherwise unreadable impurity.

Chord-integrated diagnostic, difficult to distinguish impurity spectra from background bremsstrahlung. Possible coincident lines. Interference of the impurity having a natural single electron population. Imparting the impurities with an electron, they then travel to the core of the plasma or elsewhere where they dissipate radiation without being observed by the diagnostic. Absolute beam intensity, and accurate photon yield cross sections, and spectrometer calibration is required for density measurements  (not as good as bremsstrahlung measurements for density measurements)

Using flow velocity to measure E-field

Using the force balance equation, the electric field can be determined from measuring the flow velocity (for tokamak):

{{< katex display >}}
E_r = u_\phi B_\theta - u_\theta B_\theta + \frac{\grad P_i}{Z e n_i}
{{< /katex >}}

where subscript \\( i \\) indicates the CHERSing ion. This information can be used to evaluate the \\( E \cross B \\) flow shear which is directly related to the stability of the plasma.

Good for measure the temp and flow velocity of impurities, but challenging for use as impurity density measurement

Requires a way to inject a neutral beam into a plasma, and multiple viewing angles to see flow velocity.


Questions:
 - The scintillator needs to be very well isolated from external EM radiation, and needs to be highly internally reflective. Do we also need to worry about excluding charged particles? Answer: By far the biggest concern is isolating our scintillator from EM radiation. The background radiation is the biggest source of noise in the scintillator signal, so we first need to spend a lot of effort making sure that the detector is completely light-tight. If you can leave the detector collecting overnight with extremely low photo background, then you can start worrying about charged particles, etc.


# Ex Situ: ESCA/XPS, Raman Microscopy, Profilometry (Reed)

x-ray photoelectron spectroscopy. Ex situ basically just means off-site, so off site investigation of surface composition and structure

## Electron spectroscopy for chemical analysis (ESCA)

Most favorable due to its theoretical strength, sample versatility, and high information content. Similar to auger electron spectroscopy and high-resolution electron energy loss spectroscopy (HREELS). Based on the photoelectric effect: when a photon collides with an electron, all of the energy of the photon is absorbed by the electron and the electron is emitted.

Simplified ESCA experimental setup:

- Material sample is placed in a vacuum and x-rays are directed onto the sample. Atoms in the sample are emitted by core electrons.
- Photoelectrons are collected and kinetic energy is measured. The magnitude of the kinetic energy contains the binding energy of the electron. Each element has different binding energies for their electrons, so parent element can be identified.
- Relative contribution of different energies can be used to determine the concentration of an element within the sample and morphology of the surface.

When a photon and atom collide, there are three possible events that occur:
- The photon passes through the atom with no interaction
- The photon will lose a portion of its energy due to a collision with an orbital electron (Compton scattering)
- The photon will transfer all of its energy to the orbital electron and eject the electron

Ejections are the important case for ESCA. Photon energy must be sufficient to excite the bound electron. Once electrons start to emit, the number of electrons emitted is a function of intensity of x-ray source and population of the emitting species. Any extra energy over the limit necessary to excite the electron will be added to the electron's energy in a linear fashion (standard photoelectric effect)

{{< katex display >}}
E_B = h \nu - K E
{{< /katex >}}

Whe the sample is conductive, then the sample and spectrometer must be grounded together so that they are at the same Fermi level. For insulating materials, reducing space charge effects can't be done with grounding. Extra electrons must be added to the environment. The energy of the flooding electrons is added to the work function.

<p align="center"> <img alt="50.png" src="/r/img/560/50.png" /> </p>

Peak width and IMFP (inelastic mean free path): Peak width is equal to planck constant over the lifetime of the vacant hole left by the photoelectron. Peak width are larger for inner electrons and for larger atoms.

IMFP: ESCA is surface analysis, but x-rays can penetrate deep into the sample. Photoelectrons liberated deep within the sample will not make it back to the surface, so ESCA has a limited effective depth..

Inelastic scattering tail: Inelastic electrons will have a higher binding energy.

Auger electron emission peaks: Auger peaks can make it to spectrometer. Small compared to signal, and can be differentiated from the photoelectric peaks by switching x-ray sources.

<p align="center"> <img alt="51.png" src="/r/img/560/51.png" /> </p>

Degree of vacuum needed depends on sample being examined. Moderate vacuum is fine for most (\\( 10^{-6} \\) torr), but for reactive samples higher vacuum is needed.

X-ray source: Monochromator limits x-rays projected onto the source to a limited frequency band. Do not want to expose sample directly to x-ray source to avoid noise from Bremsstrahlung electrons.

Electron analyzer: hemispherical electron frequency analyzer splits electrons by energy. Positive and negatively charged hemisphere. The collection lens needs to collect as many electrons as possible to increase signal and protect sample from degradation. 

## Raman Microscopy

Need to look this up on my own

## Profilometry

Method of 3D imaging. Fourier transform profilometry (FTP) works by projecting a uniform fringe pattern over an object and then using an image acquisition sensor to record the deformed fringe pattern. The shape of the object can be found by calculating the Fourier transform, filter the spatial frequency, and then calculate the inverse Fourier transform. The height of the object is given by the phase modulation.

Quasi-sine projection and pi-phase shifting technique: Take two pictures of the fringe deformation. Between shots move the grating half a period. This changes the intensity distribution on the object and this method increases the surface slope that can be measured by threefold.

Two dimension fourier transform profilometry: This method helps measure the general shape of a coarse object that has small randomly distributed structures over its surface. The frequency variations of the small structures are attenuated when they are very far away from the carrier frequency of the light. Using a phase and phase unwrapping algorithms will return a 2D continuous function.

Time-delay and integration cameras: TDI cameras are used in FTP to take a 360 degree image of the object and uses a single strip of structured light to find the height distribution on the objects surface.

Reflectivity should not affect the phase modulation, so you get an accurate measurement even if you don't have a sample of uniform reflectivity.

This is used to determine the surface profile of the cornea when designing contact lenses.

Questions:

- Importance of spectral range of x-ray source? Source must be as monochromatic as possible. Quartz focusing crystal is used to achieve.
- Is the intensity of the transition peak proportional to the abundance of each species? Answer: yes, the cross-section for the absorption is nearly identical for each of the species and the x-ray source frequency is chosen to avoid resonances. The relative abundance of each atomic species appears readily in the intensity ratio (but only for well-calibrated detector!). 
- Since they make use of effects in bound electrons, when are XPS/Raman microscopy applicable to plasma experiments? Answer: Ex situ (off-site) measurements are used to investigate samples after the experiment. Examples like titanium oxidized by an O plasma, divertor components, etc. 