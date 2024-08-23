function dsdt = Rk4Model(t, s, u, param)
%RK_MODEL_FUNC 이 함수의 요약 설명 위치
%   자세한 설명 위치

A = [0 1;
    0 0];

B = [0;1/param];

dsdt = A*s + B*u;
end

