function param_k = gauss_newton(model_func, param0, meas, tol, max_iter)
%GAUSS_NEWTON 이 함수의 요약 설명 위치
%   [Function value, Gradient] = model_func(x)
%   meas(i,j) --> i: measurement step, 
%   j = 1: input
%   j = 2: output

[m, ~] = size(meas);
[n, ~] = size(param0);

residual = zeros(m,1);
dresidual = zeros(n,1);

y_model = zeros(m,1);


figure()
hold on

param_k = param0;

for i = 1:max_iter

    rmse = 0;

    A = zeros(n,n);
    b = zeros(n,1);

    for j = 1:m
        [f, dresidual] = model_func(meas(j,1), param_k);
        y_model(j) = f;
        residual(j) = f - meas(j,2);
        b = b + residual(j)*dresidual;
        A = A + dresidual * dresidual';
        rmse = rmse + residual(j)^2;
    end


    p = -inv(A)*b;

    param_k = param_k + p;
    
    clf
    subplot(121)
    histogram(residual)
    xlabel('residual')
    ylabel('probability')

    subplot(122)
    plot(meas(:,1), meas(:,2));
    hold on
    plot(meas(:,1), y_model, LineWidth=2);
    xlabel('x')
    ylabel('y')
    legend("Measured data", "Data from predicted model")

    grid on

    pause(0.1)

    exportgraphics(gcf, 'test_gauss_newton.gif','Resolution',600,'Append',true);
    

    if rmse < tol
        break;
    end
end