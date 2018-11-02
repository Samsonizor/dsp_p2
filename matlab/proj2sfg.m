function [ yn, state_out ] = proj2sfg( c, k, state_in, xn )
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
    
    leftbox_output_right = xn+k2*xn-k2*s2;
    rightbox_output_right = leftbox_output_right*(1+k1)-k1*s1;
    component3 = c2*rightbox_output_right;
    component2 = c1*(k1*leftbox_output_right+s1*(1-k1));
    component1 = c0*(s2*(1-k2)+xn*k2);
    yn = component1 + component2 + component3;
    state_out(1) = component2;
    state_out(2) = rightbox_output_right;
end

