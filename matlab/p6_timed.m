maxNumCompThreads(1);

exponents = 10:16;
time_oa = zeros(1, length(exponents));
time_os = zeros(1, length(exponents));
time_conv = zeros(1, length(exponents));

figure(2)
subplot(2,1,1)
for k = 1:length(exponents)
    clearvars -except k exponents time_conv time_oa time_os
    N = 2^exponents(k);
    hold on
    % real fft test
    load('P2F18data.mat')

    iterations = 10;
    dir_conv_times = zeros(1,iterations);
    for i = 1:iterations
        tic
        dir_conv = conv(hn, xn);
        dir_conv_time(i) = toc;
    end
    dir_conv_time = min(dir_conv_time)/iterations;
    time_conv(k) = dir_conv_time/length(dir_conv);

    ov_save = overlap_save_real(hn, xn, 2^11);

    % overlap-save
    half_index = length(xn)/2;
    x1 = xn(1:half_index);
    x2 = xn(half_index+1:end);


    os_time = zeros(1,iterations);
    for i = 1:iterations
        [y1, y2, time] = overlap_save(hn, x1, x2, N);
        os_time(i) = time;
    end
    os_time = min(os_time)/iterations;
    time_os(k) = os_time;
    % overlap-add
    half_index = length(xn)/2;
    x1 = xn(1:half_index);
    x2 = xn(half_index+1:end);

    oa_time = zeros(1,iterations);
    for i = 1:iterations
        [y1, y2, time] = overlap_add(hn, x1, x2, N);
        oa_time(i) = time;
    end
    oa_time = min(oa_time)/iterations;
    time_oa(k) = oa_time;
end
plot(exponents, time_oa*10^6, 'ro-')
plot(exponents, time_os*10^6, 'ko-')
plot(exponents, time_conv*10^6, 'bo-')
grid on
title('Filter Time with Different Window Sizes')
legend('overlap-add', 'overlap-save', 'direct convolution', 'Location', 'east')
ylabel('time per output sample \mus')
xlabel('window sample size')
xtickformat('2^{%2d}')


subplot(2,1,2)

hold on
plot(exponents, time_conv./time_oa, 'ro-')
plot(exponents, time_conv./time_os, 'ko-')
grid on
title('Filter Speedup of Overlap-Add and Overlap-Save Over Convolution')
legend('overlap-add speedup', 'overlap-save speedup')
ylabel('speedup factor')
xlabel('window sample size')
xtickformat('2^{%2d}')