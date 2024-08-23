function param_k = GaussNewton(param0, meas, eps, max_iter, param_true)
%LEVENBERGMARQUARDT 이 함수의 요약 설명 위치
%  


param_k = param0;

[~, m] = size(meas);
[n, ~] = size(param0);



A = zeros(n,n);
g = zeros(n,1);

[A, g] = getJacobiGrad(meas, param_k);

if sqrt(g'*g) <= eps
    return;
end

step_vec = zeros(max_iter, 1);
param_vec = zeros(max_iter,1);
param_true_vec = zeros(max_iter, 1);

figure(1)
hold on

width=1200;
height=400;
set(gcf,'position',[100,100,width,height])

for i = 1:max_iter


    h_gn = -A\g;

        [A, g, residual_array, s_rk4_array] = getJacobiGrad(meas, param_k);
    % 
    if sqrt(g'*g) <= eps
        break;
    end

    step_vec(i) = i;

    param_k = param_k + h_gn;
    param_vec(i) = param_k;
    param_true_vec(i) = param_true;

    if mod(i,50) == 0

    clf
    
    subplot(141)
    histogram(residual_array)
    xlabel('residual')
    ylabel('probability')

    subplot(142)
    plot(meas(1,:), meas(3,:))
    hold on
    plot(meas(1,1:end-1), s_rk4_array(1,:), 'linewidth', 2)
    xlabel('time (s)')
    ylabel('position (m)')
    legend('x_{obs}', 'x_{model}')
    title('x - t')

    grid on

    subplot(143)
    plot(meas(1,:), meas(4,:))
    hold on
    plot(meas(1,1:end-1), s_rk4_array(2,:), 'linewidth', 2)
    xlabel('time (s)')
    ylabel('velocity (m/s)')
    legend('v_{obs}', 'v_{model}')
    title('v - t')

    grid on

    subplot(144)
    plot(step_vec(1:i),param_vec(1:i))
    hold on
    plot(step_vec(1:i), param_true_vec(1:i))
    xlabel('step')
    ylabel('m (kg)')
    legend('m_{est}','m_{true}')
    title('m - iteration step')
    
    grid on

    pause(0.01)

    exportgraphics(gcf,'system_id.gif','Resolution',600,'Append',true)
    end
end


end