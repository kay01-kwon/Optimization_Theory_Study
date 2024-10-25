function [param_k, damp_param_k] = GaussNewton(Param_init, meas, eps, max_iter, param_true, damp_param_true)
%LEVENBERGMARQUARDT 이 함수의 요약 설명 위치
%  


Param_est.y_CM = Param_init.y_CM;
Param_est.z_CM = Param_init.z_CM;
Param_est.W = Param_init.W;
Param_est.J_xx = Param_init.J_xx;
Param_est.c = Param_init.c;

param_k = Param_init.J_xx;
damp_param_k = Param_init.c;

[~, m] = size(meas);
n = 1;

A1 = zeros(n,n);
A2 = zeros(n,n);

g1 = zeros(n,1);
g2 = zeros(n,1);

batchSize = 50;

[A1, g1, A2, g2] = getJacobiGrad(meas, Param_est, batchSize);

if sqrt(g1'*g1) + sqrt(g2'*g2) <= eps
    return;
end

step_vec = zeros(max_iter, 1);
param_vec = zeros(max_iter,1);
damp_param_vec = zeros(max_iter,1);
param_true_vec = zeros(max_iter, 1);
damp_param_true_vec = zeros(max_iter, 1);

figure(3)
hold on

width=1200;
height=400;
set(gcf,'position',[100,100,width,height])



for i = 1:max_iter


    h_gn1 = -A1\g1;
    h_gn2 = -A2\g2;


    [A1, g1, A2, g2, residual_array, s_rk4_array] = getJacobiGrad(meas, Param_est, batchSize);
    % 
    if sqrt(g1'*g1) <= eps
        break;
    end

    step_vec(i) = i;

    param_k = param_k + h_gn1
    damp_param_k = damp_param_k + h_gn2
    Param_est.J_xx = param_k;
    Param_est.c = damp_param_k;

    param_vec(i) = param_k;
    damp_param_vec(i) = damp_param_k;

    param_true_vec(i) = param_true;
    damp_param_true_vec(i) = damp_param_true;

    if mod(i,10) == 0
    % 
    clf

    subplot(151)
    histogram(residual_array)
    xlabel('residual')
    ylabel('probability')

    subplot(152)
    plot(meas(1,:), meas(3,:)*180/pi)
    hold on
    plot(meas(1,1:end-1), s_rk4_array(1,:)*180/pi, 'linewidth', 2)
    xlabel('time (s)')
    ylabel('\theta (deg)')
    legend('\theta_{obs}', '\theta_{model}')
    title('\theta - t')

    grid on

    subplot(153)
    plot(meas(1,:), meas(4,:))
    hold on
    plot(meas(1,1:end-1), s_rk4_array(2,:), 'linewidth', 2)
    xlabel('time (s)')
    ylabel('\omega (rad/s)')
    legend('\omega_{obs}', '\omega_{model}')
    title('\omega - t')

    grid on

    subplot(154)
    plot(step_vec(1:i),param_vec(1:i),'LineWidth',2)
    hold on
    plot(step_vec(1:i), param_true_vec(1:i),'--','LineWidth',2)
    xlabel('step')
    ylabel('J_{xx} (kg m^2)')
    legend('J_{xx,est}','J_{xx,true}')
    title('J_{xx} - iteration step')

    grid on

    subplot(155)
    plot(step_vec(1:i),damp_param_vec(1:i),'LineWidth',2)
    hold on
    plot(step_vec(1:i), damp_param_true_vec(1:i),'--','LineWidth',2)
    xlabel('step')
    ylabel('c (Nm/(rad/s))')
    legend('c_{est}','c_{true}')
    title('c - iteration step')

    grid on

    pause(0.1)

    exportgraphics(gcf,'system_id_test.gif','Resolution',600,'Append',true)
    end
end


end