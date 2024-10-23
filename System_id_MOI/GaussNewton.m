function param_k = GaussNewton(Param_init, meas, eps, max_iter, param_true)
%LEVENBERGMARQUARDT 이 함수의 요약 설명 위치
%  


Param_est.y_CM = Param_init.y_CM;
Param_est.z_CM = Param_init.z_CM;
Param_est.W = Param_init.W;
Param_est.J_xx = Param_init.J_xx;
param_k = Param_init.J_xx;

[~, m] = size(meas);
n = 1;

A = zeros(n,n);
g = zeros(n,1);

batchSize = 50;

[A, g] = getJacobiGrad(meas, Param_est, batchSize);

if sqrt(g'*g) <= eps
    return;
end

step_vec = zeros(max_iter, 1);
param_vec = zeros(max_iter,1);
param_true_vec = zeros(max_iter, 1);

figure(3)
hold on

width=1200;
height=400;
set(gcf,'position',[100,100,width,height])



for i = 1:max_iter


    h_gn = -A\g;


    [A, g, residual_array, s_rk4_array] = getJacobiGrad(meas, Param_est, batchSize);
    % 
    if sqrt(g'*g) <= eps
        break;
    end

    step_vec(i) = i;

    param_k = param_k + h_gn
    Param_est.J_xx = param_k;

    param_vec(i) = param_k;
    param_true_vec(i) = param_true;

    % if mod(i,50) == 0
    % 
    clf

    subplot(141)
    histogram(residual_array)
    xlabel('residual')
    ylabel('probability')

    subplot(142)
    plot(meas(1,:), meas(3,:)*180/pi)
    hold on
    plot(meas(1,1:end-1), s_rk4_array(1,:)*180/pi, 'linewidth', 2)
    xlabel('time (s)')
    ylabel('\theta (deg)')
    legend('\theta_{obs}', '\theta_{model}')
    title('\theta - t')

    grid on

    subplot(143)
    plot(meas(1,:), meas(4,:))
    hold on
    plot(meas(1,1:end-1), s_rk4_array(2,:), 'linewidth', 2)
    xlabel('time (s)')
    ylabel('\omega (rad/s)')
    legend('\omega_{obs}', '\omega_{model}')
    title('\omega - t')

    grid on

    subplot(144)
    plot(step_vec(1:i),param_vec(1:i),'LineWidth',2)
    hold on
    plot(step_vec(1:i), param_true_vec(1:i),'--','LineWidth',2)
    xlabel('step')
    ylabel('J_{xx} (kg)')
    legend('J_{xx,est}','J_{xx,true}')
    title('J_{xx} - iteration step')

    grid on

    pause(0.1)

    % exportgraphics(gcf,'system_id_test.gif','Resolution',600,'Append',true)
    % end
end


end