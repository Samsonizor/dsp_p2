function [ y1, y2 ] = complex_fft( x1, x2 )
    fft_out = fft(x1 + 1j*x2);
    rev_conj = fliplr(conj(fft_out));
    y1 = (fft_out+rev_conj)/2;
    y2 = (fft_out-rev_conj)/(2*1j);
end

