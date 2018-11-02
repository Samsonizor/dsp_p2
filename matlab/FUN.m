function [yn, state_next] = FUN(b,a,state_now,xn,bits)
    M = length(b);
    N = length(a);
    %   normalize a and b arrays
    a = a/a(1);
    b = b/a(1);
    b_multiply_input = cat(2, xn, state_now(1:M-1));
    b_multiply_result = b.*b_multiply_input;
    b_add_result = zeros(1,M);
    for n = 1:M
            b_add_result(n) = sum(b_multiply_result(n:M));
    end
    a_multiply_result = cat(2, 0, state_now(M:end)).*cat(2, 0, -a(2:N));
    a_add_subresult = zeros(1,N-1);
    for n = 1:N
        a_add_subresult(n) = sum(a_multiply_result(n:N));
    end
    a_add_result = cat(2, b_add_result(1) + a_add_subresult(1), a_add_subresult);
    a_multiply_result(1) = (b_add_result(1) + a_add_result(2)) * a(1);
    yn = a_multiply_result(1);
    if ~exist('bits','var')
        state_next = cat(2, xn, state_now(1:M-2), yn, state_now(M:M+N-3));
    else
        state_next = cat(2, quantize(xn,bits), state_now(1:M-2), quantize(yn,bits), state_now(M:M+N-3));
    end
end