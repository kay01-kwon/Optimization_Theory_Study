function [s_next, dKdJ] = getRK4Grad(dt, s_i, tau_x, Param_est)
%GETRK4GRAD 이 함수의 요약 설명 위치
%   자세한 설명 위치

y_CM = Param_est.y_CM;
z_CM = Param_est.z_CM;
W = Param_est.W;

J_xx = Param_est.J_xx;

theta_i = s_i(1);
w_i = s_i(2);

K1 = [w_i;
    1/J_xx*(tau_x - W * (y_CM*cos(theta_i) + z_CM*sin(theta_i)) )];

DK1 = [0;
    -1/J_xx*K1(2)];

theta_m1 = theta_i + dt/2*K1(1);
w_m1 = w_i + dt/2*K1(2);

Dw_m1 = dt/2*DK1(2);

K2 = [w_m1;
    1/J_xx*(tau_x - W * (y_CM*cos(theta_m1) + z_CM*sin(theta_m1)) )];

DK2 = [Dw_m1;
    -1/J_xx*K2(2)];

theta_m2 = theta_i + dt/2*K2(1);
w_m2 = w_i + dt/2*K2(2);

Dtheta_m2 = dt/2*DK2(1);
Dw_m2 = dt/2*DK2(2);

K3 = [w_m2;
    1/J_xx*(tau_x - W * (y_CM*cos(theta_m2) + z_CM*sin(theta_m2)) )];

DK3 = [Dw_m2;
    -1/J_xx*K3(2) - W/J_xx*( -y_CM*sin(theta_m2) + z_CM*cos(theta_m2))*Dtheta_m2];

theta_f = theta_i + dt*K3(1);
w_f = w_i + dt*K3(2);

Dtheta_f = dt*DK3(1);
Dw_f = dt*DK3(2);

K4 = [w_f;
    1/J_xx*(tau_x - W * (y_CM*cos(theta_f) + z_CM*sin(theta_f)) )];

DK4 = [Dw_f;
    -1/J_xx*K4(2) - W/J_xx*( -y_CM*sin(theta_f) + z_CM*cos(theta_f) )*Dtheta_f];

s_next = s_i + 1/6*dt*(K1 + 2*K2 + 2*K3 + K4);
dKdJ = 1/6*dt*(DK1 + 2*DK2 + 2*DK3 + DK4);

end