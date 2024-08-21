close all
clear all
clc


param_true = [10;10];

x = 0:0.01:10;
x = x';
N = length(x);
y = zeros(N,1);

for i = 1:N
    y(i) = actual_func(x(i), param_true) + normrnd(0,0.2);
end
meas = [x, y];

param0 = [0.5;0.5];


param_est = LevenbergMarquardt(@(x,p) model_func(x,p), param0, meas, 1e-6, 1e-6, 100, 100);

y_model = zeros(N,1);

for i = 1:N
    y_model(i) = model_func(x(i), param_est);
end


figure()

plot(x, y);
hold on;
plot(x, y_model)
grid on

function y = actual_func(x, param)
y = param(1)*x/(param(2)+x);
end