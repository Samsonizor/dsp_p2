exponents = 10:16;
time_oa = zeros(1, length(exponents));
time_os = zeros(1, length(exponents));
time_conv = zeros(1, length(exponents));

for k = 1:length(exponents)
    clearvars -except k exponents time_conv time_oa time_os
    N = 2^exponents(k);
    hold on
    % real fft test
    load('P2F18data.mat')

    iterations = 10;
    dir_conv_time = 0;
    for i = 1:iterations
        tic
        dir_conv = conv(hn, xn);
        dir_conv_time = dir_conv_time + toc;
    end
    dir_conv_time = dir_conv_time/iterations;
    time_conv(k) = dir_conv_time;

    ov_save = overlap_save_real(hn, xn, 2^11);

    % overlap-save
    half_index = length(xn)/2;
    x1 = xn(1:half_index);
    x2 = xn(half_index+1:end);


    os_time = 0;
    for i = 1:iterations
        tic
        [y1, y2] = overlap_save(hn, x1, x2, N);
        os_time = os_time + toc;
    end
    os_time = os_time/iterations;
    time_os(k) = os_time;
    % overlap-add
    half_index = length(xn)/2;
    x1 = xn(1:half_index);
    x2 = xn(half_index+1:end);

    oa_time = 0;
    for i = 1:iterations
        tic
        [y1, y2] = overlap_add(hn, x1, x2, N);
        oa_time = oa_time + toc;
    end
    oa_time = oa_time/iterations;
    time_oa(k) = oa_time;
end
plot(exponents, time_oa, 'ro-')
plot(exponents, time_os, 'ko-')
plot(exponents, time_conv, 'bo-')
grid on
title('Filter time with different window sizes')
legend('overlap-add', 'overlap-save', 'direct convolution', 'Location', 'east')
ylabel('processing time (seconds)')
xlabel('window sample size')
xtickformat('2^{%2d}')