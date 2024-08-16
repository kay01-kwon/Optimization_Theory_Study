function rho = Rho(actual_func, g, B, x, p)
%RHO
% The ratio of actual reduction to predicted one

actual_reduction = actual_func(x) - actual_func(x + p);

% m(0) - m(p) = (f) - (f + g'*p + 0.5*p'*B*p)
% m(0) - m(p) = - g'*p - 0.5*p'*B*p
predicted_reduction = -g'*p - 0.5*p'* B* p;

rho = actual_reduction/predicted_reduction;
end

