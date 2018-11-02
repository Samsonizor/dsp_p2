function [ sfdr ] = find_sfdr( target, actual, win_type )
    if ~exist('win_type','var')
    	sfdr = 'bad wintype';
        return
    end
    
    window = zeros(1,length(actual));
    if strcmp(win_type, 'hamming')
        window = hamming(length(actual))';
    elseif strcmp(win_type, 'blackman')
        window = blackman(length(actual))';
    else
        sfdr = 'bad wintype';
        return
    end
    windowed_sig = actual.*window;  
    windowed_pure = target.*window;
    padded_length = 2^(ceil(log2(length(target)))+4);
    windowed_sig = [windowed_sig zeros(1, padded_length-length(target))];
    windowed_pure = [windowed_pure zeros(1, padded_length-length(target))];
    sig_tr_mag = 20*log10(fftshift(abs(fft(windowed_sig))));
    sig_tr_mag = sig_tr_mag(length(sig_tr_mag)/2:end);
    sig_tr_pure = 20*log10(fftshift(abs(fft(windowed_pure))));
    sig_tr_pure = sig_tr_pure(length(sig_tr_pure)/2:end);
    [l,r] = locate_mainlobelims(sig_tr_mag);
    sig_tr_mag_sfdrcalc = 20*log10(fftshift(abs(fft(windowed_sig)-fft(windowed_pure))));
    sig_tr_mag_sfdrcalc = sig_tr_mag_sfdrcalc(length(sig_tr_mag_sfdrcalc)/2:end);
    max_main_gen_hm = max(sig_tr_mag(l:r));
    max_side_gen_hm = max([sig_tr_mag_sfdrcalc(1:l) sig_tr_mag_sfdrcalc(r:end)]);
    sfdr = max_main_gen_hm - max_side_gen_hm;
end

