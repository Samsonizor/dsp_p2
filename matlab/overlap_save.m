function [ y ] = overlap_save( h, x, N )
    y = zeros(1, length(x));
    k = 0;
    h_transform = fft([h zeros(1, N-length(h))]);
    M = length(h);
    while((N-M)*k+N < length(x))
        x_transform = fft(x((N-M)*k+1:(N-M)*k+N));
        y_transform = h_transform.*x_transform;
        y_i = ifft(y_transform);
        y(M+k*(N-M)+1:(N-M)*k+N) = y_i(M+1:end);
        k = k+1;
    end
end

