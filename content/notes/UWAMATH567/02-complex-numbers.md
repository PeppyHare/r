---
title: Complex Numbers
weight: 20
---

{{< katex display >}}

{{< /katex >}}

We enter the topic of complex analysis through the usual lens: trying to take rational powers of real numbers. Within the domain of real numbers, \\( (-1)^{1/2} \\) is not defined. It turns out that if we deal with this example, we create a number system that is closed under rational powers. We define

{{< katex display >}}
i \equiv \sqrt{-1}
{{< /katex >}}

so that \\( i^2 = -1 \\).

A **complex number** is any expression of the form

{{< katex display >}}
z = x + i y \qquad x, y \in \Reals
{{< /katex >}}

We call \\( x = Re(z) \in \Reals \\) the real part of \\( z \\) and \\( y = Im(z) \in \Reals \\) the imaginary part. The set of all complex numbers is denoted by \\( \Complex \\) and we may write \\( \Complex = \Reals + i \Reals \\). Thus a complex number is identified by two real numbers. Gauss realized that a complex number can be geometrically represented by a vector in \\( \Reals ^2 \\).

As we will see in the course, this analogy goes very far and is very useful. Of course, the above implies that we can represent complex numbers using polar coordinates in \\( \Reals ^2 \\) just as well. Let

{{< katex display >}}
x = \rho \cos \theta \\
y = \rho \sin \theta
{{< /katex >}}

Then \\( z \rho (\cos \theta + i \sin \theta) \\) and \\( \rho = \sqrt{x^2 + y^2} \colonequals \abs{z} \\), the modulus or absolute value of \\( z  \\). Further, \\( \theta \colonequals arg(z) \\), the argument of \\( z \\). We have

{{< katex display >}}
\tan \theta = \frac{y}{x} \\
\iff \theta = \alpha \pi + \arctan \left( \frac{y}{x} \right) + 2 \pi n
{{< /katex >}}

where \\( n \\) is any integer and the quadrant has to be specified so as to be able to determine whether \\( \alpha = 0 \\) or \\( 1 \\).

This extension now means that every polynomial has a zero. Previously, we would say \\( x^2 + 1 \\) has no zero. But now, we can understand why the series

{{< katex display >}}
\frac{1}{1+x^2} = \sum_{n=0} ^\infty (-1)^n x^{2n}
{{< /katex >}}

diverges at \\( |x| = 1 \\) .

If \\( z \in \Complex \\) then the complex conjugate \\( \overline{z} \\) is defined as \\( \overline{z} \colonequals x - iy = \rho (\cos \theta - i \sin \theta) = \rho(\cos (-\theta) + i \sin(-\theta)) \\). These equalities show that the complex conjugate \\( \overline{x} \\) of \\( z \\) is found in the Gaussian complex plane by reflecting \\( z \\) with respect to the real axis.

Note that

{{< katex display >}}
z \overline{z} = (x + i y) (x - i y) \\
= x^2 + y^2 \\
= \abs{z}^2
{{< /katex >}}

This is useful to determine the real and imaginary part of the division of two complex numbers

{{< katex display >}}
\frac{z_1}{z_2} = \frac{z_1 \overline{z_2}}{z_2 \overline{z_2}} \\
= \frac{z_1 \overline{z_2}}{\abs{z_2}^2}
{{< /katex >}}

Division is only defined for 1, 2, and 4 dimensional complex numbers. For quaternions:

{{< katex display >}}
(a + bi + cj + k)^{-1} = \frac{a - bi - cj - dk}{a^2 + b^2 + c^2}
{{< /katex >}}
where
{{< katex display >}}
i^2 = j^2 = k^2 = -1 \\
ij = k \\
ji = -k \\
kj = i \\
kj = -i \\
ki = j \\
ik = -j
{{< /katex >}}

Quaternions do not have commutative multiplication.

The **triangle inequality** will come up very often.

{{% hint info %}}
{{< katex display >}}
{{< /katex >}}
**Theorem 1.1**

For any \\( z_1, z_2 \in \Complex \\) we have

{{< katex display >}}
\abs{z_1 + z_2} \leq \abs{z_1} + \abs{z_2} \qquad (i)
{{< /katex >}}

{{< katex display >}}
\abs{z_1 - z_2} \geq \abs{\abs{z_1} - \abs{z_2}} \qquad (ii)
{{< /katex >}}

**Proof**

We prove (i) first. Consider

{{< katex display >}}
|z_1 + z_2| ^2 - (|z_1| + |z_2|^2) = \cancel{|z_1|^2} + \cancel{|z_2|^2} + z_1 \overline{z_2} + \overline{z_1} z_2 - \cancel{|z_1|^2} - \cancel{|z_2|^2} - 2 |z_1| |z_2| \\
= z_1 \overline{z_2} + \overline{z_1 \overline{z_2}} - 2 |z_1| |\overline{z_2}| \\
= 2 (Re(z_1 \overline{z_2}) - |z_1 \overline{z_2}|) \\
\geq 0
{{< /katex >}}

It follows that \\( |z_1 + z_2| - |z_1| \geq |z_2| \\) . Let \\( w_1 \colonequals z_1 + z_2 \\) and \\( w_2 \colonequals z_1 \\). Then the first inequality becomes \\( |w_1| - |w_2| \leq |w_1 - w_2| \\). Similarly, by switching the indices, we get \\( |w_2| - |w_1| \leq |w_2 - w_1| \\). These results combined give (ii).

{{% /hint %}}

The triangle inequality is generalized to

{{< katex display >}}
\left| \sum_{j=1}^{n} z_j \right| \leq \sum_{j=1} ^n |z_j|
{{< /katex >}}

The geometrical meaning of the triangle inequality is just that the length of any side of a triangle is shorter than the sum of the lengths of the other two sides.

At this point, let's skip ahead a bit to Euler's equation. We define the complex exponential function

{{< katex display >}}
e^z = e^{x + iy} = e^{x} (\cos y + i \sin y)
{{< /katex >}}

For real \\( z \\) this coincides with the real exponential that we know. For imaginary \\( z \\), we have

{{< katex display >}}
e^{iy} = \cos y + i \sin y
{{< /katex >}}

As a proof, let \\( f(\theta) = \cos \theta + i \sin \theta \\). Since both \\( \sin \theta \\) and \\( \cos \theta \\) satisfy the second order equation

{{< katex display >}}
\pdv{^2}{\theta ^2} g + g = 0
{{< /katex >}}

Then

{{< katex display >}}
\pdv{^2}{\theta ^2} f + f = 0
{{< /katex >}}

With the initial condition

{{< katex display >}}
f(0) = 1 \qquad f' (0) = i
{{< /katex >}}

The exponential function should have the property

{{< katex display >}}
\pdv{}{\theta} e^{a \theta} = a e ^{a \theta}
{{< /katex >}}

So \\( e^{i \theta} \\) satisfies \\( \left[ \pdv{^2}{\theta ^2} + 1 \right] e^{i \theta} = 0 \\). Since this is a solution to the same equation with the same initial conditions, via the uniqueness theorem for 2nd order linear PDEs \\( f(\theta) = e^{i \theta} \\)

## Limits, continuity, and differentiation

To recap, we consider \\( w = f(z) \\) defined in a neighborhood of \\( z_0 \\) (except maybe at \\( z_0 \\) itself). We say that

{{< katex display >}}
\lim_{z \rightarrow z_0} f(z) = w_0
{{< /katex >}}

if for all \\( \epsilon > 0 \\) sufficiently small, there is a \\( \delta > 0 \\) such that

{{< katex display >}}
0 < |z - z_0| < \delta \rightarrow |f(z) - w_0| < \epsilon
{{< /katex >}}

If \\( z_0 \\) is a boundary point of the domain of definition, we impose that the above definition only holds for paths of approach that lie entirely in the domain. This is a generalization of the idea of a one-sided limit.


As an example, let's verify that

{{< katex display >}}
\lim_{z \rightarrow -2i} \frac{3z^2 - z + 6zi -2i}{z + 2i} = -6i - 1
{{< /katex >}}

We have to show that for a given \\( \epsilon \\) there is a \\( \delta \\)  such that

{{< katex display >}}
0 < |z + 2i| < \delta
{{< /katex >}}

this implies

{{< katex display >}}
\left| \frac{3z^2 - z + 6zi -2i}{z + 2i}  +6i + 1 \right| < \epsilon \\
\left| \frac{(3z - 1)(z + 2i)}{(z + 2i)} + 6i + 1 \right| < \epsilon \\
|3z + 6i| < \epsilon \\
|z + 2i| < \epsilon/3
{{< /katex >}}

It follows that if we choose \\( \delta < \epsilon  / 3 \\) then the condition is satisfied and we have verified the limit statement.

We can extend the limit concept to the point at infinity by saying that

{{< katex display >}}
\lim_{z \rightarrow \infty} f(z) = w_0
{{< /katex >}}

if for sufficiently small \\( \epsilon > 0 \\) there is a \\( \delta > 0 \\) such that

{{< katex display >}}
|z | > \frac{1}{\delta} \rightarrow | f(x) - w_0 | < \epsilon
{{< /katex >}}

A function is called **continuous** at \\( z_0 \\) if

{{< katex display >}}
f(z_0) = \lim_{z \rightarrow z_0} f(z)
{{< /katex >}}

In terms of \\( \epsilon \\)  and \\( \delta \\) we have that \\( f(z) \\) is continuous at \\( z = z_0 \\) if
{{< katex display >}}
\forall \epsilon > 0 \quad \exist \delta > 0 : \quad |z - z_0| < \delta \rightarrow |f(x) - f(z_0)| < \epsilon
{{< /katex >}}

The same algebraic properties that hold for limits also hold for continuous functions. The sum of continuous functions is continuous, the product of continuous functions is continuous, etc.

It follows immediately from the definition that if \\( f(z) \\) is continuous at \\( z_0 \\)  then so is \\( f(z) \\). So if \\( f(z) \\) is continuous at \\( z_0 \\), so are \\( f(z) \\) , \\( Re(f(z)) \\), \\( Im(f(z)) \\), and \\( |f(z)|^2 \\), since all of these are sums and products of continuous functions in this case.

We say that a function is continuous in a region if it is continuous at every point in the region. Typically, \\( \delta \\) depends on which point \\( z_0 \\) in the region is being considered, e.g. \\( \delta = \delta(\epsilon, z_0) \\). If \\( \delta \\) can be chosen to be independent of \\( z_0 \\), we say that \\( f(z) \\) is uniformly continuous in the region.

Let \\( f(z) \\) be defined in \\( \Reals \\), which contains a neighborhood of \\( z_0 \\). Then

{{< katex display >}}
\lim_{h \rightarrow 0} \frac{f(z_0 + h) - f(z_0)}{h} \colonequals f'(z_0)
{{< /katex >}}

is called the derivative of \\( f(z) \\) at \\( z_0 \\) if this limit exists. If so, then also

{{< katex display >}}
f'(z_0) = \lim_{z \rightarrow z_0} \frac{f(z) - f(z_0)}{z - z_0}
{{< /katex >}}

The funciton \\( f(z) \\) is differentiable in a region if its derivative at every point in the region is defined.

{{% hint info %}}
{{< katex display >}}
{{< /katex >}}
**Theorem**

If \\( f(z) \\) is differentiable at \\( z_0 \\) then \\( f(z) \\) is continuous at \\( z_0 \\)

**Proof**

{{< katex display >}}
\lim_{z \rightarrow z_0} (f(z) - f(z_0)) = \lim_{z \rightarrow z_0} \left( \frac{f(z) - f(z_0)}{z - z_0} \right) (z - z_0) \\
= \lim_{z \rightarrow z_0} \left( \frac{f(z) - f(z_0)}{z - z_0} \right) \lim_{z \rightarrow z_0} (z - z_0) \\
= f'(z_0) \cdot 0 \\
 = 0
{{< /katex >}}

{{% /hint %}}

For many features of complex functions, it suffices to repeat the proof in the real case in \\( \Reals \\). But there are some important consequences of being in two dimensions. As an example, consider \\( f(z) = \overline{z} \\). We know that this function is continuous for every \\( z_0 \in \Complex \\). However

{{< katex display >}}
\lim_{h \rightarrow 0} \frac{f(z + h) - f(z)}{h} = \lim_{h \rightarrow 0} \frac{\cancel{\overline{z}} + \overline{h} - \cancel{\overline{z}}}{h}
{{< /katex >}}

If we let \\( h = \epsilon e^{i \theta} \\) 
