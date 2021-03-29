---
title: Syllabus
weight: 10
---

{{< katex display >}}

{{< /katex >}}

## Syllabus

- Learn the basis of common computational methods used for plasma physics, specifically, methods applied to magnetic confinement, plasma thrusters, and astrophysics.
- Learn the regions of applicability of the various computational methods.
- Implement a computational method to simulate plasma kinetics using an electrostatic PIC approach.
- Simulate plasma dynamics using a PIC code and an MHD code.

## Motivation

As a motivation for studying computational methods for plasmas, consider the task of analytical methods for arriving at closed-form expressions of the plasma properties. The physical computations of plasmas generally limit analytical methods to very simple configurations and dynamics; it's rather exciting to encounter such a situation, because they occur so infrequently. For example, 1-dimensional, axisymmetric, equilibrium configurations limited to linear stability. To model more complicated, realistic situations, we take a complementary approach using **computational** and **experimental** methods.

Computational methods provide tools for understanding plasma physics. As we'll see in the course, using a basic particle description is not usually possible, leading to the need to derive reduced models. We arrive at reduced models by applying approximations and assumptions to make the problem easier to solve. These approximations inherently limit the applicability and accuracy of the reduced model to whichever regime is appropriate, based on the limits of the approximation.

Experimental methods also require approximations and assumptions and are likewise limited, but their limitations are usually different. It is the contrast between their assumptions that leads to this complementary approach between computational and experimental methods

| Computational Methods | Experimental Methods |
| - | - |
| Known physics, but incomplete (reduced, controllable) models | Unknown physics, complete model (uncontrollable) |
| Deterministic and reproducible | Difficult to identify most important physical effects | 
| Completely diagnosable using nonperturbing diagnostics | Diagnostics can be perturbing, incomplete (chord- or time-integrated, limited, indirect) |

Both approaches are necessary to provide a deeper understanding of the plasma. Many experiments today require computational simulations just to interpret the experimental data (e.g. NIF \\( \rightarrow \\) Hydra, DIII-D \\( \rightarrow \\) EFIT). Further into the course, we will talk about the formal methods we use to combine experimental and computational data, and to quantify the uncertainty in our model (UQ). Uncertainty quantification is used to perform verification and validation (V&V). Verification tells you that you're solving the PDE's correctly, and validation says that you have the correct PDE's for the experiment.

## Course Format

- All submitted material should be publication quality, i.e. typeset, clearly organized and written.
- Students will write a 1D, electrostatic PIC code based on the Vlasov-Poisson plasma model. The code, a run script or instructions, and a report describing their code will be submitted.
- The PIC code will be used to perform several "computer mini-projects" which compare the numerical results to theory. The project reports should follow the format for PRL submissions (4 typeset pages including plots). Download the PRL template.
- Students will write an MHD fluid code that will calculate plasma equilibrium, linear stability, and nonlinear dynamics. They will apply their code to two equilibria and compare the numerical results to theoretical expectations. The computer projects will be presented in class at the end fo the quarter. Students will submit a report describing their code, applications, and comparison to theory at the end of the quarter. This report should also follow the PRL submission format.
- Students will be required to formulate and ask one question of each presenter. The question and response must be written and submitted by the questioner.


## Course topics

1. Plasma Models: particle model, kinetic model, multi-fluid model, single fluid (MHD) model, hybrid models
2. Nonlinear Dynamics: PIC methods; continuum kinetics; gyrokinetic; multi-fluid; methods for MHD (div B issues, energy vs. pressure-based); finite element methods
3. Transport: Monte Carlo methods; Fokker-Planck model
4. Equilibrium: elliptic governing equation; elliptic numerical methods (direct vs. iterative, relaxation, CG, MG)
5. Linear Stability; eigenvalue formulation (self-adjoint, Rayleigh quotient, relaxation, shooting method); time integration of governing equation.
6. Uncertainty Quantification: verification and validation; combining computational and experimental data.
