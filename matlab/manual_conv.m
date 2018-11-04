function [ y ] = manual_conv( x, h )
    M = length(h);
    N = length(x);
    y = zeros(1, M+N-1);
    for n = 1:M+N-1
        for m = -M:M
            if (n-m < 1 || m < 1)
                continue
            end
            y(n) = y(n) + x(n-m)*h(m);
        end
    end
end

