function [A,g,residual_array, s_rk4_array] = getJacobiGrad(meas, param_k)
%GETJACOBIGRAD 이 함수의 요약 설명 위치
%   자세한 설명 위치

[dim_meas,meas_length] = size(meas);
[n,~] = size(param_k);

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


Q = eye(dim_state);

Q = 100*Q;

residual = 0;

residual_array = zeros(m,1);

for i = 1:m

    dt_ = t(i+1) - t(i);
    u_ = u(i);


    s_rk4 = s_rk4 + getDrk4Ode(@(t,s) RK4Model(t, s, u_, param_k), s_rk4, t(i+1), t(i));
    s_rk4_Grad = s_rk4_Grad + getRK4Grad(dt_, u_, param_k);


    s_tilde = s_obs(:,i+1) - s_rk4;


    s_rk4_array(:,i) = s_rk4;
    s_tilde_array(:,i) = s_tilde;


    % A = A + (-s_tilde'*s_rk4_Grad)'*(-s_tilde'*s_rk4_Grad);
    % g = g + (-s_tilde'*s_rk4_Grad)'*residual;
    A = A + s_rk4_Grad'*Q*s_rk4_Grad;
    g = g - s_tilde'*Q*s_rk4_Grad;


    residual = sign(g)*s_tilde'*s_tilde;
    residual_array(i,1) = residual;

end

end

