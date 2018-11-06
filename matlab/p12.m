delta = [1 zeros(1,99)];
n = 0:length(delta)-1;
y = zeros(1,length(delta));
s = zeros(1,length(delta));

y_iter = zeros(1,length(delta));
s_iter = zeros(1,length(delta));
c = [0 0 -.11];
k = [-.53 .91];

c0 = c(1);
c1 = c(2);
c2 = c(3);
k1 = k(1);
k2 = k(2);

a = [1 k1 + k1*k2 k2];
b = [c2 + c0*k2 + c1*k1 + c2*k1 + c2*k2 + c1*k1*k2 + c2*k1*k2, c1 + c0*k1 + c1*k2 + c0*k1*k2, c0];

% c = [1 1 1];
% k = [1 1];
[y, s] = proj2sfg_iterate(c, k, [0; 0], delta);

[y_iter] = fun_iterate(b, a, delta, [0 0 0 0]);
plot(n, y_iter)
hold on
plot(n, y)