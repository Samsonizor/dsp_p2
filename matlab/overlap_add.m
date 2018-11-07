function [ y1, y2, tps_ms ] = overlap_add( h, x1, x2, N )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    M = length(h);
    y1 = zeros(1, length(x1)+N);
    y2 = zeros(1, length(x2)+N);
    h_transform = fft([h zeros(1, N-length(h))]);
    x_pointer = 1;
    y_pointer = 1;
    tps_ms = 0;
    block_count = 0;
    while(x_pointer+(N-M) <= length(x1))
        x1_block = [x1(x_pointer:x_pointer+(N-M)-1) zeros(1, M)];
        x2_block = [x2(x_pointer:x_pointer+(N-M)-1) zeros(1, M)];
        tic
        x_transform = fft(x1_block + 1j*x2_block);
        y_transform = h_transform.*x_transform;
        y_combined = ifft(y_transform);
        y1_i = real(y_combined);
        y2_i = imag(y_combined);
        tps_ms = tps_ms + toc/(N-M);
        y1(y_pointer:y_pointer+N-1) = y1(y_pointer:y_pointer+N-1) + y1_i;
        y2(y_pointer:y_pointer+N-1) = y2(y_pointer:y_pointer+N-1) + y2_i;
        x_pointer = x_pointer + (N-M);
        y_pointer = y_pointer + (N-M);
        block_count = block_count + 1;
    end
    tps_ms = tps_ms/block_count;
    if(x_pointer >= length(x1))
        return
    else
        x1_block = [x1(x_pointer:end) zeros(1, N-(length(x1)-x_pointer)-1)];
        x2_block = [x2(x_pointer:end) zeros(1, N-(length(x1)-x_pointer)-1)];
        [x1_transform, x2_transform] = complex_fft(x1_block, x2_block);
        y1_transform = h_transform.*x1_transform;
        y2_transform = h_transform.*x2_transform;
        y_combined = ifft(y1_transform + 1j*y2_transform);
        y1_i = real(y_combined);
        y2_i = imag(y_combined);
        y1(y_pointer:y_pointer+N-1) = y1(y_pointer:y_pointer+N-1) + y1_i;
        y2(y_pointer:y_pointer+N-1) = y2(y_pointer:y_pointer+N-1) + y2_i;
    end
end


