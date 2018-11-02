function [ y_array ] = fun_iterate( b,a,x_array,state_init,bits )
% applies filter to x_array with initial state 0
    M = length(b);
    N = length(a);
    if ~exist('state_init','var')
        state_FUN = zeros(1,M+N-2);
    else
        state_FUN = state_init;
    end
    y_array = zeros(1, length(x_array));
    for i = 1:length(x_array)
        if ~exist('bits','var')
            [y_array(i),state_FUN] = FUN(b,a,state_FUN,x_array(i));
        else
            [y_array(i),state_FUN] = FUN(b,a,state_FUN,x_array(i),bits);
        end
    end
end

