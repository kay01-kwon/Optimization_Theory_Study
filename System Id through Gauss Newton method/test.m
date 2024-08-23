close all
clear all
clc

dt = 0.01;
t_f = 10;

time = 0:dt:t_f;

N = length(time);

s0 = [0 0]';

s_obs = zeros(2,N);
ds_obs = zeros(2,N-1);

m_true = 0.006;
u = zeros(1,N);

sigma = [0.1;0.1];

noise = zeros(2, N);

for i = 1:N-1

    tspan = [time(i) time(i+1)];

    u(i) = 0.01*cos(time(i));

    [t, s] = ode45(@(t,s) DoubleIntegrator(t,s,u(i),m_true), tspan, s0);

    s0 = s(end,:);

    noise(:,i) = normrnd(0,sigma);

    s_obs(:,i+1) = s0' + normrnd(0,sigma);

end





param0 = 0.1;

meas = [time; u; s_obs];

param_est = GaussNewton(param0, meas, 1e-10, 2000, m_true);


