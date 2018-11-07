%% Time domain
ff = .33;
% ff = 0.598885610367865;
% ff = 0.001;
min_periods = 10;
max_periods = 50;
sample_min = floor(min_periods/ff);
sample_max = ceil(max_periods/ff);
n  = 0:sample_max;
phi = 0;
period_measurement = wrapToPi(2*pi*ff.*n+phi);
[~, index] = min(abs(period_measurement(sample_min+1:sample_max+1)));
index = index+sample_min-1;
val = period_measurement(index);
samples = cos(2*pi*ff.*n+phi);
display_periods = 500;
repititions = ceil(display_periods/(ff*index));
sigout = repmat(samples(1:index),1,repititions);
sigout = sigout(1:ceil(display_periods/ff));
xaxis = 0:length(sigout)-1;
pure_signal = cos(2*pi*ff.*xaxis);
figure(1)
plot(xaxis, sigout, xaxis, pure_signal)
title('Approximated Signal Compared to Actual Sinusoid at ff=.33')
legend('digital readout','actual')
xlabel('n')
ylabel('output')
figure(2)
plot(xaxis, sigout-pure_signal)
title('Error Values Between Digital Readout and True Sinusoid at f=.33')
xlabel('n')
ylabel('difference')
%% Frequency domain
% zero-pad the signal

% find a reasonably appropriate length for the signal that is input to the
% fft
window = hamming(length(sigout))';
windowed_sig = sigout.*window;  
windowed_pure = pure_signal.*window;
padded_length = 2^(ceil(log2(length(sigout)))+4);
windowed_sig = [windowed_sig zeros(1, padded_length-length(sigout))];
windowed_pure = [windowed_pure zeros(1, padded_length-length(pure_signal))];
tmp = fftshift(abs(fft(windowed_sig)));
sig_tr_mag = 20*log10(tmp/max(tmp));
sig_tr_mag = sig_tr_mag(length(sig_tr_mag)/2:end);
tmp = fftshift(abs(fft(windowed_pure)));
sig_tr_pure = 20*log10(tmp/max(tmp));
sig_tr_pure = sig_tr_pure(length(sig_tr_pure)/2:end);
xaxis = linspace(0,.5, length(sig_tr_pure));
[l,r] = locate_mainlobelims(sig_tr_mag);
interval = xaxis(2)-xaxis(1);

figure(3)
subplot(2,1,1)
plot(xaxis, sig_tr_mag)
hold on
plot(xaxis, sig_tr_pure)
plot(((l-1)*interval),sig_tr_mag(l),'rx',...
     ((r-1)*interval),sig_tr_mag(r),'rx');
legend('digital readout','original')
xlabel('fractional frequency')
ylabel('magnitude (dB)')
xlim([.3 .5])
ylim([-150 5])
title("Windowed Signal's Transform Compared to Windowed Sinusoid (Hamming), ff=.33")
grid on 
figure(4)
subplot(2,1,1)
hold on
grid on
tmp = fftshift(abs(fft(windowed_sig)-fft(windowed_pure)));
sig_tr_mag_sfdrcalc = 20*log10(tmp/max(abs(fft(windowed_sig))));
sig_tr_mag_sfdrcalc = sig_tr_mag_sfdrcalc(length(sig_tr_mag_sfdrcalc)/2:end);
plot(xaxis, sig_tr_mag_sfdrcalc)
title('Distortion Power (Hamming), ff=.33')
xlabel('fractional frequency')
ylabel('magnitude (dB)')

max_main_gen_hm = max(sig_tr_mag(l:r));
max_side_gen_hm = max([sig_tr_mag_sfdrcalc(1:l) sig_tr_mag_sfdrcalc(r:end)]);
SFDR_HAMMING    = max_main_gen_hm - max_side_gen_hm

TD_HAMMING      = 10*log10(find_power(sig_tr_mag_sfdrcalc)/find_power(windowed_pure))

window = blackman(length(sigout))';
windowed_sig = sigout.*window;  
windowed_pure = pure_signal.*window;
padded_length = 2^(ceil(log2(length(sigout)))+4);
windowed_sig = [windowed_sig zeros(1, padded_length-length(sigout))];
windowed_pure = [windowed_pure zeros(1, padded_length-length(pure_signal))];
tmp = fftshift(abs(fft(windowed_sig)));
sig_tr_mag = 20*log10(tmp/max(tmp));
sig_tr_mag = sig_tr_mag(length(sig_tr_mag)/2:end);
tmp = fftshift(abs(fft(windowed_pure)));
sig_tr_pure = 20*log10(tmp/max(tmp));
sig_tr_pure = sig_tr_pure(length(sig_tr_pure)/2:end);
[l,r] = locate_mainlobelims(sig_tr_mag);

figure(3)
subplot(2,1,2)

plot(xaxis, sig_tr_mag)
hold on
plot(xaxis, sig_tr_pure)
plot(((l-1)*interval),sig_tr_mag(l),'rx',...
     ((r-1)*interval),sig_tr_mag(r),'rx');
legend('digital readout','original')
xlabel('fractional frequency')
ylabel('magnitude (dB)')
xlim([.3 .5])
ylim([-150 5])
title("Windowed Signal's Transform Compared to Windowed Sinusoid (Blackman), ff=.33")
grid on 

figure(4)
subplot(2,1,2)
hold on
grid on
tmp = fftshift(abs(fft(windowed_sig)-fft(windowed_pure)));
sig_tr_mag_sfdrcalc = 20*log10(tmp/max(abs(fft(windowed_sig))));
sig_tr_mag_sfdrcalc = sig_tr_mag_sfdrcalc(length(sig_tr_mag_sfdrcalc)/2:end);
plot(xaxis, sig_tr_mag_sfdrcalc)
title('Distortion Power (Blackman), ff=.33')
xlabel('fractional frequency')
ylabel('magnitude (dB)')

max_main_gen_bl = max(sig_tr_mag(l:r));
max_side_gen_bl = max([sig_tr_mag_sfdrcalc(1:l) sig_tr_mag_sfdrcalc(r:end)]);
SFDR_BLACKMAN   = max_main_gen_bl - max_side_gen_bl

TD_BLACKMAN     = 10*log10(find_power(sig_tr_mag_sfdrcalc)/find_power(windowed_pure))