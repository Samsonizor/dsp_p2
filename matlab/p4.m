random_frequencies = [rand(1,100)/2 .33];
figure(1)
hold on
grid on
wintype = 'blackman';
miny = 1000;
minx = -1;
%% plotting sfdr
for ff = random_frequencies
    min_periods = .5;
    LUT_size    = 1024;
    sample_min  = floor(min_periods/ff);
    sample_max  = LUT_size;
    n           = 0:sample_max;
    phi         = 0;
    period_measurement  = wrapToPi(2*pi*ff.*n+phi);
    [~, index]          = min(abs(period_measurement(sample_min+1:sample_max+1)));
    index               = index+sample_min-1;
%     val                 = period_measurement(index);
    samples             = cos(2*pi*ff.*n+phi);
    display_periods     = 500;
    repititions         = ceil(display_periods/(ff*index));
    sigout              = repmat(samples(1:index),1,repititions);
    sigout              = sigout(1:ceil(display_periods/ff));
    xaxis               = 0:length(sigout)-1;
    pure_signal         = cos(2*pi*ff.*xaxis);
    color = 'bo';
    if ff == .33
        color = 'bx';
    end
    y = find_sfdr(pure_signal, sigout, wintype);
    if y < miny
        miny = y;
        minx = ff;
    end
    plot(ff, y, color)
end
yyaxis left
xlabel('ff')
ylabel('SFDR in dB')
ax = gca;
ax.YColor = 'blue';

yyaxis right
for ff = random_frequencies
    min_periods = 10;
    max_periods = 50;
    sample_min  = floor(min_periods/ff);
    sample_max  = ceil(max_periods/ff);
    n           = 0:sample_max;
    phi         = 0;
    period_measurement  = wrapToPi(2*pi*ff.*n+phi);
    [~, index]          = min(abs(period_measurement(sample_min+1:sample_max+1)));
    index               = index+sample_min-1;
%     val                 = period_measurement(index);
    samples             = cos(2*pi*ff.*n+phi);
    display_periods     = 500;
    repititions         = ceil(display_periods/(ff*index));
    sigout              = repmat(samples(1:index),1,repititions);
    sigout              = sigout(1:ceil(display_periods/ff));
    xaxis               = 0:length(sigout)-1;
    pure_signal         = cos(2*pi*ff.*xaxis);
    window              = blackman(length(sigout))';

    windowed_sig = sigout.*window;  
    windowed_pure = pure_signal.*window;
    padded_length = 2^(ceil(log2(length(pure_signal)))+4);
    windowed_sig = [windowed_sig zeros(1, padded_length-length(pure_signal))];
    windowed_pure = [windowed_pure zeros(1, padded_length-length(pure_signal))];
    sig_tr_mag = 20*log10(fftshift(abs(fft(windowed_sig))));
    tmp = fftshift(abs(fft(windowed_sig)-fft(windowed_pure)));
    sig_tr_mag_sfdrcalc = 20*log10(tmp/max(abs(fft(windowed_sig))));
    sig_tr_mag_sfdrcalc = sig_tr_mag_sfdrcalc(length(sig_tr_mag_sfdrcalc)/2:end);
    
    color = 'ro';
    if ff == .33
        color = 'rx';
    end
    y = 10*log10(find_power(sig_tr_mag_sfdrcalc)/find_power(windowed_pure));
%     if y < miny
%         miny = y;
%         minx = ff;
%     end
    plot(ff, y, color)
end

h = zeros(4, 1);
h(1) = plot(NaN,NaN,'bo');
h(2) = plot(NaN,NaN,'bx');
h(3) = plot(NaN,NaN,'ro');
h(4) = plot(NaN,NaN,'rx');
title('SFDR and TD Values at Random Frequencies')
ax = gca;
ax.YColor = 'red';
legend(h, 'SFDR of random values','SFDR for ff=.33', 'TD of random values','TD for ff=.33', 'location', 'east')
ylabel('TD in dB')
format long
minx
miny
format