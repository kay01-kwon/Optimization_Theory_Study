# Trust region newton method


## Trust region algorithm

Given $\hat{\Delta}$, $\Delta_{0}\in \left(0, \hat{\Delta}\right)$, and $\eta$

k = 0, 1, 2, ...

$min m_{k}(p) = f_{k} + g_{k}^{T}p + \frac{1}{2}p^{T}B_{k}p
s.t. ||p|| \le \Delta_{k}
$

if $\rho_{k} < \frac{1}{4}$
  $\Delta_{k+1} = \frac{1}{4} \Delta_{k}$
else
  if $\rho_{k} > \frac{3}{4}$ && $||p_{k}|| == \Delta_{k}$
    $\Delta_{k+1} = min(2\Delta_{k}, \hat{\Delta})$
  else
    $\Delta_{k+1} = \Delta_{k}$

if $\rho_{k} > \eta$
  $x_{k+1} = x_{k} + p_{k}$
else
  $x_{k+1} = x_{k}$

