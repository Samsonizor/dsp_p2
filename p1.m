ff = .33;
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
display_periods = 50;
repititions = ceil(display_periods/(ff*index));
sigout = repmat(samples(1:index),1,repititions);
sigout = sigout(1:ceil(display_periods/ff));
xaxis = 0:length(sigout)-1;
figure(1)
plot(xaxis, sigout, xaxis, cos(2*pi*ff.*xaxis))
figure(2)
plot(xaxis, sigout-cos(2*pi*ff.*xaxis))