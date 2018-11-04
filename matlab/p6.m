%% real fft test
load('P2F18data.mat')

tic
dir_conv = conv(hn, xn);
dir_conv_time = toc

ov_save = overlap_save_real(hn, xn, 2^11);
figure(1)


plot(dir_conv)


hold on
plot(ov_save+1)

%% overlap-save
N = 2^11;
half_index = length(xn)/2;
x1 = xn(1:half_index);
x2 = xn(half_index+1:end);

tic
[y1, y2] = overlap_save(hn, x1, x2, N);
os_time = toc

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

%% overlap-add

N = 2^11;
half_index = length(xn)/2;
x1 = xn(1:half_index);
x2 = xn(half_index+1:end);

tic
[y1, y2] = overlap_add(hn, x1, x2, N);
oa_time = toc

dir_conv_1 = conv(hn, x1);
dir_conv_2 = conv(hn, x2);

figure(2)

subplot(2,1,1)
plot(dir_conv_1)
title('direct convolution result (sig 1)')

subplot(2,1,2)
plot(y1)
title('overlap add result (sig 1)')


figure(3)

subplot(2,1,1)
plot(dir_conv_2)
title('direct convolution result (sig 2)')

subplot(2,1,2)
plot(y2)
title('overlap add result (sig 2)')

%% measuing the time associated with one MAC

% a = 0;
% iterations = 1000000;
% rand1 = randi(100,1,iterations);
% rand2 = randi(100,1,iterations);
% tic
% for b = 0:iterations-1
%     a = a + randi(iterations+1);
% end
% toc



