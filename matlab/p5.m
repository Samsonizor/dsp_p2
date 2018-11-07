%% varying window size

figure(1)
subplot(2,1,1)
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

subplot(2,1,2)

for k = 1:length(exponents)
    N = 2^exponents(k);
    mac_count_overlap(k) = (N+2*N*(log2(4*N)-1))/(N-M);
end
M_array = M*ones(1, length(exponents));
plot(exponents, M_array./mac_count_overlap)
grid on
ylabel('speedup factor')
xlabel('window sample size')
title('Theoretical Speedup Compared to Convolution')
xtickformat('2^{%2d}')


%% varying UPR length
figure(2)
hold on
exponents = 11:16;
mac_count_overlap = zeros(1, length(exponents));

datamap = zeros(100, length(exponents));
for k = 1:length(exponents)
    for frc = 1:100
        N = 2^exponents(k);
        M = N*frc/100;
%         M = frc;
        datamap(frc, k) = M/((N+2*N*(log2(4*N)-1))/(N-M));
    end
end
makemap(10*log10(datamap))