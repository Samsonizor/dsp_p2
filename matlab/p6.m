%% real fft test
figure(1)
load('P2F18data.mat')

dir_conv = conv(hn, xn);
ov_save = overlap_save_real(hn, xn, 2^11);

plot(dir_conv)
hold on
plot(ov_save+1)

%% complex fft test
N = 2^11;
half_index = length(xn)/2;
x1 = xn(1:half_index);
x2 = xn(half_index+1:end);
[y1, y2] = overlap_save(hn, x1, x2, N);

dir_conv_1 = conv(hn, x1);
dir_conv_2 = conv(hn, x2);

figure(2)

subplot(2,1,1)
plot(dir_conv_1)
title('direct convolution result (sig 1)')

subplot(2,1,2)
plot(y1)
title('overlap save result (sig 1)')


figure(3)

subplot(2,1,1)
plot(dir_conv_2)
title('direct convolution result (sig 2)')

subplot(2,1,2)
plot(y2)
title('overlap save result (sig 2)')