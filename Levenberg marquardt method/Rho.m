function rho = Rho(model_func, meas, param_k, h, g, mu)
%RHO
% The ratio of actual reduction to predicted one

[m, ~] = size(meas);

F_param = 0;
F_param_new = 0;

for i = 1:m
    F_param = F_param + 1/2*(meas(i,2) - model_func(meas(i,1), param_k))^2;
    F_param_new = F_param_new + 1/2*(meas(i,2) - model_func(meas(i,1), param_k + h))^2;
end

actual_reduction = F_param - F_param_new;
predicted_reduction = 1/2*h'*(mu*h - g);

rho = actual_reduction/predicted_reduction;
end