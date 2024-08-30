function param_k = LevenbergMarquardt(actual_func, param0, eps1, eps2, tau, max_iter)
%LEVENBERGMARQUARDT 이 함수의 요약 설명 위치
%  

tic

param_k = param0;


param_k_plot = zeros(max_iter+1,2);

figure(2)

hold on

plot(param_k(1), param_k(2), 'MarkerSize', 20, 'Marker', '.','Color','b');

[n, ~] = size(param0);


mu = zeros(1,1);
nu = 2;

A = zeros(n,n);
g = zeros(n,1);

[g, A] = model_func(param_k);

if sqrt(g'*g) <= eps1
    return;
end

mu = tau*max_A(A);


for i = 1:max_iter

    h_lm = -(A+mu*eye(n))\g;

    if sqrt(h_lm'*h_lm) <= eps2*(sqrt(param_k'*param_k) + eps2)
        break;
    else
        param_new = param_k + h_lm;
        rho = Rho2(actual_func, g, param_k, h_lm, mu);

        if rho > 0
            param_k = param_new;

            [g, A] = model_func(param_k);

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

    param_k_plot(i,1) = param_k(1);
    param_k_plot(i,2) = param_k(2);

    i
    % param_k

    plot(param_k_plot(i,1), param_k_plot(i,2),'markersize',20,'Marker','.','Color','k');
    str = int2str(i);
    text(param_k_plot(i,1)+0.05, param_k_plot(i,2), str);
end
toc

end