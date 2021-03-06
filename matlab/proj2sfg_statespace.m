function [ yn, state_out ] = proj2sfg_statespace( c, k, state_in, xn )
    % single clock cycle of the project 3 sfg

% check the variables first
    if length(c) ~= 3
        state_out = 'bad length for variable c';
        yn = 'bad length for variable c';
        return
    end
    if length(k) ~= 2
        state_out = 'bad length for variable k';
        yn = 'bad length for variable k';
        return
    end
    if length(state_in) ~= 2
        state_out = 'bad length for variable state_in';
        yn = 'bad length for variable state_in';
        return
    end
    if length(xn) ~= 1
        state_out = 'bad length for variable xn';
        yn = 'bad length for variable xn';
        return
    end
    
    c0 = c(1);
    c1 = c(2);
    c2 = c(3);
    k1 = k(1);
    k2 = k(2);
    s1 = state_in(1);
    s2 = state_in(2);
    
    ct_1 = -c2*k1+c1*(1-k1);
    ct_2 = c2*(-k1*k2-k2)-c1*k1*k2+c0*(1-k2);
    
    A = [-k1 -k1*k2-k2; 1-k1 -k1*k2];
    ct = [ct_1 ct_2];
    d = c2*(1+k2+k1+k1*k2) + ...
        c1*(k1+k1*k2) + ...
        c0*(k2);
    b = [1+k2+k1+k1*k2; k1+k1*k2];
    
    state_out = A*state_in+b*xn;
    yn = ct*state_in+d*xn;
end

