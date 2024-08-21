function param_k = LevenbergMarquardt(model_func, param0, meas, eps1, eps2, tau, max_iter, trust_radius)
%LEVENBERGMARQUARDT 이 함수의 요약 설명 위치
%  
param_k = param0;

[m, ~] = size(meas);
[n, ~] = size(param0);

residual = zeros(m,1);
dresidual = zeros(n,1);

y_model = zeros(m,1);

mu = zeros(1,1);
nu = 2;

A = zeros(n,n);
g = zeros(n,1);

[A, g] = getJacobiGrad(model_func, meas, param_k);

if sqrt(g'*g) <= eps1
    return;
end

mu = tau*max_A(A);


for i = 1:max_iter

    rmse = 0;
    
    h_lm = -(A+mu*eye(n))\g;

    if sqrt(h_lm'*h_lm) <= eps2*(sqrt(param_k'*param_k) + eps2)
        break;
    else
        param_new = param_k + h_lm;
        rho = Rho(model_func, meas, param_k, h_lm, g, mu);

        if rho > 0
            param_k = param_new;

            [A, g] = getJacobiGrad(model_func, meas, param_k);

        if sqrt(g'*g) <= eps1
            break;
        end

            mu = mu*max([1/3, 1 - (2*rho-1)^3]);
            nu = 2;
        else
            mu = mu*nu;
            nu = 2*nu;
        end
    end
end


end