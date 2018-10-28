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
    
    
end

