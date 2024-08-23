# 1. Trust region newton method
<img src="/trust region newton method/trust_region_algorithm_figure.png" width="80%" height="80%"/>

## Subproblem

### 1.1 DogLeg algorithm

<img src="/trust region newton method/dogleg_algorithm.png" width="30%" height="30%"/>

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

<img src="/CG_Steihaug/cg_steihaug_algorithm.png" width="30%" height="30%"/>

Boundary problem

$\lVert p_{k} \rVert=\Delta_k$

where $p_{k} = z_{j} + \tau d_{j}.$

$\left(z_{j} + \tau d_{j} \right)^{T}\left(z_{j} + \tau d_{j} \right) = \Delta_{k}^{2}$

$\tau^2 d_{j}^{T} d_{j} + 2 \tau d_{j}^{T} z_{j} + z_{j}^{T} z_{j} - \Delta_{k}^2 = 0$

$\therefore \tau = \frac{-b \pm \sqrt{b^2 - ac}}{a}$

where $a = d_{j}^{T} d_{j}, b = d_{j}^{T} z_{j}, c = z_{j}^{T} z_{j} - \Delta_{k}^{2}.$

$\tau_{+} = \frac{-b + \sqrt{b^2 -ac}}{a}$

and

$\tau_{-} = \frac{-b - \sqrt{b^2 -ac}}{a}$

When finding $\tau$ such that $p_{k} = z_{j} + \tau d_{j}$ minimizes $m_{k}\left(p\right)$ in (4.5) and satisfies $\lVert p_{k} \rVert = \Delta_{k}$,

choose one between $\tau_{+}$ and $\tau_{-}$.

Specifically, let $p_{k,+} = z_{j} + \tau_{+} d_{j}$ and $p_{k,-} = z_{j} + \tau_{-} d_{j}$ be.

Then, $m(p_{k,+})$ and $m(p_{k,-})$ becomes like 

$g_{k}^{T} p_{k,+} + \frac{1}{2} p_{k,+}^{T} B p_{k,+}$ and $g_{k}^{T} p_{k,-} + \frac{1}{2} p_{k,-}^{T} B p_{k,-}$, respectively.

By comparing the value of $m(p_{k,+})$ and $m(p_{k,-})$, you can find out the right $\tau$.

# 2. Gauss Newton method

<img src="/gauss newton method/gauss_newton_algorithm.png" width="50%" height="50%"/>

<img src="/gauss newton method/gauss_newton_method_result.gif " width="50%" height="50%"/>

# 3. Levenberg Marquardt method

Damped gauss newton method

It prevents parameter from moving far away 

from the optimal solution when the approximation is poor.

Otherwise, the method makes it possible for the parameter 

to converge to the optimal solution as fast as possible.

A large value of $\rho$ implies that the approximation is good.

In this case, by decreasing $\mu$, the method becomes getting closer to Gauss-Newton method.

If $\rho$ is small or negative, the approximation of model is poor,

increase $\mu$ and $\nu$ through multiplicating by $\nu$ and 2, respectively.

Since the $mu$ is incresaed, the method is getting closer to the steepest descent method.

Also, it reduces the step size to move the estimated parameter in the wrong direction quite a lot.

<img src="/Levenberg marquardt method/Levenberg_marquardt_algorithm.jpg" width="30%" height="30%"/>

<img src="/Levenberg marquardt method/test_lm_result.gif" width="50%" height="50%"/>

# 4. System identification through gauss newton method

<img src="/System Id through Gauss Newton method/system_id.gif"/>



# 5. Reference

J. Nocedal and S. J. Wright, *Numerical Optimization*, 2nd ed. Springer, 2006.

Levenberg marquardt method

K. Madsen, H.B. Nielsen, and O. Tingleff, *Methods for non-linear least squares problems*, 2nd ed. 2004.
