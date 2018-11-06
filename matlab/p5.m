%% varying window size

M = 255;
hold on
exponents = 10:16;
mac_count_overlap = zeros(1, length(exponents));

for k = 1:length(exponents)
    N = 2^exponents(k);
    mac_count_overlap(k) = (N+2*N*(log2(4*N)-1))/(N-M);
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

%% varying UPR length
hold on
exponents = 11:16;
mac_count_overlap = zeros(1, length(exponents));

datamap = zeros(100, length(exponents));
for k = 1:length(exponents)
    for frc = 1:100
        N = 2^exponents(k);
        M = N*frc/100;
        datamap(frc, k) = (N+2*N*(log2(4*N)-1))/(N-M);
    end
end
datamap_log = 10*log10(datamap./max(datamap));
M_array = M*ones(1, length(exponents));d
imagesc(datamap)
colorbar
ylabel('UPR Length as a percentage of N')
xlabel('window sample size')
title('Performance of Overlap Methods Compared to Direct Convolution')
xtickformat('2^{%2d}')