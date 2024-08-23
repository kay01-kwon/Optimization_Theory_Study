function ds = getDrk4Ode(dsdt, s0, curr_time, prev_time)
%RK4_ODE 이 함수의 요약 설명 위치
%   자세한 설명 위치

dt = curr_time - prev_time;

K1 = dsdt(prev_time, s0);
K2 = dsdt(prev_time + 0.5*dt, s0 + 0.5*K1*dt);
K3 = dsdt(prev_time + 0.5*dt, s0 + 0.5*K2*dt);
K4 = dsdt(prev_time + dt, s0 + K3*dt);

ds = 1/6*(K1 + 2*K2 + 2*K3 + K4)*dt;

end

