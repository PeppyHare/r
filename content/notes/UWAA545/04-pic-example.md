---
title: PIC - Example Implementation
weight: 40
# bookToc: false
---

{{< katex display >}}

{{< /katex >}}

Notes and details for an electrostatic PIC implementation.

# Dimensions and Normalizations

To make the relevant physics as easy to model and visualize as possible, let's choose units such that .

The fundamental quantities of interest are:

| | Variable | Physical Expression | Computer Value |
|-|-|-|-|
| Number of Particles | `n` | \\( N \\) | Variable (default `128`) |
| System Length | `L` | \\( L \\) | `4π` |
| Grid Cells | `M` | \\( M \\) | `32` |
| Grid Spacing | `dx` | \\( L / M \\) | `1/M`|
|Plasma Frequency \\( (\omega_p) \\) | `wp` | \\( \sqrt{\frac{n q^2}{\epsilon_0 m}} = \sqrt{\frac{N}{\hat{L}} \frac{1}{\epsilon_0}q \frac{q}{m}} \\) | `1` |
| Position | `x[i]` | \\( x_{min} + \frac{j L}{m} \\) | `(x[i] - x_min)/(x_max - x_min)` or `j/m`. This means it is bounded \\( [0, 1] \\) |
| Electric Constant | `eps0` | \\( \epsilon_0 \\) | `1` |
| Charge to Mass Ratio | `qm` | \\( q/m \\) | `-1` |
| Particle Charge | `q` | \\( \frac{\omega_p ^2 (L/N) \epsilon_0}{(q/m)} \\) | `wp**2 * eps0 / (n * qm)` (simplifies to `-1/n`) |
| Particle Mass | `m` | \\( q / (q/m) \\) | `wp**2 * eps0 / (n * qm**2)` (simplifies to `1/n`) |


In SI units, we have:

- \\( x_i \\): Position (meters) of particle \\( i \\) within the range \\( [-\frac{L}{2}, \frac{L}{2}] \\), relative to the center of the periodic domain.
- \\( L \\): Length (meters) of periodic spatial domain
- \\( x_{min} \\): Equal to \\( - L / 2 \\)
- \\( x_{max} \\): Equal to \\( L / 2 \\)
- \\( v_i \\): Velocity (meters/s) of particle \\( i \\).

In computation units, we have normalized counterparts:

- 


# Electrostatic Field Solve


# Particle Push
