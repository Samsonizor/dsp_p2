function [ y, state_out ] = proj2sfg_iterate( c, k, state_init, x )
% single clock cycle of the project 3 sfg

% check the variables first
    if length(c) ~= 3
        state_out = 'bad length for variable c';
        y = 'bad length for variable c';
        return
    end
    if length(k) ~= 2
        state_out = 'bad length for variable k';
        y = 'bad length for variable k';
        return
    end
    if length(state_init) ~= 2
        state_out = 'bad length for variable state_in';
        y = 'bad length for variable state_in';
        return
    end
    
    state_container = state_init;
    state_out = zeros(2,length(x));
    y = zeros(1,length(x));
    for n = 1:length(x)
        [y(n), state_container] = proj2sfg_statespace(c, k, state_container, x(n));
        state_out(:,n) = state_container';
    end
end

