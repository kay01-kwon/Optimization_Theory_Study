# Trust region newton method


## Trust region algorithm

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

J. Nocedal and S. J. Wright, *Numerical Optimization*, 2nd ed. Springer, 2006.
