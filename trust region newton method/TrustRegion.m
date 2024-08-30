function x_k = TrustRegion(actual_func, model_grad_hes_func, x0, eta, tol, max_iter, trust_radius, max_trust_radius)
%TRUSTREGION 이 함수의 요약 설명 위치
%   자세한 설명 위치

x_k = x0;


x_k_plot = zeros(max_iter+1,2);

tic

figure(1)

hold on

plot(x_k(1), x_k(2),'markersize',20,'Marker','.','Color','b');

for i = 1:max_iter

    % Gradient and hessian from approximated model
    [g,B] = model_grad_hes_func(x_k);

    % Dogleg algorithm to get step and direction
    p = DogLeg(g, B, trust_radius);

    % || p || from the dogleg algorithm
    norm_p = sqrt(p'*p);
    
    % Actual reduction / Predicted reduction
    rho = Rho(actual_func, g, B, x_k, p);
    

    if rho < 0.25
        % Actual reduction is too low
        % Contract the trust region
        trust_radius = 0.25*trust_radius;
    else
        if (rho > 0.75) && abs(norm_p - trust_radius) < 1e-5
            % Actual reduction is sufficient
            % Expand the trust region
            trust_radius = min(2*trust_radius, max_trust_radius);
        else
            trust_radius = trust_radius;
        end
    end

    
    if rho > eta
        x_k = x_k + p;
    else
        x_k = x_k;
    end

    norm_g = sqrt(g'*g);

    x_k_plot(i,1) = x_k(1);
    x_k_plot(i,2) = x_k(2);
    
    plot(x_k_plot(i,1), x_k_plot(i,2),'markersize',20,'Marker','.','Color','k');
    str = int2str(i);
    text(x_k_plot(i,1)+0.05, x_k_plot(i,2), str);

    if norm_g < tol
        break;
    end

end

toc