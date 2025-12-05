---
title: Conformal Mappings
weight: 90
---

{{< katex display >}}

{{< /katex >}}

# Conformal Mappings

There are many physical problems that require us to solve the Laplace equation on a domain \\( D \\) with some set of boundary conditions. As we've seen so far, there are certain sets of boundary conditions for which Laplace's equation is relatively easy to solve: for instance a Dirichlet boundary condition on a circle, or in the upper half-plane. But most of the time we are given more complicated geometries for the domain and boundary that require trickier approaches. One way of solving these problems is to perform a specific type of change of variables to map the original complicated domain to a simpler one that we already know how to solve.

A **conformal mapping** is a mapping which preserves both the magnitude and sense of angles. The funny thing is when we work with conformal mappings to solve problems, we will mostly be looking for places where a mapping is _not_ conformal. For the definition:

A mapping which preserves the magnitude and sense of the angle between two smooth arcs passing through a specific point is said to be conformal at that point.

<p align="center"> <img alt="conformal-mapping-diagram.png" src="/r/img/aa567/conformal-mapping-diagram.png" /> </p>

> [!IMPORTANT]
> {{< katex display >}}
{{< /katex >}}
> **Theorem**
> 
> At each point where \\( w(z) \\) is analytic and \\( w'(z) \neq 0 \\), the mapping \\( w = w(z) \\) is conformal.
> 

We'll come back to prove this later, but that isn't the important part for us.

Let's take a look at invariance of the Laplace equation under a conformal mapping

{{< katex display >}}
z = x + iy
{{< /katex >}}

{{< katex display >}}
\nabla ^2 \phi = 0 
{{< /katex >}}

{{< katex display >}}
w = u + iv
{{< /katex >}}

If \\( w \\) is conformal, then \\( \nabla ^2 _w \phi = \pdv{^2 \phi}{u^2} + \pdv{^2 \phi}{v^2} = 0 \\) 

As we know, in numerical analysis we frequently use conformal mappings to solve problems in a simpler geometry than the physical geometry.

Showing the invariance of the Laplace equation under a conformal mapping is pretty easy, but it is tedious:

<p align="center"> <img alt="laplace-equation-conformal.png" src="/r/img/aa567/laplace-equation-conformal.png" /> </p>

(can't be bothered to type all that out again right now...)

The takeaway here is that Laplace's equation is unaffected by a conformal mapping. So if \\( \phi \\) solves Laplace's equation in the \\( z \\) plane, then its image in the \\( w \\) plane also satisfies Laplace's equation.

How do we know what sort of mapping to use for our particular boundary conditions? The answer is basically people have made tables of conformal mappings that are useful for particular types of boundary conditions; just look in the back of a complex analysis textbook to find the one we need

Example:

Consider the branch of \\( \ln(z) \\):

{{< katex display >}}
f(z) = \frac{1}{\pi} \ln (z) \qquad 0 \leq \text{arg}(z)  < 2 \pi
{{< /katex >}}

This function is analytic everywhere except \\( z = 0 \\) and along the positive real axis. So the function
{{< katex display >}}
\psi = \text{Im} f(z) = \frac{1}{\pi} \theta
{{< /katex >}}

\\( \psi \\) should satisfy the Laplace equation in regions where \\( f(z) \\) is analytic.

{{< katex display >}}
(\pdv{^2}{x^2} + \pdv{^2}{y^2}) \psi = 0
{{< /katex >}}

The constants of \\( \psi \\) are like rays out from the origin - streamlines for a source flow. The particular problem that \\( \psi \\) solves looks like this:

<p align="center"> <img alt="cm-laplace-problem-1.png" src="/r/img/aa567/cm-laplace-problem-1.png" width="200px" /> </p>


Another example: electrostatic potential in a cylindrical conductor:

<p align="center"> <img alt="cm-laplace-problem-2.png" src="/r/img/aa567/cm-laplace-problem-2.png" width="200px" /> </p>

We want to convert the circle into a straight line, and the interior into the upper half plane. To transform circles into straight lines requires a bilinear transformation:

{{< katex display >}}
w(z) = A \frac{z - z_1}{z - z_0}
{{< /katex >}}

<p align="center"> <img alt="cm-problem-2-mapping.png" src="/r/img/aa567/cm-problem-2-mapping.png" width="200px" /> </p>

We pick \\( z_0 = -1 \\) to map point \\( C \\) to infinity. Then we map \\( a \\) to the origin by picking \\( z_1 = 1 \\). Then choose \\( A = -i \\) so the image lies flat

{{< katex display >}}
w(z) = i \frac{z - 1}{z + 1}
{{< /katex >}}
{{< katex display >}}
\phi = \frac{1}{\pi} \ln w \\
= \frac{1}{\pi} \text{arg} w \\
= \frac{1}{\pi} \text{arg} \left( i \frac{z - 1}{z + 1} \right) \\
= \frac{1}{\pi} \tan^{-1} \left( \frac{1 - x^2 - y^2}{2y} \right) \quad 0 \leq \theta < 2 \pi
{{< /katex >}}

In the \\( w \\) plane, the unit circle is

{{< katex display >}}
|z|^2 = 1 \qquad \rightarrow \qquad w = -i \frac{z - z^\star}{2(1 + x)} = \frac{y}{1 + x}
{{< /katex >}}

This is real, so \\( v = 0 \\). The interior of the circle is the upper half plane \\( v > 0 \\).


## Types of Transformations

### Translation

{{< katex display >}}
w = w(z) = z + c
{{< /katex >}}

The origin in the \\( z \\) plane is just shifted to \\( c \\) in the \\( w \\) plane

### Rotation

{{< katex display >}}
w = w(z) = e^{i \phi} z
{{< /katex >}}
{{< katex display >}}
\text{arg} w = \phi + \text{arg} z
{{< /katex >}}

this is just a rotation through the angle \\( \phi \\)

### Magnification

{{< katex display >}}
w = w(z) = \rho z \qquad \rho > 0
{{< /katex >}}

\\( \rho > 1 \\) is a magnification, \\( \rho < 1 \\) is a reduction.

### Linear transformation

{{< katex display >}}
w = w(z) = a z + b \qquad a, b \in \mathcal{\Complex}
{{< /katex >}}

Write \\( a = \rho e^{i \phi} \\) 

{{< katex display >}}
w_1 = e^{i \phi} z \qquad \text{(rotation)}
{{< /katex >}}
{{< katex display >}}
w_2 = \rho w_1 \qquad \text{(magnification)}
{{< /katex >}}
{{< katex display >}}
w = w_2 + b \qquad \text{(translation)}
{{< /katex >}}

### Inversion

{{< katex display >}}
w = w(z) = \frac{1}{z} \qquad x = \frac{u}{u^2 + v^2} \qquad y = - \frac{v}{u^2 + v}
{{< /katex >}}

(i) The unit circle in the \\( z \\) plane is mapped to the unit circle in the \\( w \\) plane. But the inside of the unit circle is mapped to the outside and vice versa. The origin is mapped into infinity (as we'd expect since the transformation is not analytic at \\( z = 0 \\))

(ii) A circle which does not pass through \\( z = 0 \\) is mapped into a circle that does not pass through \\( w = 0 \\) 

{{< katex display >}}
(x - x_0)^2 + (y - y_0) ^2 = R^2 \qquad (R^2 \neq x_0 ^2 + y_0 ^2)
{{< /katex >}}
{{< katex display >}}
(\frac{u}{u^2 + v^2}) ^2 + (- \frac{v}{u^2 + v^2} - y_0 )^2 = R^2
{{< /katex >}}
{{< katex display >}}
u^2 + v^2 + \frac{2 x_0 u - 2 y_0 v - 1}{R^2 - (x_0 ^2 + y_0 ^2)} = 0
{{< /katex >}}
{{< katex display >}}
( u + \frac{x_0}{R^2 - (x_0 ^2 + y_0 ^2)})^2 + (v - \frac{y_0}{R^2 - (x_0 ^2 + y_0 ^2)})^2 = \frac{R^2}{[R^2 - (x_0 ^2 + y_0 ^2)]^2}
{{< /katex >}}

(iii) Straight lines passing through \\( z = 0 \\) are mapped into straight lines passing through \\( w =0 \\) 

{{< katex display >}}
Ax - By = 0
{{< /katex >}}
{{< katex display >}}
Au + Bv = 0
{{< /katex >}}

(iv) A straight line in the \\( z \\) plane not passing through the singularity \\( z = 0 \\) is mapped into a circle in the \\( w \\)  plane passing through \\( w = 0 \\) 

{{< katex display >}}
Ax - By = C \qquad ( C \neq 0)
{{< /katex >}}

{{< katex display >}}
A \frac{u}{u^2 + v^2} + \frac{B v}{u^2 + v^2} = C
{{< /katex >}}
{{< katex display >}}
u^2 + v^2 - \frac{A}{C} u - \frac{B}{C} v = 0
{{< /katex >}}
{{< katex display >}}
(u - \frac{A}{2C})^2 + (v - \frac{B}{2C})^2 = (\frac{A}{2C})^2 + (\frac{B}{2C})^2
{{< /katex >}}

Conversely,

(v) A circle passing through \\( z = 0 \\) is mapped into a straight line in the \\( w \\) plane not passing through \\( w = 0 \\) 


### Shifted inversion

Even more general, we can have

{{< katex display >}}
w(z) - w_0 = \frac{1}{z - z_0}
{{< /katex >}}

\\( z = 0 \\) previously becomes \\( z = z_0 \\), and \\( w = 0 \\) becomes \\( w = w_0 \\) 

(i) The unit circle centered at \\( z_0 \\) in the \\( z \\)  plane is mapped into a unit circle with center \\( w_0 \\)

(ii) A circle that does not pass through \\( z = z_0 \\) is mapped into a circle that does not pass through \\( w = w_0 \\) 

(iii) Straight lines passing through \\( z  =z_0 \\) are mapped into circles passing through \\( w = w_0 \\) 

(iv) A straight line not passing through \\( z = z_0 \\) is mapped into a circle passing through \\( w = w_0 \\) . This is easier to understand if you look at the inverse: if I have a circle and a point passes through a singularity of the mapping, then the iamge must be infinite - a straight line.

(v) A circle passing through \\( z =z_0 \\) is mapped into a straight line not passing through \\( w = w_0 \\) (just the reciprocal of (iv))

### Bilinear transformation

Even more general, we come to the bilinear transformation

{{< katex display >}}
w(z) - w_0 = \frac{A}{z - z_0}
{{< /katex >}}

if \\( A \\) is real and positive, this magnifies the above case. If \\( A \\) is complex, then it magnifies and rotates. The extra degree of freedom afforded by \\( A \\) allows us to specify the orientation of the geometric shapes. It can also be written as

{{< katex display >}}
w(z) = a \frac{z - z_1}{z - z_0}
{{< /katex >}}

Many times, textbooks will write this as

{{< katex display >}}
w = \frac{az + b}{cz + d}
{{< /katex >}}

but that is a bit misleading, because there are really only three degrees of freedom here (e.g. divide the top and bottom by \\( d \\) and the transform is the same).

The point \\( z_0 \\) indicates where a singularity exists in the \\( z \\) plane. The reverse is true for \\( w_0 \\) which indicates a singularity in the \\( w \\) plane.

Now let's really dig into our previous example of finding the steady-state temperature distribution in a circular disk of unit radius where the temperature is prescribed to have two values on different portions of the circle. We used

{{< katex display >}}
w(z) = -i \frac{z - 1}{z + 1}
{{< /katex >}}

<p align="center"> <img alt="cm-problem-2-mapping.png" src="/r/img/aa567/cm-problem-2-mapping.png" width="200px" /> </p>

The point \\( z_0 = -1 \\) is point \\( c \\)  on the circle. By making that point correspond with the singularity in \\( w \\), that point is mapped to infinity. We can then pick some other point (\\( a \\)) in the \\( z \\) plane to lie on the straight line in the \\( w \\)  plane. It is convenient to do this in our case because there is a jump condition in our problem along \\( y = 0 \\).

Looking at point \\( b \\), 

{{< katex display >}}
w(z = + i) = -i \frac{i - 1}{i + 1} = - \frac{-1 - i}{i + 1} = \frac{i + 1}{i + 1} = 1
{{< /katex >}}

And looking at point \\( d \\):

{{< katex display >}}
w(z = -i) = -i \frac{-i -1}{-i +1} = - \frac{1 - i}{1 - i} = -1
{{< /katex >}}

We can check the inside/outside mapping of the unit circle by picking a point inside the circle and checking where it gets mapped to. The origin is the easiest one:

{{< katex display >}}
w(z = 0) = -i \frac{-1}{+1} = i
{{< /katex >}}

That gets us in the upper half plane, so that's where the interior of the circle gets mapped to.
