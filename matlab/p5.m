M = 255;
hold on
exponents = 10:16;
mac_count_overlap = zeros(1, length(exponents));

for k = 1:length(exponents)
    N = 2^exponents(k);
    mac_count_overlap(k) = (3*N+2*N*(log2(4*N)-1))/(N-M);
end
M_array = M*ones(1, length(exponents));
plot(exponents, mac_count_overlap, 'ko-')
plot(exponents, M_array, 'bo-')
grid on
legend('overlap method', 'direct convolution')
ylabel('MAC count per output sample')
xlabel('window sample size')
title('Performance of Overlap Methods Compared to Direct Convolution')
xtickformat('2^{%2d}')