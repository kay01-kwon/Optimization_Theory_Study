function p_k = cg_steihaug(g_k, B_k, tol, trust_radius)
%CG_STEIHAUG 이 함수의 요약 설명 위치
%
assert(tol > 0);

[n, ~] = size(g_k);

z_j = zeros(n,1);
r_j = g_k;
d_j = -r_j;

p_k = zeros(n,1);

norm_r0 = sqrt(r_j'*r_j);

if norm_r0 < tol
    p0 = zeros(n,1);
    p_k = p0;
    return;
end

while(1)

    if d_j'*B_k*d_j <= 0
        [tau_plus, tau_minus] = boundary_trust_region(z_j, d_j, trust_radius);
        
        p_j_plus = z_j + tau_plus*d_j;
        p_j_minus = z_j + tau_minus*d_j;

        m_plus = model(p_j_plus, g_k, B_k);
        m_minus = model(p_j_minus, g_k, B_k);

        if m_plus > m_minus
            p_k = p_j_minus;
            return;
        else
            p_k = p_j_plus;
            return;
        end
    end

    alpha_j = r_j'*r_j/(d_j'*B_k*d_j);
    z_j_next = z_j + alpha_j*d_j;

    if sqrt(z_j_next'*z_j_next) >= trust_radius
        [tau_plus, tau_minus] = boundary_trust_region(z_j, d_j, trust_radius);
        assert(tau_plus >= 0)
        p_k = z_j + tau_plus*d_j;
        return;
    end

    r_j_next = r_j + alpha_j*B_k*d_j;

    if sqrt(r_j_next'*r_j_next) < tol
        p_k = z_j_next;
        return;
    end

    beta_j = r_j_next'*r_j_next/(r_j'*r_j);
    d_j = -r_j_next + beta_j*d_j;

    z_j = z_j_next;
    r_j = r_j_next;


end

end

function m_p = model(p, g, B)
    m_p = g'*p + 1/2*p'*B*p;

end
