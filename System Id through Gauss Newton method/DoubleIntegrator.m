function dsdt = DoubleIntegrator(t, s, u, m)
%DOUBLEINTEGRATOR 이 함수의 요약 설명 위치
%   자세한 설명 위치

A = [0 1;
    0 0];

B = [0;1/m];

dsdt = A*s + B*u;

end

