function [f,g] = model_func(x, param)
%MODEL_FUNC 이 함수의 요약 설명 위치
%   자세한 설명 위치

f = param(1)*x/(param(2)+x);

g_p1 = x/(param(2)+x);

g_p2 = -param(1)/(param(2)+x)^2;

g = [g_p1;g_p2];

end