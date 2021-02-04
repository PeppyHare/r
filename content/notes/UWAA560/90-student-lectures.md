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

## CHEERS (Charge exchange recharge spectroscopy)

Charge exchange process in which an electron from a (usually) neutral atom or molecule (B on LHS) loses an electron to an ion (A on LHS)

{{< katex display >}}
A^+ + B \rightarrow A^\star + B^+
{{< /katex >}}

As a result of this exchange, the ion has become neutralized without losing (much) momentum. Within the context of plasma, injecting a neutral species the same as the plasma ion species prevents plasma contamination.

For an electron associated with an injected neutral beam of hydrogen, the fully stripped impurity ion has a more attractive electric potential than the hydrogen's singly charged nucleus. Still, the electron needs sufficient energy to cross the saddle point to become associated with the impurity ion, that is, its binding energy is approximately the size of the saddle.

How it works: A neutral beam of (usually) hydrogen atoms is injected into a stream of plasma. The neutral beam becomes ionized, while impurity ions gain an electron that then radiates giving us temperature, density, and flow velocity for this otherwise unreadable impurity.

Chord-integrated diagnostic, difficult to distinguish impurity spectra from background bremsstrahlung. Possible coincident lines. Interference of the impurity having a natural single electron population. Imparting the impurities with an electron, they then travel to the core of the plasma or lesewhere where they dissipate radiation without being observed by the diagnostic. Absolute beam intensity, and accurate photon yield cross sections, and spectrometer calibration is required for density measurements  (not as good as bremsstrahlung measurements for density measurements)

Using flow velocity to measure E-field

Using the force balance equation, the electric field can be determined from measuring the flow velocity (for tokamak):

{{< katex display >}}
E_r = u_\phi B_\theta - u_\theta B_\theta + \frac{\grad P_i}{Z e n_i}
{{< /katex >}}

where subscript \\( i \\) indicates the CHEERSing ion. This information can be used to evaluate the \\( E \cross B \\) flow shear which is directly related to the stability of the plasma.

Good for measure the temp and flow velocity of impurities, but challenging for use as impurity density measurement

Requires a way to inject a neutral beam into a plasma, and multiple viewing angles to see flow velocity.


Questions:
 - Scintillator material: momentum transfer
 - What makes a liquid scintillating material more robust to radiation
 - Does scintillator need conductive shielding material thick enough to exclude charged particles? Background easy to filter after the PMT?
