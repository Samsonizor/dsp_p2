% create a and b vals for filter 1

c = [-.11 0 0];
k = [-.53 .91];

c0 = c(1);
c1 = c(2);
c2 = c(3);
k1 = k(1);
k2 = k(2);

a = [1 k1 + k1*k2 k2];
b = [c2 + c0*k2 + c1*k1 + c2*k1 + c2*k2 + c1*k1*k2 + c2*k1*k2, c1 + c0*k1 + c1*k2 + c0*k1*k2, c0];



% run FUN for quantized system
sample_amount = 1024;
n = 0:sample_amount-1;
freq = .33;
sin_in = sin(2*pi*freq*n);
B = 12;

y_quant = fun_iterate(b, a, sin_in, [0 0 0 0], B);
y       = fun_iterate(b, a, sin_in, [0 0 0 0]);

% get the steady state
y_quant = y_quant(sample_amount/2:end);
y = y(sample_amount/2:end);

window = blackman(length(y))';
y = window.*y;
y_quant = window.*y_quant;

padded_length = 2^(ceil(log2(length(y_quant)))+4);
y_quant = [y_quant zeros(1, padded_length-length(y_quant))];
y = [y zeros(1, padded_length-length(y))];

%% plot overall frequency
figure(1)
y_fq_quant = fft(y_quant);
y_fq_quant = y_fq_quant(1:length(y_fq_quant)/2);

y_fq = fft(y);
y_fq = y_fq(1:length(y_fq)/2);
n = linspace(0,.5,length(y_fq_quant));

subplot(2,1,1)
hold on
grid on
title('Filter Output Magnitude')
plot(n, 20*log10(abs(y_fq_quant)/max(abs(y_fq_quant))))
plot(n, 20*log10(abs(y_fq)/max(abs(y_fq))))
ylabel('Power in dB')
xlabel('fractional frequency')
legend('quantized filter output', 'linear filter output')

subplot(2,1,2)
hold on
grid on
title('Filter Output Phase')
plot(n, angle(y_fq_quant))
plot(n, angle(y_fq))
ylabel('Phase in Radians')
xlabel('fractional frequency')

%% plot focused frequency
figure(2)

subplot(2,1,1)
hold on
grid on
title('Filter Output Magnitude')
plot(n, 20*log10(abs(y_fq_quant)/max(abs(y_fq_quant))))
plot(n, 20*log10(abs(y_fq)/max(abs(y_fq))))
ylabel('Power in dB')
xlabel('fractional frequency')
legend('quantized filter output', 'linear filter output')
xlim([.3 .35])

subplot(2,1,2)
hold on
grid on
title('Filter Output Phase')
plot(n, angle(y_fq_quant))
plot(n, angle(y_fq))
ylabel('Phase in Radians')
xlabel('fractional frequency')
xlim([.3 .35])
