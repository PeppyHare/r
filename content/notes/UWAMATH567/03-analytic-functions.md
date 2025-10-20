---
title: Analytic Functions and Integration
weight: 30
---

{{< katex display >}}

{{< /katex >}}

## Analytic Functions

We have seen that \\( f(z) \\) is differentiable at \\( z \\) if the limit

{{< katex display >}}
f'(z) = \lim_{h \rightarrow 0} \frac{f(z + h) - f(z)}{h}
{{< /katex >}}

exists.

### Definition: **analytic**

The function \\( f(z) \\) is **analytic** at \\( z_0 \\) if \\( f(z) \\) is single-valued and is differentiable in a neighborhood of \\( z_0 \\). The function \\( f(z) \\)  is analytic in an open set \\( S \\)  if it is analytic at every point of \\( S \\).

Example: \\( e^z \\) is analytic in \\( \Complex \\). The function \\( 1/z^2 \\) is analytic in \\( \Complex \\) except at z = 0.

### Definition: **entire**

The function \\( f(z) \\) is **entire** if \\( f(z) \\) is analytic in \\( \Complex \\).

Thus, the exponential is an entire function.

As we saw before, \\( f(z) = z^\star \\) is not differentiable anywhere

{{< katex display >}}
\dv{}{z}f = \lim_{\Delta z \rightarrow 0} \frac{(z + \Delta z)^\star - z^\star}{\Delta z} \\
= \lim_{\Delta z \rightarrow 0} \frac{\Delta z^\star}{\Delta z} \\
= e^{-2 i \theta} \qquad \Delta z = \Delta r e^{i \theta}, \quad \Delta r \rightarrow 0
{{< /katex >}}

This limit is not unique, so there is no derivative. Actually, \\( f(z) = z^\star \\) is a function of \\( z^\star \\), not \\( z \\). \\( f(z) = |z|^2 = z z^\star \\) is a function of two complex variables, \\( z \\) and \\( z^star \\), since \\( x = \frac{1}{2} (z + z^\star) \\) and \\( y = \frac{1}{2i} (z - z^\star) \\)

A function of two variables \\( x  \\) and \\( y \\) should be a function of \\( z \\) and \\( z^\star \\), not of \\( z \\)  only. We claimed that \\( z = x + iy \\)  is like a 2D vector, and that \\( f(z) \\) is like a function of a 2D vector, but there is no free lunch!

The key insight here is that the bulk of the theory of a complex variable is to define the conditions under which \\( f(z) \\) is a function of \\( z \\) only (it is an analytic function), and how to avoid regions where \\( f(z) \\) is not, by e.g. cutting up the complex plane and treating singularities separately.

To take an informal perspective, consider a function of two complex variables

{{< katex display >}}
f(z, z^\star) = f(z_0, z_0 ^\star) + a (z - z_0) + b (z^\star - z_0 ^\star) + \text{second order terms...}
{{< /katex >}}
{{< katex display >}}
f(z, z^\star) - f(z_0, z_0 ^\star) = a (z - z_0) + b(z^\star - z_0 ^star) + \ldots \\
\lim_{z \rightarrow z_0} \frac{f(z, z^\star)- f(z_0, z_0 ^\star)}{(z - z_0)} = a + b \frac{(z^\star - z_0 ^\star)}{(z - z_0)}\\
= a + b \frac{\Delta z^\star}{\Delta z}
{{< /katex >}}

This limit is not path independent unless \\( b = 0 \\). So in general what is \\( b \\)?

{{< katex display >}}
b = \left.\pdv{f}{z^\star} \right|_{z^\star = z_0 ^\star, z = z_0}
{{< /katex >}}
{{< katex display >}}
b = 0 \rightarrow \pdv{f}{z^\star} = 0
{{< /katex >}}



## The Cauchy-Riemann equations

The limit

{{< katex display >}}
f'(z) = \lim_{h \rightarrow 0} \frac{f(z + h) - f(z)}{h}
{{< /katex >}}

should be independent of the manner in which \\( h \rightarrow 0 \\). Let

{{< katex display >}}
f(z) = u(x, y) + i v(x, y)
{{< /katex >}}

where \\( z = x + iy \\) as usual. First we consider \\( h = \Delta x \\), i.e. \\( h \\)  is restricted to real values. Then

{{< katex display >}}
f'(z) = \lim_{\Delta x \rightarrow 0} \frac{u(x + \Delta x, y) + i v(x + \Delta x, y) - u(x, y) - iv(x, y)}{\Delta x} \\
\lim_{\Delta x \rightarrow 0} \frac{u(x + \Delta x, y) - u(x, y)}{\Delta x} + i \lim_{\Delta x \rightarrow 0} \frac{v(x + \Delta x, y) - v(x, y)}{\Delta x} \\
= u_x + i v_x
{{< /katex >}}

In the other direction, \\( h = \Delta y \\) i.e. \\( h \\) is restricted to imaginary values

{{< katex display >}}
f'(z) = \lim_{\Delta y \rightarrow 0} \frac{u(x, y + \Delta y) + i v(x, y + \Delta y) - u(x, y) - iv(x, y)}{i \Delta y} \\
\lim_{\Delta y \rightarrow 0} \frac{u(x, y + \Delta y) - u(x, y)}{i \Delta y} + i \lim_{\Delta y \rightarrow 0} \frac{v(x, y + \Delta y) - v(x, y)}{i \Delta y} \\
= v_y - i u_y
{{< /katex >}}

Since these two results are supposed to be equal, we get

{{< katex display >}}
u_x + i v_x = v_y - i u_y \\
\leftrightarrow u_x = v_y \qquad v_x = - u_y
{{< /katex >}}

These are the **Cauchy-Riemann equations**. If, in addition, \\( u(x, y) \\) and \\( v(x, y) \\) are twice differentiable, then

{{< katex display >}}
u_{xx} = v_{yx} = - u_{yy} \\
v_{xx} = - u_{yx} = - v_{yy} \\
\rightarrow \grad ^2 u = 0 = \grad^2 v
{{< /katex >}}

A function that satisfies Laplace's equation is called **harmonic**. Thus both the real and imaginary parts of \\( f(z) \\) are harmonic, provided that \\( f(z) \\) is analytic.

Next we show that the Cauchy-Riemann conditions are not only necessary conditions from analyticity, they are also sufficient.

{{% hint info %}}
{{< katex display >}}
{{< /katex >}}
**Theorem**

The function \\( f(z) = u(x, y) + iv(x, y) \\) is analytic at \\( x + iy \\) if and only if \\( u_x, v_x, u_y \\) and \\( v_y \\) are continuous and satisfy the Cauchy-Riemann conditions.

**Proof**

We've already proven that the conditions are necessary. To prove sufficiency, we have

{{< katex display >}}
\Delta u = u_x \Delta x + u_y \Delta y + \epsilon_1 |\Delta z| \\
\Delta v = v_x \Delta x + v_y \Delta y + \epsilon_2 |\Delta z|
{{< /katex >}}

where \\( |\Delta z| = \sqrt{(\Delta x)^2 + (\Delta y)^2} \\) and \\( \lim_{\Delta z \rightarrow 0} \epsilon_{1, 2} = 0 \\).

{{< katex display >}}
\frac{\Delta f}{\Delta z} = \frac{\Delta u + i \Delta v}{\Delta z} \\
= \frac{u_x \Delta x + u_y \Delta y + i v_x \Delta x + i v_y \Delta y + \epsilon_1|\Delta z| + i \epsilon_2 |\Delta z|}{\Delta z} \\
= \frac{(u_x + i v_x)\Delta x - v_x \Delta y + i u_x \Delta y + \epsilon_1 |\Delta z| + i \epsilon_2 |\Delta z|}{\Delta z} \\
= \frac{(u_x + i v_x)(\Delta x + i \Delta y)}{\Delta z} + (\epsilon_1 + i \epsilon_2)\frac{|\Delta z|}{\Delta z}
{{< /katex >}}

where we have used the Cauchy-Riemann conditions. Let \\( \Delta z = \epsilon e^{i \theta} \\). then

{{< katex display >}}
\lim_{\Delta z \rightarrow 0} \frac{\Delta f}{\Delta z} = u_x + i v_x + \lim_{\Delta z \rightarrow 0} (\epsilon_1 + i \epsilon_2) e^{-i \theta} = f'(z)
{{< /katex >}}

{{% /hint %}}

## Integration

Integration is where complex variables really shine. They behave like a scalar, but act like the 2D plane, and there are theorems that help us check paths. But first we need to define integration.

For our purposes, the definition of an integral in the complex plane is the same as the Riemann sum: we divide a path \\( C \\) into segments \\( z_1, z_2, \ldots \\), and sum the average value of the function along the segments and add them up. To be well-defined, \\( C \\) must be a simple contour (that is, it does not cross itself) and it must be a piecewise smooth simple curve.

{{< katex display >}}
\int _{C } f(z) \dd z = \lim_{L \rightarrow 0} \sum_{n=1}^{\infty} f(\xi _j) \Delta z_j
{{< /katex >}}
where
{{< katex display >}}
\Delta z_j = z_j - z_{j-1}
{{< /katex >}}
{{< katex display >}}
L = \text{max}|\Delta z_j|
{{< /katex >}}
{{< katex display >}}
\xi_j = \frac{1}{2} (z_j + z_{j-1})
{{< /katex >}}

The integral exists if this limit exists and is independent of the points \\( z_j \\).

The integral can be done using real variables. Let

{{< katex display >}}
f(z) = u(x, y) + i v(x, y) \qquad z = x + iy
{{< /katex >}}

{{< katex display >}}
\int_C f(z) \dd z = \int_C (u + iv) (\dd x + i \dd y) \\
= \int_C u \dd x - v \dd y + i \int _C u \dd y + v \dd x
{{< /katex >}}

So we can do the integral in real variables, but it involves 2 integrals of 2 variables. We want to be able to do single slacar integrals, but in doubt you can always go back and do it this way.

Closed integrals are very useful to be able to do. In complex analysis, we make use of Cauchy's theorem very often, but before we get to that let's consider the real integral of 2 variables along a closed path.

Green's theorem says that:

{{< katex display >}}
\oint _C V_1 (x, y) \dd x + V_2 (x, y) \dd y = \int _S \left( \pdv{}{x} V_2 - \pdv{}{y} V_1 \right) \dd x \dd y
{{< /katex >}}

That is, we can replace the contour integral over the closed path \\( C \\)  with a surface integral over the enclosed surface \\( S \\).

Going back to our closed contour integral in the complex plane,

{{< katex display >}}
\oint _C(u \dd x - v \dd y) = - \int_S \left( \pdv{v}{x} + \pdv{u}{y} \right) \dd x \dd y
{{< /katex >}}
{{< katex display >}}
\oint _C v \dd x + u \dd y = \int_S \left( \pdv{u}{x} - \pdv{v}{y} \right) \dd x \dd y
{{< /katex >}}

These integrals are both zero if the function is analytic on the domain enclosed, by the Cauchy-Riemann condition. That brings us to Cauchy's theorem:

{{% hint info %}}
{{< katex display >}}
{{< /katex >}}
**Cauchy's Theorem**

If \\( f(z) \\) is analytic inside and on a simple closed curve \\( C \\), then

{{< katex display >}}
\oint_C f(z) \dd z = 0
{{< /katex >}}

{{% /hint %}}

This is important because it gives us path independence. If \\( f \\) is analytic, it doesn't matter what direction we take \\( C \\)  as long as the path can be deformed from \\( C \\) without leaving the region of analyticity. This is because the difference between two such paths is a closed contour integral. This is very useful for turning a nasty contour into a simple one.

{{% hint info %}}
{{< katex display >}}
{{< /katex >}}
**Theorem**

The integral of an analytic function is also an analytic function of its upper limit

{{< katex display >}}
F(z) = \int_{z_0} ^z f(z') \dd z'
{{< /katex >}}

We get this by showing that \\( \frac{d}{dz} F \\) exists independent of \\( \Delta z \\)

{{< katex display >}}
\dv{F}{z} = \lim_{\Delta z \rightarrow 0} \frac{F(z + \Delta z) - F(z)}{\Delta z} \\
= \lim_{\Delta z \rightarrow 0} \frac{1}{\Delta z} \int_z ^{z + \Delta z} f(z') \dd z'
{{< /katex >}}

Consider

{{< katex display >}}
\frac{1}{\Delta z} \int _z ^{z + \Delta z} f(z) \dd z' = \frac{f(z) \Delta z}{\Delta z} = f(z)
{{< /katex >}}


{{< katex display >}}
\frac{F(z + \Delta z) - F(z)}{\Delta z} - f(z) = \frac{1}{\Delta z} \int_z ^{z + \Delta z} \left[ f(z') - f(z) \right] \dd z = 0 \quad \text{as} \quad \Delta z \rightarrow 0
{{< /katex >}}
Since \\( f \\)  is continuous, \\( |f(z') - f(z) | < \epsilon \\) if \\( \Delta z < \delta> \\). So we've shown that \\( \dv{F}{z} = f(z) \\) . Since this derivative exists, it is an analytic function.

{{% /hint %}}

Let's do some examples:

{{< katex display >}}
\oint _C z^n \dd z \quad \text{for} \quad n = 0, 1, 2, 3, \ldots
{{< /katex >}}

We can just write down 0 for the answer because \\( z^n \\) is entire (analytic everywhere).

{{< katex display >}}
\oint_C \frac{\dd z}{z^n}
{{< /katex >}}

If \\( C \\) does not include the origin, then the function is analytic so we can still say the answer is 0. If \\( C \\)  contains the origin, then it is a little more complicated and we have to actually calculate the integral. We can't just use Cauchy's theorem. But we can shrink the contour down to a circle with radius \\( \rho \\) centered at the origin:

{{< katex display >}}
z = \rho e^{i \theta} \quad 0 \leq \theta < 2 \pi
{{< /katex >}}
{{< katex display >}}
\oint _{C_1} \frac{1}{z^n} \dd z = \int _0 ^{2 \pi} \frac{\rho e^{i \theta} \dd \theta}{\rho ^n e^{i n \theta}} \\
= - \frac{1}{\rho ^{n-1}} \frac{\left[ e^{-i (n - 1) 2 \pi)} - 1 \right]}{n-1}
{{< /katex >}}

This comes out to be zero if \\( n \neq 1 \\). But if \\( n=1 \\) then we're trying to find

{{< katex display >}}
\oint_C \frac{1}{z} \dd z
{{< /katex >}}

This is a special case where the integral above gives us \\( 0/0 \\) and we would need to use L'hopital's rule. But if we just look at the integral

{{< katex display >}}
\int _0 ^{2 \pi} \frac{1}{\rho e^{i \theta}} \rho e^{i \theta} i \dd \theta = \begin{cases} 2 \pi i & \text{if C encloses the origin} \\ 0 & \text{else} \end{cases}
{{< /katex >}}

In summary, for integer \\( n \\) we have

{{< katex display >}}
\oint_C (z - z_0)^n \dd z = \begin{cases} 0 & \text{if C does not contain }z_0 \\ 0 & \text{if } n \neq -1 \\ 2 \pi i & \text{if } n = -1 \text{ and C encloses }z_0 \end{cases}
{{< /katex >}}

If \\( C \\)  passes through \\( z_0 \\), then this is an improper integral (it is not well defined) and we should refuse to do it!

Now we will look at functions of the form
{{< katex display >}}
f(z) = \sum_{n = -\infty} ^{\infty} a_n (z - z_0)^n
{{< /katex >}}

If we can write our function like this and it converges in some region, and \\( C \\) is in that region, then

{{< katex display >}}
\oint _C f(z) \dd z = \sum_{n = -\infty}^{\infty} a_n \oint _C (z - z_0)^n \dd z = a_{-1} 2 \pi i
{{< /katex >}}

This neat trick will give us the residue theorem.

### Cauchy's Integral Formula

In this course, we tend to skip proofs of some formulas that are not that useful in practice, but are mostly useful for proving theorems. This one is a bit of both:

{{% hint info %}}
{{< katex display >}}
{{< /katex >}}
**Theorem**

Let \\( f(z) \\) be analytic. Then \\( f(z)/(z - \xi) \\) is analytic except at \\( z = \xi \\)

To get \\( \oint_C \frac{f(z)}{z - \xi} \dd z \\) we move the contour to a circle centered at \\( \xi \\) with radius \\( \rho \\)

{{< katex display >}}
z - \xi = \rho e^{i \theta}
{{< /katex >}}

{{< katex display >}}
\oint_C \frac{f(z)}{z - \xi} \dd z = \int _{0} ^{2 \pi} \frac{f(\xi + \rho e^{i \theta}) i \rho e^{i \theta} \dd \theta}{\rho e^{i \theta}}
{{< /katex >}}
{{< katex display >}}
= \int_0 ^{2 \pi} f(\xi + \rho e^{i \theta}) i \dd \theta
{{< /katex >}}
We can take \\( \rho \\) approaching zero

{{< katex display >}}
\rightarrow \int_0 ^{2 \pi} f(\xi) i \dd \theta = 2 \pi i f(\xi)
{{< /katex >}}

Turning this around, we get **Cauchy's integral formula**:

{{< katex display >}}
f(\xi) = \frac{1}{2 \pi i} \oint_C \frac{f(z) \dd z}{z - \xi} \quad \text{ if }\xi\text{ is inside }C
{{< /katex >}}

or, turning it the other way,

{{< katex display >}}
f(z) = \frac{1}{2 \pi i} \oint _C \frac{f(\xi) \dd \xi}{\xi - z}
{{< /katex >}}

{{% /hint %}}

Looking at this expression, it tells us that if \\( f(z) \\) is known at the boundaries (on the contour \\( C \\)), then \\( f(z) \\) is known in the interior. The boundary value entirely determines the function's value. This is the case for analytic functions because they are solutiosn of Laplace's equation, which has the property that it is completely determined by its boundary condition.

We can use this fact to prove that an analytic function can be differentiated to arbitrary order:

{{< katex display >}}
f'(z) = \lim_{\Delta z \rightarrow 0} \frac{f(z + \Delta x) - f(z)}{\Delta z}
{{< /katex >}}

Re-express \\( f(z) \\) using the Cauchy integral formula

{{< katex display >}}
f(z) = \frac{1}{2 \pi i} \oint _C \frac{f(\xi) \dd \xi}{\xi - z}
{{< /katex >}}

{{< katex display >}}
f'(z) = \lim_{\Delta z \rightarrow 0} \frac{1}{2 \pi i} \oint_C \dd \xi \left[ \frac{1}{\xi - z - \Delta z} - \frac{1}{\xi - z} \right] \frac{f(\xi)}{\Delta z}
{{< /katex >}}
{{< katex display >}}
\left[ \frac{1}{\xi - z - \Delta z} - \frac{1}{\xi - z} \right] = \frac{(\xi - z) - (\xi - z - \Delta z)}{(\xi - z - \Delta z)(\xi - z)} = \frac{\Delta z}{(\xi - z - \Delta z)(\xi - z)}
{{< /katex >}}

{{< katex display >}}
\rightarrow f'(z) = \frac{1}{2 \pi i} \lim_{\Delta z \rightarrow 0} \oint _C \frac{f(\xi) \dd \xi}{(\xi - z - \Delta z)(\xi - z)} \\
= \frac{1}{2 \pi i} \oint _C \frac{f(\xi) \dd \xi}{(\xi - z)^2}
{{< /katex >}}

To take the second derivative, we would follow a similar set of steps:

{{< katex display >}}
f''(z) = \lim_{\Delta z \rightarrow 0} \frac{f'(z + \Delta z) - f'(z)}{\Delta z}
{{< /katex >}}

we would get another formula that looks like

{{< katex display >}}
f''(z) = \frac{1}{\pi i} \oint_C \frac{f(\xi) \dd \xi}{(z - \xi)^3}
{{< /katex >}}

And in general, we get

{{< katex display >}}
f^{(n)} (z_0) = \frac{n!}{2 \pi i} \oint_C \frac{f(z) \dd z}{(z - z_0)^{n+1}} \quad \text{(where C encloses }z_0\text{)}
{{< /katex >}}

But we definitely won't always be using this formula to calculate derivatives of complex valued functions. For example,

{{< katex display >}}
f(z) = e^z = \sum_{n=0}^{\infty} z^n / n!
{{< /katex >}}

We could follow the above formula to calculate the derivative using the Cauchy integral formula, but we would get the same result by directly differentiating the terms

{{< katex display >}}
\dv{f(z)}{z} = 0 + 1 + \frac{z}{1!} + \frac{z^2}{2} + \ldots = e^z
{{< /katex >}}
