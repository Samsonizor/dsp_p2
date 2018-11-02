delta = [1 zeros(1,99)];
n = 0:length(delta)-1;
y = zeros(1,length(delta));
s = zeros(1,length(delta));
c = [-.11 0 0];
k = [-. 53 .91];
[y, s] = proj2sfg_iterate(c, k, [0 0], delta);
plot(n, y)

