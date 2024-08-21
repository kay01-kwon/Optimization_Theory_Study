function [residual, y_model] = getRESandYmodel(model_func, meas, param_k)
%GETRMSE 이 함수의 요약 설명 위치
%   자세한 설명 위치

[m,~] = size(meas);
[n,~] = size(param_k);

y_model = zeros(m,1);
residual = zeros(m,1);
rmse = 0;

for j = 1:m
    [f, ~] = model_func(meas(j,1), param_k);
    y_model(j) = f;
    residual(j) = f - meas(j,2);
    rmse = rmse + residual(j)^2;
end


end

