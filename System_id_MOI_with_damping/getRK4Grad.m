function [s_next, dKdJ, DKDc] = getRK4Grad(dt, s_i, tau_x, Param_est)
%GETRK4GRAD 이 함수의 요약 설명 위치
%   자세한 설명 위치

y_CM = Param_est.y_CM;
z_CM = Param_est.z_CM;
W = Param_est.W;
c = Param_est.c;


J_xx = Param_est.J_xx;

theta_i = s_i(1);
w_i = s_i(2);

K1 = [w_i;
    1/J_xx*(tau_x + W * (-y_CM*cos(theta_i) + z_CM*sin(theta_i)) - c*w_i)];

DK1DJ = [0;
    -1/J_xx*K1(2)];

DK1Dc = [0;
        -1/J_xx*w_i];

theta_m1 = theta_i + dt/2*K1(1);
w_m1 = w_i + dt/2*K1(2);

Dw_m1 = dt/2*DK1DJ(2);
Dw_m1Dc = dt/2*DK1Dc(2);

K2 = [w_m1;
    1/J_xx*(tau_x + W * (-y_CM*cos(theta_m1) + z_CM*sin(theta_m1)) - c*w_m1)];

DK2DJ = [Dw_m1;
    -1/J_xx*K2(2)];

DK2Dc = [Dw_m1Dc;
        -1/J_xx*(w_m1 + c*Dw_m1Dc)];

theta_m2 = theta_i + dt/2*K2(1);
w_m2 = w_i + dt/2*K2(2);

Dtheta_m2 = dt/2*DK2DJ(1);
Dw_m2 = dt/2*DK2DJ(2);

Dtheta_m2Dc = dt/2*DK2Dc(1);
Dw_m2Dc = dt/2*DK2Dc(2);

K3 = [w_m2;
    1/J_xx*(tau_x + W * (-y_CM*cos(theta_m2) + z_CM*sin(theta_m2)) - c*w_m2)];

DK3DJ = [Dw_m2;
    -1/J_xx*K3(2) + W/J_xx*( y_CM*sin(theta_m2) + z_CM*cos(theta_m2))*Dtheta_m2];

DK3Dc = [Dw_m2Dc;
    -1/J_xx*(w_m2 + c*Dw_m2Dc) + W/J_xx*( y_CM*sin(theta_m2) + z_CM*cos(theta_m2))*Dtheta_m2Dc];

theta_f = theta_i + dt*K3(1);
w_f = w_i + dt*K3(2);

Dtheta_f = dt*DK3DJ(1);
Dw_f = dt*DK3DJ(2);

Dtheta_fDc = dt*DK3Dc(1);
Dw_fDc = dt*DK3Dc(2);

K4 = [w_f;
    1/J_xx*(tau_x + W * (-y_CM*cos(theta_f) + z_CM*sin(theta_f)) - c*w_f)];

DK4DJ = [Dw_f;
    -1/J_xx*K4(2) + W/J_xx*( y_CM*sin(theta_f) + z_CM*cos(theta_f) )*Dtheta_f];

DK4Dc = [Dw_fDc;
    -1/J_xx*(w_f + c*Dw_fDc) + W/J_xx*( y_CM*sin(theta_f) + z_CM*cos(theta_f) )*Dtheta_fDc];

s_next = s_i + 1/6*dt*(K1 + 2*K2 + 2*K3 + K4);
dKdJ = 1/6*dt*(DK1DJ + 2*DK2DJ + 2*DK3DJ + DK4DJ);
DKDc = 1/6*dt*(DK1Dc + 2*DK2Dc + 2*DK3Dc + DK4Dc);
end