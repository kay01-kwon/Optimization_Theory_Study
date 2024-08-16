# 1. Trust region newton method
## Subproblem

### 1.1 DogLeg algorithm
Derivation of $p^{U}$.

The line segment running from the origin to the minimizer of 

approximate model function along the steepest descent direction

is proportional to the gradient.

$p^{U} \propto g$

Hence, $p^{U} = \gamma g$

The differentiation of the model function with respect to the direction $p$

becomes like the below:

$\frac{\partial m_{k}(p)}{\partial p} = g + Bp = 0.$

Replace $p$ with $p^{U}$, then you can get the following equation:

$g + B \gamma g = 0.$

$\gamma g^{T} B g = - g^{T} g$

$\gamma = -\frac{g}{\left(g^{T}Bg\right)}$

Thus, the line segment $p^{U}$ becomes like the below:

$p^{U} = \frac{-g^{T} g}{\left(g^{T} B g\right)} g.$

### 1.2 Conjugate Gradient Steihaug

Boundary problem

$\norm{p_k}=\Delta_k$

# Gauss Newton method

<img src="/gauss newton method/gauss_newton_method_result.gif " width="50%" height="50%"/>

J. Nocedal and S. J. Wright, *Numerical Optimization*, 2nd ed. Springer, 2006.
