function [ pwr ] = find_power( spectrum )
% Find the power of a signal represented by spectrum
% Assumes that spectrum represents the power of the signal for fractional
% frequencies ranging from 0 to .5
% returns the power in dB
    tot = 0;
    for val = spectrum
        tot = tot + 10^(val/10);
    end
	% multiply tot by 2 to account for the negative frequency range
    pwr = 2*tot/length(spectrum);
end
