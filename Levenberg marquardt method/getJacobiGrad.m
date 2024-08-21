function [A,g] = getJacobiGrad(model_func, meas, param_k)
%GETJACOBIGRAD 이 함수의 요약 설명 위치
%   자세한 설명 위치

[m,~] = size(meas);
[n,~] = size(param_k);

A = zeros(n,n);
g = zeros(n,1);


for j = 1:m
    [f, dresidual] = model_func(meas(j,1), param_k);
    % y_model(j) = f;
    % residual(j) = f - meas(j,2);
    A = A + dresidual * dresidual';
    g = g + (f-meas(j,2))*dresidual;
end


end

