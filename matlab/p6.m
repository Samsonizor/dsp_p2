load('P2F18data.mat')

dir_conv = conv(hn, xn);
ov_save = overlap_save(hn, xn, 2^11);

plot(dir_conv)
hold on
plot(ov_save)