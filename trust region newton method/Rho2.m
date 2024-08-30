function rho = Rho2(actual_func, g, x, p, mu)
%RHO
% The ratio of actual reduction to predicted one

actual_reduction = actual_func(x) - actual_func(x + p);

% m(0) - m(p) = (f) - (f + g'*p + 0.5*p'*B*p)
% m(0) - m(p) = - g'*p - 0.5*p'*B*p
predicted_reduction = 1/2*p'*(mu*p - g);

rho = actual_reduction/predicted_reduction;
end

