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


# Infrared Imaging and Two Color Pyrometry - Brett

Motivations for optical methods: Many of the methods of plasma diagnostics provide precise data on the composition of the plasma at the cost of directly influencing the state of the plasma
  - Often sensors cannot withstand exposure to the extreme temperature
  - Noise can be introduced to the system that is difficult to filter - need to isolate sensors electrically or extra post-processing
  - Many sensors are required to adequately determine the temperature profile to a sufficient resolution (often interfering with the data you're trying to collect) - perturbative not great

Optical method features:

- Non-perturbing methods allow various plasma parameters to be directly measured without influencing the plasma.
- IR imaging and two color pyroscopy allow for measurement of the plasma facing components
- Qualitative observations that can predict failure modes

Can be used to diagnose failures in fluid systems - leakage can be readily detected via thermal imaging. Correlation in thermal models to anchor structural models - helpful for determining stresses from CTE, material limits, fatigue, etc..

Why do we care about the temperature in EP devices (such as Hall thrusters)? We care about the life-limiting factors
  - cathode insert life is generally a function of temperature
  - the anode is greatly impacted by erosion that will degrade thruster performance over time (and cause significant mission impact)
  - magnetization will drop as the temperature of the magnet coils increase. Hall thrusters rely upon this magnetic field, will see a significant decrease in efficiency as the magnet coil temperatures rise

## IR imaging theory

What are we measuring? All objects at a temp greater than absolute zero emits photons in the IR range that can be detected.
- Particle motion in warm objects result in charge acceleration or dipole oscillation which produce EM radiation
- In general, the IR emissions from 3 sources will be detected
  - produced by the object due to its temp - some is lost by finite medium transmissibility
  - reflected by the target, sourced by other objects
  - sourced from the medium between the target and camera - vacuum system helps

Camera composition:
  - Lens - focuses infrared light from target
  - Detector - converts to electric impulse
  - Processing electronics
  - User interface

Common detectors
  - Short wavelength (SWIR): 0.9-1.7 \\( \mu m \\)
    - InGaAs
  - Medium wavelength
    - Indium Antimonide
  - Long wavelength
    - SLS
    - HgCdTe
    - Microbolometer

In the study of plasma carrying devices, it is best to use long wavelength detectors for signal clarity - minimize interference between the PFCs and plasma

### Cooled Detectors

- Utilize single photon counting detectors to create the requisite signal for processing. Higher sensitivity than un-cooled detectors
- Cryogenic levels (-200 deg C) must be maintained to avoid blinding the sensor
  - Self irradiance from unit can blind the sensors, making measurements useless
  - Costly to procure and maintain
  - Often significant downtime for maintenance
- Relatively low noise equivalent differential temperature (NEDT)
  - Lower NEDT corresponds to improved resolution
  - Can often resolve 10 mK
- Operating Principles
  - Based on quantum principles. Photoelectric effect raises electrons from valence band to conduction band
  - This changes the conductivity of the material
  - The resulting photocurrent is proportional to the intensity
  - It takes a minimum amount of energy for the photons impacting the detector to elevate the electron from the valence band
  - Peak operating temperature (for camera) higher for shorter wavelength cameras

### Un-cooled detectors

- Photon "masses" required to create signal for imaging electronics
  - Impingement upon resistor laid over large silicon element creates required signal
  - Relies upon bulk change (i.e. temperature) for signal generation
- Higher NEDT than cooled cameras - less sensitive, 30-200mK resolution
- Often provide enough insight into plasma systems to be more useful than cooled systems

<p align="center"> <img alt="52.png" src="/r/img/560/52.png" /> </p>

### Theory


IR imaging is based off classical equations of heat transfer and photo detection. Materials with non-zero emissivity produce infrared radiation that can be detected by an IR camera. Takes advantage of radiative exchange

{{< katex display >}}
M_{bb} = \epsilon(T) \sigma T^4
{{< /katex >}}

Need to define an emissivity to define the emission from a real target. Not constant for any material. In real applications, the rise in temp of the PFCs will alter the emissivity. In applications like EP thrusters, the shift can be measured and is usually small.

The Stefan-Boltzmann equation makes a crucial assumption - that the emissivity over the whole spectral domain (\\( \lambda \\)) is taken into account.
In IR cameras, only a short section of the spectral domain is detected, limiting the effectiveness of the Stefan Boltzmann equation. Instead, the classical definition of the emissivity must be used
{{< katex display >}}
\epsilon(\lambda, T) = \frac{M_\lambda(\lambda, T)}{M_T(\lambda, T)}
{{< /katex >}}

If we examine the surface of interest in order to determine the temperature, the radiation flux from a surface can be defined as

{{< katex display >}}
\dd Q = L \cos \theta \dd S \dd \Omega
{{< /katex >}}

If we make assumption that surface is Lambertian, radiance is identical in all spatial direction, the photonic flux density is just \\( \sin ^2 \theta \Omega \\). If we integrate the equations and alter the radiative power equation for a non-blackbody, we find

{{< katex display >}}
Q = M_\lambda (T) s = \overline{\epsilon} \sigma T^4 S
{{< /katex >}}

While true that this is a simplified case, it's not uncommon in aerospace grade materials. For example, ceramics found in Hall thrusters often are near Lambertian, and can utilized these assumptions.

Over a short range of wavelengths, we can integrate the assumed blackbody photon flux over the spectral domain of interest and multiply by the average emissivity to generate a true photon flux for our measurements

{{< katex display >}}
M_{\Delta \lambda} (T) = \overline{\epsilon}(T) \int _{\Delta \lambda} M_\lambda ^{bb} (\lambda, T) \dd \lambda
{{< /katex >}}

In the case of average emissivity being independent of wavelength, we have what's called a gray body and we can simplify the calculations.

### IR imaging assumptions

- Assume emissivity is known
- Assume a Lambertian material is being used (simplifying assumption)
  - Non-Lambertian materials don't prevent measurements from being made, but researcher needs to be wary of curvature
- Imaging device uses wavelength filter to only take in a certain band of spectral range

### Limitations

- Emissivity changes with temperature
  - Can be mitigated by thorough understanding of material
- Emissivity can change with erosion
- Viewing window must be designed to not block IR radiaiton
  - normal glass not compatible, materials such as sapphire glass must be used
  - what other problems will we have even with "compatible" mediums? finite transmission coefficient
  - solution: fiber optic to bypass viewing windows
- Measurement is only as good as your view
  - poor experiment design may prevent critical measurements
- Limited ability to detect wavelengths (single input signal)
- Emissivity can change dramatically with angle of emission - limits measurements of 3D extended bodies where we do not have a normal view of the surface. Really want to be looking at flat features for qualitative assessment. Depending on material properties, increasing angle of incidence may increase or decrease emissivity.
- Emissivity of materials is highly wavelength dependent - depending on range you're looking at

## Two Color Pyrometry

Need to know the emissivity of the PFCs limit the application of IR imaging. In general, the emissivity of the PFCs will change over time. To overcome limitation, principle is similar to that of single wavelength IR imaging. Two separate signals are ratio'd together. 

<p align="center"> <img alt="53.png" src="/r/img/560/53.png" /> </p>

Planck's law describes the relationship between radiative intensity and wavelength/temperature. Gives \\( u(\lambda, T) \\). Simplifying Planck's law allows us to simplify the model. Assume \\( \exp(- C_2/T \lambda) \gg 1 \\). In the wavelengths and temps we are interested in, there is generally less than 1 degree difference in model using this simplification.

Two color pyrometry allows us to understand absolute temperature without complete knowledge of the emissivity through all space and time

{{< katex display >}}
R_{12} = \sigma_{12} \frac{\epsilon_1 (T)}{\epsilon_2(T)} \left( \frac{\lambda_2}{\lambda_1} \right) ^2 \exp \left( \frac{C_2}{T} \left( \frac{1}{\lambda_2} - \frac{1}{\lambda_1} \right) \right)
{{< /katex >}}

where \\( \sigma_{12} \\) is a constant associated with assuming IR emission assuming black body source. It is assumed that the materials will act as a gray-body
  - Emissivity is not a function of wavelength
  - Deviations from this assumption will increase error

Inverting gives a ratio temperature \\( T_r \\)

{{< katex display >}}
T_r = \left( \frac{ \ln | R_{12} | - \ln \left| \sigma_{12} \left( \frac{\lambda_2}{\lambda_1} \right) ^5 \right|}{C_2 \left( \frac{1}{\lambda_2} - \frac{1}{\lambda_1} \right)} \right)^{-1}
{{< /katex >}}

What this indicates is that a temperature can be extrapolated solely from the irradiance of the material being targeted while analyzed to the wavelengths of interest, independent of emissivity. Based on the ratio temperature, some might be wondering how accurate the ratio temperature is. Luckily, it's simple to extrapolate:

{{< katex display >}}
T = \left( \frac{1}{T_R} - \frac{\ln \left| \frac{\epsilon_1}{\epsilon_2} \right|}{C_2 \left( \frac{1}{\lambda_2} - \frac{1}{\lambda_1} \right)} \right) ^{-1}
{{< /katex >}}

and the temperature error is

{{< katex display >}}
\Delta T = \left| \frac{ \ln \frac{\epsilon_1}{\epsilon_2}}{C_2 \left( \frac{1}{\lambda_2}- \frac{1}{\lambda_1}\right)} \right|
{{< /katex >}}

Error will stem from the difference in wavelengths being measured. Enter multi-color pyrometry. By taking up to 4 colors allows for higher accuracy measurements to be taken. Higher levels of complexity to resolve additional input signals
  - least squares methods common in determining temperature
  - Error varies by the precise method being used
  - Diminishing returns as the number of wavelengths being analyzed increases, 2 color is common, most don't go past 4 color


Questions:

- Emissivity measurement error bars are pretty wide (10 percent). What limits this measurement? Answer: Usual way you measure this is by putting your material in an oven and measuring emission with thermocouples, which can be difficult for an entire setup. Additionally, emissivity can change dramatically with angle of incidence, wavelength, etc. So a better way to reduce this error is by computing emissivity ratios by measuring multiple wavelengths (multi-color pyrometry).


# Coded Aperture Imaging - Matt

Technique for imaging high energy x-rays and gamma rays.

Motivated by the lack of a suitable image forming device for x-ray astronomy. By the 1960's, a pinhole camera was the device by which x-rays were imaged. The pinhole camera projects a 3D image into a 2D plane, with angular resolution determined by the length ratios between the image and source. For a fixed source, this leads to a trade-off between good angular resolution and signal to noise ratio.

Ables and Dicke addressed the problem by introducing a large number of pinholes. The field of view can remain constant while increasing the SNR by having a larger open aperture area - scatter-hole camera.

### Linear imaging system

Linear imaging systems - to first order, let's consider the imaging system as a linear function from the sensor plane  to the detector plane.

\\( E(x, y) = S[I(x, y)] \\)

if the emitting system can be decomposed into a series of point sources

{{< katex display >}}
I(x_0, y_0) = \iint_{-\infty}^{\infty} I(x, y) \delta( x - x_0) \delta (y - y_0) \dd x \dd y
{{< /katex >}}

{{< katex display >}}
 E_0 (x, y) = S\left[ \iint _{- \infty} ^{\infty} I(x, y) \delta (x - x_0) \delta (y - y_0) \dd x \dd y \right]
{{< /katex >}}

Rather than measuring the complete linear response, we define an instrument response function (IRF) which measures how the instrument independently responds to each point. We make an assumption that the instrument does indeed respond independently at each point. We also make an isoplantic assumption, assuming that the mapping does not vary over space. This turns the instrument response function into a point source function.

### Noise in the system

- Vignetting
- Blurring
- Distortions
- Diffraction
- Saturation

Add these into a background noise term \\( N \\)

{{< katex display >}}
E = I \cdot PSF + N
{{< /katex >}}

{{< katex display >}}
E(x, y) = \frac{1}{M^2} \iint _{- \infty} ^\infty I (\frac{x}{M} , \frac{y}{M}) PSF(x - x_0, y-y_0) \dd x_0 \dd y_0
{{< /katex >}}


So, what now? We can remove the correlation between the imaging system and the point source function by taking a Fourier transform. But doing so leads to the Fourier transform of the PSF in the denominator, which contains very small terms that increase the noise. Instead, we can introduce a new re-construction

{{< katex display >}}
\hat {O} = P \cdot G \\
= RO \cdot (A \cdot G) + N \cdot G
{{< /katex >}}

If we can construct a post-processing correlation function \\( G \\) such that the correlation between \\( A \\) and \\( G \\) is approximately a delta function, then we can remove the correlation without major introduction of noise.

{{< katex display >}}
A \cdot G \approx \delta
{{< /katex >}}

The simplest answer is \\( G = A \\). This results in autocorrelation and a postprocessing array that is identical to the aperture. This is simple, but there are some problems

  - Nonflat sidelobes
  - High-frequency fluctuations
  - Lack of signal-to-noise improvement

For a coded aperture, we can have a very large (tens of thousands) of pinholes. This means an exact theory for the response of the system would require the response of tens of thousands of pinholes. Mechanically impossible, so use statistics instead.



Questions:

- How far apart are the spacings in the coded aperture in real devices? I assume they have to be much larger than the diffraction range for x-rays (tens of nm). Answer: The imaging grids are usually on the order of a few centimeters, so for a MURA grid with tens of thousands of apertures you'd get grid spacing in the 10-100 micrometer range.