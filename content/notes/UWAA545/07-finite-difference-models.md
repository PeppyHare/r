---
title: Finite Difference Methods for MHD
weight: 70
# bookToc: false
---

# Finite Difference Methods for MHD

So for 1D MHD, we want to derive algorithms to advance the governing equations in time that have the form

{{< katex display >}}
\pdv{\vec Q}{t} + \pdv{\vec F}{x} = 0
{{< /katex >}}

We can use the advection equation as a model equation:
{{< katex display >}}
\pdv{u}{t} + a \pdv{u}{x} = 0
{{< /katex >}}
which has the general solution
{{< katex display >}}
u(x - at) = \text{const.} = u(x, t=0)
{{< /katex >}}

If we apply a forward Euler finite difference operators to our PDE,

{{< katex display >}}
\frac{u_j ^{n+1} - u^n _j}{\Delta t} + a \frac{u _{j+1} ^n - u_{j-1} ^n}{2 \Delta x} = 0
{{< /katex >}}

## Stability

A brief von Neumann stability analysis shows that this forward Euler differencing is unstable. The way von Neumann stability analysis works, we assume a wave structure for the solution
{{< katex display >}}
u_j ^n = A^n e^{i k x} = \underbrace{A ^n}_{\text{wave amplitude}} \cdot \overbrace{e^{i k j \Delta x}}^{\text{wave structure}}
{{< /katex >}}

If we substitute this form into our finite difference expression, we have

{{< katex display >}}
A^{n+1} e^{i k j \Delta x} = A^n e^{i k j \Delta x} - \frac{a \Delta t}{2 \Delta x}\left(A^n e^{i k (j+1) \Delta x} - A^n e^{i k (j-1) \Delta x} \right)
{{< /katex >}}
We're interested in the growth of the amplitude \\( A^n \\), called the amplification factor \\( G \\):
{{< katex display >}}
G  \equiv \frac{|A^{n+1}|}{|A^n|}
{{< /katex >}}

For forward Euler, we find 
{{< katex display >}}
\begin{aligned}
\frac{A^{n+1}}{A^n} & = &   1 - \frac{a \Delta t}{2 \Delta x} \left( e^{i k \Delta x} - e^{- i k \Delta x} \right) \\
& = & 1 - \frac{i a \Delta t}{\Delta x} \sin (k \Delta x) \\
G & = & \sqrt{\left( \frac{A^{n+1}}{A^n} \right) \left( \frac{A^{n+1}}{A^n} \right)^\star} \\
& = & \sqrt{1 + \left( \frac{a \Delta t}{\Delta x}\right) ^2 \sin ^2 (k \Delta x)} \\
& \geq & 1 \quad \text{if} \quad \Delta t > 0
\end{aligned}
{{< /katex >}}

<p align="center"> <img alt="33.png" src="/r/img/545/33.png" /> </p>

We find that the forward time, centered space (FTCS) algorithm is unconditionally unstable, for any values of \\( k \\), \\( \Delta t > 0 \\). Not a very good choice for solving the advection equation! However, the FTCS algorithm is an important component of many finite difference schemes which **are** stable.

Physically, the difficulty with the advection term can be seen in the continuity equation

{{< katex display >}}
\pdv{\rho}{t} + \vec v \cdot \grad \rho = - \rho \div \vec v = 0 \quad \text{(incompressible)}
{{< /katex >}}

Using the FTCS difference approach to compute the gradients, we're assuming that the gradient at node \\( j \\) is constant over the time interval \\( n \rightarrow n + 1 \\). This is only valid if the density profile is linear, and for non-linear profiles the gradient is inaccurate. 

<p align="center"> <img alt="34.png" src="/r/img/545/34.png" /> </p>

If we approximate the gradient of the density as

{{< katex display >}}
\pdv{\rho}{x} \approx \frac{\rho _{j+1} - \rho_{j - 1}}{2 \Delta x}
{{< /katex >}}

then we get an error that is the difference between the line tangent at \\( j - 1 \\) and the line tangent at \\( j \\). We should actually calculate the gradient at \\( t + \Delta t / 2 \\) (assuming the flow is in the positive direction). The error leads to an over-estimate of the gradient magnitude, which leads to oscillations, which ultimately leads to instability.

## Stable Solution Approaches for Advection Equation

There are a few approaches we can take to come up with a finite differencing scheme which avoids this instability.

1. Since the error is oscillating positive and negative, we can add diffusion to smooth out the error. This is the same as applying a time-average of the error to smooth the solution.

<p align="center"> <img alt="35.png" src="/r/img/545/35.png" /> </p>

Spatial smoothing also works:

<p align="center"> <img alt="36.png" src="/r/img/545/36.png" /> </p>

Noting that G increases with \\( k \Delta x \\), the shortest wavelengths grow the fastest, which is why a diffusive term helps smooth out the instability.

2. Since the error is caused by computing the gradient at the wrong location, e.g. \\( x_j \\) instead of \\( x_j - v \Delta t / 2 \\), we can use upwind differencing

{{< katex display >}}
\delta _x \rho _j = \begin{cases}
\frac{\rho _j - \rho _{j-1}}{\Delta x} & \quad & \text{ if} \quad v \geq 0 \\
\frac{\rho_{j+1} - \rho_j}{\Delta x} & \quad & \text{if } v < 0
\end{cases}
{{< /katex >}}

3. Flux can be calculated as before, but we can apply limits to prevent minima or maxima from developing. Some approaches like this in the literature are
- total variation diminishing
- total variation bounded
- flux corrected transport

4. Eliminate the advection term, or reduce it. If we write out the MHD equations in such a way that the advection term \\( \vec v \cdot \grad \\) is split out from the rest:

{{< katex display >}}
\pdv{\rho}{t} + \vec v \cdot \grad \rho = - \rho \div \vec v
{{< /katex >}}
{{< katex display >}}
\pdv{\vec v}{t} + \vec v \cdot \grad \vec v = ( - \grad p + \vec j \cross \vec B) / \rho
{{< /katex >}}
{{< katex display >}}
\pdv{\vec B}{t} + \vec v \cdot \grad \vec B = - \vec B \div \vec v + \vec B \cdot \grad \vec v
{{< /katex >}}
{{< katex display >}}
\pdv{p}{t} + \vec v \cdot \grad p = - \Gamma p \div \vec v
{{< /katex >}}

If we let the grid move at the fluid velocity \\( \vec v \\)

{{< katex display >}}
\vec u _{grid} = \vec v
{{< /katex >}}

then the advection term becomes

{{< katex display >}}
\vec v \cdot \grad \rightarrow ( \vec v - \vec u _{grid}) \cdot \grad
{{< /katex >}}

which vanishes. Codes like this, expressing the equations of motion in Lagrangian frame of reference, are generally called ALE codes (Arbitrary Lagrangian Eulerian).

### Method 1: Lax Algorithm

To solve

{{< katex display >}}
\pdv{u}{t} + a \pdv{u}{t} = 0
{{< /katex >}}

we had written the FTCS finite difference scheme:

{{< katex display >}}
u_j ^{n+1} = u_j ^n - \frac{a \Delta t}{2 \Delta x} \left( u_{j+1} ^n - u_{j-1} ^n \right)
{{< /katex >}}

We can add diffusion by replacing \\( u_j ^n \\) with a local spatial average, giving us the Lax algorithm:

{{< katex display >}}
u_j ^n \rightarrow \frac{u_{j+1} ^n + u_{j - 1} ^n}{2} \quad \text{Lax Algorithm}
{{< /katex >}}

If we apply the same von Neumann stability analysis as before, we find that

{{< katex display >}}
G = \sqrt{1 - \left[1 - \left(\frac{a \Delta t}{\Delta x}\right)^2 \right] \sin ^2 (k \Delta x)}
{{< /katex >}}
So we have a stable solution if
{{< katex display >}}
\left| \frac{a \Delta t}{\Delta x} \right| \leq 1 \quad \text{Courant condition}
{{< /katex >}}

This condition (also called the CFL condition) shows up quite a lot in fluid dynamics algorithms. It effectively limits the time step
{{< katex display >}}
\Delta t \leq \Delta x / a
{{< /katex >}}

If we carry the substitution through our finite difference equation, we can see how the Lax method really does add a diffusion term:

{{< katex display >}}
u_j ^{n+1} = \underbrace{u_j ^n - \frac{a \Delta t}{2 \Delta x} (u_{j+1} ^n - u_{j - 1} ^n)}_{\text{FTCS}} + \underbrace{\left( \frac{u_{j+1} ^n - 2 u_j ^n + u_{j-1} ^n}{2} \right)}_{\text{Lax modification}}
{{< /katex >}}

Manipulating the terms a bit,

{{< katex display >}}
\frac{u_j ^{n+1} - u_j ^n}{\Delta t} + a \left( \frac{u_{j+1} ^n - u_{j-1} ^n}{2 \Delta x} \right) = \frac{\Delta x^2}{2 \Delta t} \left( \frac{u_{j+1} ^n - 2 u_j ^n + u_{j-1} ^n}{\Delta x ^2} \right)
{{< /katex >}}

which approximates the PDE

{{< katex display >}}
\underbrace{\pdv{u}{t} + a \pdv{u}{x}}_{\text{original PDE}} = \underbrace{\frac{\Delta x ^2}{2 \Delta t} \pdv{^2 u}{x^2}}_{\text{diffusion term}}
{{< /katex >}}

In the limit of \\( \Delta x \rightarrow 0 \\) goes to zero, the diffusion term disappears and we recover the original PDE. It has the unfortunate property that the diffusion term grows as \\( \Delta t \rightarrow 0 \\), so we only retain accuracy as long as \\( \Delta x ^2 \\) goes to zero faster than \\( \Delta t \\).

### Lax-Wendroff Algorithm

Another algorithm known as the Lax-Wendroff algorithm can be less diffusive and is better behaved. It's also derived from a more mathematically rigorous method than the Lax method. We get it through a process called a Cauchy-Kowalevskaya method. 

We can derive Lax-Wendroff as a 2-step method:

1. Use the Lax algorithm to advance the solution from \\( t \\) to \\( t + \Delta t / 2 \\)
2. Use the leapfrog algorithm to advance from \\( t \\) to \\( t + \Delta t \\)

{{< katex display >}}
u_{j + 1/2} ^{n + 1/2} = \frac{u_{j+1} ^n + u_j ^n}{2} - \frac{a \Delta t}{2 \Delta x} \left( u_{j + 1} ^n - u_j ^n \right) \quad \text{(Lax advance)}
{{< /katex >}}

{{< katex display >}}
u_j ^{n+1} = u_j ^n - \frac{a \Delta t}{\Delta x} \left(u _{j + 1/2} ^{n + 1/2} - u _{j - 1/2} ^{n + 1/2} \right) \quad \text{(Leapfrog advance)}
{{< /katex >}}

If we write out the stencil for Lax-Wendroff, we see that the algorithm is properly centered

<p align="center"> <img alt="37.png" src="/r/img/545/37.png" /> </p>

For linear equations, the two steps can be combined, and we can see that it's nothing but the combination of FTCS with a diffusion term

{{< katex display >}}
u_j ^{n+1} = u_j ^n - \underbrace{\frac{a \Delta t}{2 \Delta x} \left( u_{j + 1} ^n - u_{j - 1} \right)}_ {\text{FTCS}} + \underbrace{\frac{a^2 \Delta t^2}{2 \Delta x ^2} \left( u_{j+1} ^n - 2 u_j ^n + u_{j - 1} ^n \right)} _{\text{Diffusion}}
{{< /katex >}}

which approximates the PDE

{{< katex display >}}
\pdv{u}{t} + a \pdv{u}{x} = \frac{a^2 \Delta t}{2} \pdv{^2 u}{x ^2}
{{< /katex >}}

Lax-Wendroff has an accuracy of \\( \mathcal{O}(\Delta t ^2, \Delta x^2) \\). Because of this, it's a very useful algorithm.

If the system is non-linear, then we do apply Lax-Wendroff as a 2-step process. For instance, if we look at the form of the MHD equations,

{{< katex display >}}
\pdv{\vec Q}{t} + \pdv{\vec F}{x} = 0
{{< /katex >}}

The first Lax advance will be

{{< katex display >}}
Q_{j + 1/2} ^{n + 1/2} = \frac{Q_{j + 1} ^n + Q_j ^n}{2} - \frac{\Delta t}{2 \Delta x} \left( F_{j + 1} ^n - F_j ^n \right)
{{< /katex >}}

and the leapfrog advance is

{{< katex display >}}
Q_j ^{n + 1} = Q_j ^n - \frac{\Delta t}{\Delta x} \left( F_{j + 1/2} ^{n + 1/2} - F_{j - 1/2} ^{n + 1/2} \right)
{{< /katex >}}

There is a way to generalize the Lax-Wendroff procedure, which produces the class of Lax-Wendroff-type algorithms. To step from \\( n \\) to \\( n + 1 \\), we first compute the solution at an intermediate step \\( n + \alpha \\) at some intermediate grid points \\( j + \beta \\). These algorithms are described by the stencil:

<p align="center"> <img alt="38.png" src="/r/img/545/38.png" /> </p>

For \\( \alpha = \beta = \frac{1}{2} \\), we get the Lax-Wendroff algorithm we just described. There's another useful algorithm known as the MacCormack algorithm, for which \\( \alpha = 1, \beta = 0 \\):

{{< katex display >}}
\overline{Q}_j = Q _j ^n - \frac{\Delta t}{\Delta x} \left( F_{j + 1} ^n - F_{j} ^n \right) \quad \text{(predictor step)}
{{< /katex >}}
{{< katex display >}}
\overline{\overline{Q}}_j = Q_j ^n - \frac{\Delta t}{\Delta x} \left( \overline{F}_j - \overline{F} _{j - 1} \right) \quad \text{(corrector step)}
{{< /katex >}}
{{< katex display >}}
Q_j ^{n + 1} = \frac{\overline{Q}_j + \overline{\overline{Q}}_j}{2} = \frac{\overline{Q}_j + Q_j ^n}{2} - \frac{\Delta t}{2 \Delta x} \left( \overline{F}_j - \overline{F}_{j - 1} \right)
{{< /katex >}}
where \\( \overline{F}_j = F(\overline{Q}_j) \\). The MacCormack algorithm is also \\( \mathcal{O}(\Delta t ^2, \Delta x ^2) \\). In some cases it can be better (more stable) for multi-dimensional problems.

We've written these algorithms out in 1D. In 3D MHD, we can write out our system of equations as:

{{< katex display >}}
\pdv{\vec Q}{t} + \pdv{\vec F}{x} + \pdv{\vec G}{y} + \pdv{\vec H}{z} = 0
{{< /katex >}}

We can write the predictor step as

{{< katex display >}}
\overline{Q} _{i,j,k} = Q^n _{i,j,k} - \frac{\Delta t}{\Delta x} \left( F _{i+1, j, k} - F _{i, j, k} ^n \right) - \frac{\Delta t}{\Delta y} \left( G _{i, j+1, k} - G _{i, j, k} ^n \right) - \frac{\Delta t}{\Delta z} \left( H _{i, j, k+1} - H _{i, j, k} ^n \right)
{{< /katex >}}

and the corrector step as

{{< katex display >}}
\begin{aligned}
\overline{\overline{Q}}_{i, j, k} & = & Q _{i, j, k} ^n - \frac{\Delta t}{\Delta x} \left( \overline{F}_{i, j, k} - \overline{F}_{i-1, j, k} \right)  - \frac{\Delta t}{\Delta y} \left( \overline{F}_{i, j, k} - \overline{F}_{i, j-1, k} \right) \\ & &  - \frac{\Delta t}{\Delta z} \left( \overline{F}_{i, j, k} - \overline{F}_{i, j, k-1} \right)
\end{aligned}
{{< /katex >}}

{{< katex display >}}
Q_{ijk} ^{n + 1} = \frac{\overline{Q} + \overline{\overline{Q}}}{2} 
{{< /katex >}}

To ensure stability, the domain of dependence must be contained in the numerical domain of dependence. If we plot out the slope of the zone of dependence, the physical domain has a slope \\( |1 / \lambda_{max}| \\), while the numerical domain has a slope \\( |\Delta t / \Delta x| \\):

<p align="center"> <img alt="39.png" src="/r/img/545/39.png" /> </p>

which gives us the stability condition:
{{< katex display >}}
\frac{\Delta t}{\Delta x} \left| \lambda _{max} \right| \leq 1
{{< /katex >}}

where \\( \lambda_{max} \\) is the maximum eigenvalue of the flux Jacobian \\( \pdv{\vec F}{\vec Q} \\). In 2D, we have

{{< katex display >}}
\frac{\Delta t}{\Delta x} \left| \lambda _{A, max} \right| + \frac{\Delta t}{\Delta y} \left| \lambda _{B, max} \right| \leq 1
{{< /katex >}}

where \\( \vec A = \pdv{\vec F}{\vec Q} \\) and \\( \vec B = \pdv{\vec G}{\vec Q} \\).

In standard gas dynamics, where the situation is much simpler, the eigenvalues are \\( \lambda_A = (u, u + v_s, u - v_s) \\), where \\( v_s \\) is the sound speed. The stability condition is then:

{{< katex display >}}
\Delta t \leq \left( \frac{|u| + v_s}{\Delta x} + \frac{|v| + v_s}{\Delta y} \right)
{{< /katex >}}

For high speed flows, which have \\( v > \lambda \\) for any of the characteristic speeds, sometimes additional diffusion is necessary:

{{< katex display >}}
\pdv{\vec Q}{t} + \pdv{\vec F}{x} + \pdv{\vec G}{y} + \pdv{\vec H}{z} = \sigma \grad ^2 \vec Q
{{< /katex >}}

This diffusivity can be added after we perform an update. For example, for the 2D MacCormack algorithm we can write

{{< katex display >}}
\left( Q_{i, j} ^{n + 1} \right)' = Q_{ij} ^{n + 1} + \Delta t \sigma \left[ \frac{\left( Q_{i + 1, j} ^{n + 1} - 2 Q_{i, j} ^{n + 1} + Q_{i-1, j} ^{n + 1}\right)}{\Delta x^2} + \frac{\left( Q_{i, j+1} ^{n + 1} - 2 Q_{i, j} ^{n + 1} + Q_{i, j-1} ^{n + 1}\right)}{\Delta y^2}\right]
{{< /katex >}}

This helps to smooth out the oscillations that can result from a steep change in \\( Q \\):

<p align="center"> <img alt="40.png" src="/r/img/545/40.png" /> </p>

We can set \\( \sigma \\) to a constant everywhere, and a typical value might be

{{< katex display >}}
\frac{\sigma \Delta t}{\Delta x^2} < 0.25
{{< /katex >}}

You can also make \\( \sigma \propto \div \vec v \\), so that we only add diffusion in the region of shocks or supersonic flows.

### Method 2: Upwind Difference Flux

Going back to our model equation can write the advection equation as

{{< katex display >}}
\pdv{u}{t} + a \pdv{u}{x} = 0
{{< /katex >}}
{{< katex display >}}
\pdv{u}{t} + \pdv{f}{x}  = 0 \qquad (f = au)
{{< /katex >}}

The simple upwind difference is expressed as

{{< katex display >}}
u_j ^{n+1} = u_j ^n - \frac{a \Delta t}{\Delta x} \begin{cases} (u_j ^n - u_{j-1} ^n) \quad &\text{if}& a \geq 0 \\
(u_{j+1} ^n - u_{j} ^n) \quad &\text{if}& a \geq 0 \end{cases}
{{< /katex >}}

<p align="center"> <img alt="41.png" src="/r/img/545/41.png" /> </p>

This works easily enough for the advection equation, but it does not work in general for systems of equations, because we can characteristics which are both positive and negative. We can not, for example, write

{{< katex display >}}
Q_j ^{n+1} = Q_j ^n - \frac{\Delta t}{\Delta x} \begin{cases} (F_j ^n - F_{j-1} ^n) \quad &\text{if} \quad  \lambda \geq 0 \\ (F_{j+1} ^n - F_{j} ^n) \quad &\text{if} \quad \lambda < 0 \end{cases}
{{< /katex >}}

Because in general \\( \lambda_i \\) will take both positive and negative values. In gas dynamics, \\( \lambda = (v, v + v_s, v - v_s) \\). In ideal MHD, we have seven waves:

{{< katex display >}}
\lambda = v, v \pm v_A, v \pm v_{\text{fast}}, v \pm v_{\text{slow}}
{{< /katex >}}

From a point \\( Q_j ^n \\), waves of each of the characteristics propagate within their own domains:

<p align="center"> <img alt="42.png" src="/r/img/545/42.png" /> </p>

In regions \\( (1) \\) and \\( (2) \\), no information can propagate faster than the fastest characteristic \\( (v \pm v_f) \\). At any point in time, we can draw a horizontal line to see the extent of each domain. At any point in time, some eigenvalues are positive and some are negative. As drawn, \\( v - v_f \\) and \\( v - v_A \\) are negative, and the rest are positive.

To apply an upwind difference, we must split the flux into right- and left-going components

{{< katex display >}}
F = F^+ + F^-
{{< /katex >}}

Re-writing our original PDE:

{{< katex display >}}
\pdv{Q}{t} + \pdv{F}{x} = 0
{{< /katex >}}
{{< katex display >}}
\pdv{Q}{t} + \pdv{F^+}{x} + \pdv{F^-}{x} = 0
{{< /katex >}}

we can now apply upwind differencing

{{< katex display >}}
\frac{Q_j ^{n+1} - Q_j ^n}{\Delta t} + \frac{F_j ^+ - F_{j - 1} ^+}{\Delta x} + \frac{F_{j+1} ^- - F_j ^- }{\Delta x} = 0
{{< /katex >}}

To split \\( F \\) into \\( F^+ \\) and \\( F^- \\), we manipulate the original PDE using the flux Jacobian.

{{< katex display >}}
\pdv{Q}{t} + \pdv{F}{Q} \pdv{Q}{x} = 0
{{< /katex >}}
{{< katex display >}}
\rightarrow \pdv{Q}{t} + A^+ \pdv{Q}{x} + A^- \pdv{Q}{x} = 0
{{< /katex >}}

where now \\( A^+ \\) and \\( A^- \\) are the flux Jacobians of \\( F^+ \\) and \\( F^- \\). The eigenvalue decomposition of \\( A \\) is

{{< katex display >}}
A X = X \Lambda
{{< /katex >}}

where \\( \Lambda \\) is the diagonal matrix of eigenvalues and \\( X \\) is the matrix of eigenvectors. This means we can write \\( A \\) as

{{< katex display >}}
A = X \Lambda X^{-1}
{{< /katex >}}

We can split our PDE into right- and left-going components as:

{{< katex display >}}
\pdv{Q}{t} + X \Lambda X^{-1} \pdv{Q}{x} = 0
{{< /katex >}}
{{< katex display >}}
\pdv{Q}{t} + X \Lambda ^+ X^{-1} \pdv{Q}{x} + X \Lambda ^- X^{-1} \pdv{Q}{x} = 0
{{< /katex >}}

where \\( \Lambda ^+ \\) is the diagonal matrix of only right-going eigenvalues, and \\( \Lambda^- \\) is a diagonal matrix of only right-going eigenvalues.

For gas dynamics, the eigenvalues are \\( v, v \pm v_s \\) with \\( 0 < v < v_s \\)

{{< katex display >}}
\Lambda = \begin{bmatrix} v & 0 & 0 \\ 0 & v + v_s & 0 \\ 0 & 0 & v - v_s \end{bmatrix} \\ = \Lambda ^+ + \Lambda ^-
{{< /katex >}}
{{< katex display >}}
\Lambda ^+ = \begin{bmatrix} v & 0 & 0 \\ 0 & v + v_s & 0 \\ 0 & 0 & 0 \end{bmatrix}
{{< /katex >}}
{{< katex display >}}
\Lambda ^- = \begin{bmatrix} 0 & 0 & 0 \\ 0 & 0 & 0 \\ 0 & 0 & v - v_s \end{bmatrix}
{{< /katex >}}

Now we can properly upwind difference the flux by defining the flux at grid midpoints, computing \\( F^+ \\) based on \\( F_j \\), and computing \\( F^- \\) based on \\( F_{j+1} \\).

<p align="center"> <img alt="43.png" src="/r/img/545/43.png" /> </p>

{{< katex display >}}
Q_j ^{n+1} = Q_j ^n - \frac{\Delta t}{\Delta x} \left( F_{j + 1/2} ^n - F_{j - 1/2} ^n \right)
{{< /katex >}}

By defining the numerical flux at the grid midpoints, this naturally leads to a finite volume implementation.

## Finite Volume Method

Finite volume methods differ from finite difference methods in the quantity which we store at each grid point. If we consider a volume centered at grid point \\( j + 1/2 \\), we can integrate over the cell volume to get the average value of the function over the volume.

{{< katex display >}}
\pdv{}{t} \underbrace{\int _\Omega  \vec Q \dd \vec V} _ {\int _\Omega \rho \dd \vec V = m _\Omega} + \underbrace{\int _ \Omega \div \vec F \dd \vec V = 0} _{\oint \dd \vec S \cdot \vec F \rightarrow \sum_{\text{sides}} \vec S _j \cdot \vec F _j }
{{< /katex >}}

<p align="center"> <img alt="44.png" src="/r/img/545/44.png" /> </p>

Because the integral is determined by the fluxes, which are defined along the cell edges rather than the grid points, this sort of method is no longer constrained to evenly-spaced quadrilateral grids. Much more complicated polygons are possible, allowing us to avoid the stair-stepping issues at the boundary of uniform grids.

Fluxes are computed using the upwind method

{{< katex display >}}
F_{j + 1/2} = F^- _{j + 1} + F_j ^+ = \vec X \vec \Lambda ^- \vec X ^{-1} Q_{j+1} + \vec X \vec \Lambda^+ \vec X^{-1} Q_j
{{< /katex >}}

Manipulating this a bit, we can get a more convenient form for evaluating the fluxes.
{{< katex display >}}
F_{j + 1/2} = \vec X \underbrace{\left( \frac{ \vec \Lambda - |\vec \Lambda|}{2} \right)}_{\text{negative components}} \vec X^{-1} Q_{j+1} + \vec X \underbrace{\left( \frac{\vec \Lambda + |\vec \Lambda| }{2} \right)}_{\text{positive components}} \vec X^{-1} Q_j \\
= \frac{1}{2} \left( \vec X \vec \Lambda \vec X^{-1} Q_{j+1} + \vec X \vec \Lambda \vec X^{-1} Q_j \right) - \frac{1}{2} \vec X | \vec \Lambda| \vec X^{-1} (Q_{j+1} - Q_j) \\
= \underbrace{\frac{F_j + F_{j+1}}{2}}_{\text{Centered flux}} - \underbrace{\frac{1}{2} \left( \vec X |\vec \Lambda| \vec X ^{-1} \right) _{j + 1/2} (Q_{j+1} - Q_j)}_{\text{Flux correction}}
{{< /katex >}}

To calculate \\( \vec X |\vec \Lambda | \vec X^{-1} \\) at grid point \\( j + 1/2 \\), we need to perform some sort of average between \\( Q_j \\) and \\( Q_{j+1} \\). The simplest is just:

{{< katex display >}}
Q_{j+1/2} = \frac{Q_j + Q_{j+1}}{2}
{{< /katex >}}

which isn't conservative, but works pretty well. There are other averaging methods, like the Roe average, that attempt to preserve conservative properties by propagating a density average through \\( Q \\).

This is called an Approximate Riemann Solver. It's composed of two separate steps, a centered flux (unstable FTCS), and a flux correction based on the characteristics of the PDE (stable).

# Equilibrium Calculations

From physical expectations, elliptic equations result from equilibrium calculations and eigenvalue systems. In general, we can write elliptic equations as
{{< katex display >}}
\vec A \vec x = \vec b
{{< /katex >}}
where \\( \vec A \\) may be a nonlinear function of \\( \vec x \\). For example, if we think of Poisson's equation in 1D,
{{< katex display >}}
\dv{^2 \phi}{x^2} = - \rho_c
{{< /katex >}}
and apply finite differencing,
{{< katex display >}}
\frac{\phi_{j+1} - 2 \phi_j + \phi_{j-1}}{\Delta x^2} = - \rho_j
{{< /katex >}}
we get a matrix system
{{< katex display >}}
\vec A \vec x = \frac{1}{\Delta x^2} \begin{bmatrix} -2 & 1 & 0 & \ldots \\ 1 & -2 & 1 & \ldots \\ \ldots & \ldots & \ldots & \ldots \end{bmatrix} \begin{bmatrix} \phi_1 \\ \phi_2 \\ \ldots \end{bmatrix} = \vec b = - \begin{bmatrix} \rho_1 \\ \rho_2 \\ \ldots \end{bmatrix}
{{< /katex >}}
where \\( \vec A \\) is a J by J matrix. In equilibrium calculations, this comes up when solving the Grad-Shafranov equation

{{< katex display >}}
\Delta ^\star \psi = I I' - \mu_0 r^2 p'
{{< /katex >}}
where
{{< katex display >}}
I' = \pdv{I}{\psi} \qquad p' = \pdv{p}{\psi}
{{< /katex >}}
and
{{< katex display >}}
\Delta ^\star \equiv r \pdv{}{r} \frac{r}{r} \pdv{}{r} + \pdv{^2}{z^2}
{{< /katex >}}

The Grad-Shafranov equation is a nonlinear equation, and we often assume a power series expansion of the current density and pressure
{{< katex display >}}
I(\psi) = I_0 + I_1 \psi + I_2 \psi^2 + \ldots
{{< /katex >}}
{{< katex display >}}
p(\psi) = p_0 + p_1 \psi + p_2 \psi^2 + \ldots
{{< /katex >}}

For a force-free equilibrium (\\( p = 0 \\)) with a linear current profile 
{{< katex display >}}
I I' = I_0 I_1 + I_1 ^2 \psi
{{< /katex >}}

this makes the Grad-Shafranov equation a linear system.
{{< katex display >}}
\vec A = \Delta ^\star _{\text{FD}} + I_1 ^2
{{< /katex >}}
{{< katex display >}}
\vec x = \psi_{ij} \qquad \vec b = (I_0 I_1) _{ij}
{{< /katex >}}
where \\( \Delta ^\star _{\text{FD}} \\) is a finite difference representation of the \\( \Delta ^\star \\) operator. For a given geometry and poloidal current profile, \\( I_0 \\) and \\( I_1 \\), we can solve \\( \vec A \vec x = \vec b \\) to give \\( \psi(r, z) \\).

Solving \\( \vec A \vec x = \vec b \\) can be done using either direct or indirect (iterative) methods. Direct decomposition methods (like Kramer's rule, Gaussian decomposition) require \\( \mathcal{O}(N^3) \\) operations, where \\( N \\) is the size of the matrix. They also require full matrix storage, even though \\( \vec A \\) is a sparse (tridiagonal) matrix.

Iterative methods help solve this problem. We begin with a solution which is improved upon until we get convergence. If this converges in fewer operations than a full decomposition, then we've saved some time and a lot of in-memory storage space.

{{< katex display >}}
x^0 \rightarrow x^1 \rightarrow x^2 \rightarrow \ldots
{{< /katex >}}
{{< katex display >}}
\vec x^{n+1} = \vec x^n + \vec B^{-1} (\vec b - \vec A \vec x^n) \\
= \vec x^n + \vec B^{-1} \vec r^n
{{< /katex >}}

The technique boils down to a clever choice of \\( \vec B \\). We want to choose an approximation matrix \\( \vec B \\) which is very close to \\( \vec A \\), but is much easier to invert.
{{< katex display >}}
\vec B \approx \vec A
{{< /katex >}}
For this kind of iterative method, each iteration requires \\( \mathcal{O}(N) \\) operations, and converges in fewer than \\( N \\) iterations. The best iterative methods can converge in \\( \mathcal{O}(N \ln N) \\) total operations.

# Linear Stability

When we studied plasma waves at the beginning of this course, we performed a linearization of the Vlasov equation about an equilibrium state. This is how we got dispersion relations for waves. We assumed an equilibrium of a uniform plasma, with at most static magnetic fields. For more interesting equilibria with nonzero gradients, we follow the same procedure.

First, we linearize the ideal MHD equations about a static equilibrium (\\( \vec v_0 = 0 \\))
{{< katex display >}}
\pdv{\rho_1}{t} = - \div (\rho_0 \vec v_1)
{{< /katex >}}
{{< katex display >}}
\pdv{p_1}{t} = - \div (p_0 \vec v_1) + (1 - \Gamma) p_0 \div \vec v_1
{{< /katex >}}
{{< katex display >}}
\pdv{\vec B_1}{t} = \curl (\vec v_1 \cross \vec B_0)
{{< /katex >}}
{{< katex display >}}
\rho _0 \pdv{\vec v_1}{t} + \frac{1}{\mu_0} \left[(\curl \vec B_1) \cross \vec B_0 + (\curl \vec B_0) \cross \vec B_1 \right]
{{< /katex >}}