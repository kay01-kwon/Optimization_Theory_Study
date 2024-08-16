function [grad,hessian] = model_func(x)
%MODEL_FUNC 이 함수의 요약 설명 위치
%   자세한 설명 위치

grad_x = -2 + 2*x(1) + 400*x(1)^3 - 400*x(1)*x(2);
grad_y = 200*(x(2) - x(1)^2);

grad = [grad_x; grad_y];

hessian_xx = 2 + 1200*x(1)^2 - 400*x(2);
hessian_xy = -400*x(1);
hessian_yx = hessian_xy;
hessian_yy = 200;

hessian = [hessian_xx, hessian_xy;
            hessian_yx, hessian_yy];

end

