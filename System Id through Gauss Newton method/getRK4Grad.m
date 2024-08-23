function ds_i_rk4 = getRK4Grad(dt_i, u_i, param_k)
%GETRK4GRAD 이 함수의 요약 설명 위치
%   자세한 설명 위치

ds_i_rk4 = 1/6*[-3*dt_i*u_i/param_k^2;
            -6*u_i/param_k^2];

end