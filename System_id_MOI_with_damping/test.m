close all
clear all
clc

dt = 0.01;
t_f = 10;

time = 0:dt:t_f;

N = length(time);

s0 = [20*pi/180 0]';

s_obs = zeros(2,N);

s_obs(:,1) = s0;
ds_obs = zeros(2,N-1);

% True parameter setup
Param.J_xx = 0.020;
Param.W = 2*9.81;
Param.y_CM = 0.00;
Param.z_CM = -0.02;
Param.c = 0.01;

Param_est.y_CM = Param.y_CM;
Param_est.z_CM = Param.z_CM;
Param_est.W = Param.W;
Param_est.J_xx = 0.0020;
Param_est.c = 0;

u = zeros(1,N);

% Angular position and velocity data noise setup
sigma = [0.01;0.01];
noise = zeros(2, N);

Kp = 0.1;
Kd = 0.03;

s_rk4 = s0;

s_rk4_array = zeros(2,N);
s_rk4_array(:,1) = s0;

for i = 1:N-1

    tspan = [time(i) time(i+1)];

    [t, s] = ode45(@(t,s) system_xx(t,s,u(i),Param), tspan, s0);

    dt_ = time(i+1) - time(i);

    % [s_rk4, s_rk4_Grad_] = getRK4Grad(dt_, s_rk4, u(i), Param_est);
    % ds = getDrk4Ode(@(t,s) system_xx(t, s, u(i), Param), s_rk4, time(i+1), time(i));

    % s_rk4 = s_rk4 + ds;

    s_rk4_array(:,i+1) = s_rk4;

    s0 = s(end,:);

    noise(:,i) = normrnd(0,sigma);

    s_obs(:,i+1) = s0' + normrnd(0,sigma);

    % u(i+1) = -Kp*s_obs(1,i+1) - Kd*s_obs(2,i+1);
    u(i+1) = 0;

end

% figure(1)
% plot(time, s_obs(1,:)*180/pi);
% hold on
% plot(time, s_rk4_array(1,:)*180/pi,'LineWidth',2);
% 
% figure(2)
% plot(time, s_obs(2,:))
% hold on
% plot(time, s_rk4_array(2,:),'LineWidth',2);


meas = [time; u; s_obs];

param_est = GaussNewton(Param_est, meas, 1e-10, 1000, Param.J_xx, Param.c);


