function [ y ] = overlap_save_real( h, x, N )
    M = length(h);
    y = zeros(1, length(x));
    k = 0;
    h_transform = fft([h zeros(1, N-length(h))]);
    x_pointer = 1;
    y_pointer = M+1;
    while(x_pointer+N-1 <= length(x))
        x_transform = fft(x(x_pointer:x_pointer+N-1));
        y_transform = h_transform.*x_transform;
        y_i = ifft(y_transform);
        y(y_pointer:y_pointer+(N-M)-1) = y_i(M+1:end);
        k = k+1;
        x_pointer = x_pointer + (N-M);
        y_pointer = y_pointer + (N-M);
    end
    if(x_pointer >= length(x))
        return
    else
        x_transform = fft([x(x_pointer:end) zeros(1, N-(length(x)-x_pointer)-1)]);
        y_transform = h_transform.*x_transform;
        y_i = ifft(y_transform);
        y(y_pointer:y_pointer+(N-M)-1) = y_i(M+1:end);
    end
end

