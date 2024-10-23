function [A,g,residual_array, s_rk4_array] = getJacobiGrad(meas, Param_est, batchSize)
%GETJACOBIGRAD 이 함수의 요약 설명 위치
%   자세한 설명 위치

[dim_meas,meas_length] = size(meas);
n = 1;

dim_state = dim_meas - 2;

m = meas_length - 1;

A = zeros(n,n);
g = zeros(n,1);

t = meas(1,:);
u = meas(2,:);
s_obs = meas(3:end,:);
s_obs0 = s_obs(:,1);

s_rk4 = s_obs0;
s_rk4_Grad = zeros(dim_state, n);


s_rk4_array = zeros(dim_state, m);
s_tilde_array = zeros(dim_state,m);


Q = 100*eye(dim_state);
% Q(1,1) = 100;

residual = 0;

residual_array = zeros(m,1);

for i = 1:m

    dt_ = t(i+1) - t(i);
    u_ = u(i);

    if mod(i,batchSize) == 0
        [s_rk4, s_rk4_Grad_] = getRK4Grad(dt_, s_obs(:,i), u_, Param_est);
    else
        [s_rk4, s_rk4_Grad_] = getRK4Grad(dt_, s_rk4, u_, Param_est);
    end


    s_rk4_Grad = s_rk4_Grad + s_rk4_Grad_;



    s_tilde = s_obs(:,i+1) - s_rk4;
    
    s_rk4_array(:,i) = s_rk4;
    s_tilde_array(:,i) = s_tilde;

    residual = s_tilde'*s_tilde;

    A = A + s_rk4_Grad'*Q*s_rk4_Grad;
    g = g - s_tilde'*Q*s_rk4_Grad;

    residual_array(i,1) = sign(g)*residual;
end

end

