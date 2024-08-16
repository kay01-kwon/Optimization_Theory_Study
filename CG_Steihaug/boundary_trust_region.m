function [tau_plus, tau_minus] = boundary_trust_region(z, d, trust_radius)
%BOUNDARY 이 함수의 요약 설명 위치
%   자세한 설명 위치

a = d'*d;
b = d'*z;
c = z'*z - trust_radius^2;

tau_plus = (-b + sqrt(b^2 - a*c))/a;
tau_minus = (-b - sqrt(b^2 - a*c))/a;

end

