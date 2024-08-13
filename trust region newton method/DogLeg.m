function p_tau = DogLeg(g, B, trust_radius)
%DOGLEG
% DogLeg algorithm implementation

% Full step (Newton method)
p_B = -inv(B)*g;

% Norm of the full step
norm_p_B = sqrt(p_B'*p_B);

% Full step inside the trust region
if norm_p_B <= trust_radius
    p_tau = p_B;
    return;
end

% Steepest gradient descent
p_U = -g'*g/(g'*B*g)*g;

% Norm of the gradient
norm_p_U = sqrt(p_U'*p_U);

% Gradient outside the trust region
if norm_p_U >= trust_radius
    tau = trust_radius/norm_p_U;
    p_tau = tau*p_U;
    return;
end

diff_p = p_B - p_U;
norm_diff_p = sqrt(diff_p'*diff_p);


a = norm_diff_p^2;
b = norm_p_U*norm_diff_p;
c = norm_p_U^2 - trust_radius^2;

alpha = (-b + sqrt(b^2-a*c))/a;

tau = alpha + 1;

assert(tau >= 0)
assert(tau <= 2)

if tau < 1
    p_tau = tau*p_U;
else
    p_tau = p_U + (tau-1)*diff_p;


end