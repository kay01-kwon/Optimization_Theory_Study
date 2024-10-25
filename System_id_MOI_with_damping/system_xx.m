function dsdt = system_xx(t, s, tau_x, Param)
%SYSTEM_XX 이 함수의 요약 설명 위치
%   자세한 설명 위치

J_xx = Param.J_xx;
W = Param.W;

y_CM = Param.y_CM;
z_CM = Param.z_CM;

c = Param.c;


theta = s(1);
theta_dot = s(2);

dsdt(1,1) = theta_dot;
dsdt(2,1) = 1/J_xx*(tau_x ...
    + W*(-y_CM*cos(theta) + z_CM*sin(theta)) ...
    - c*theta_dot);

end