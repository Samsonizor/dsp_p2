delta = [1 zeros(1,99)];
n = 0:length(delta)-1;
y = zeros(1,length(delta));
s = zeros(1,length(delta));

y_iter = zeros(1,length(delta));
s_iter = zeros(1,length(delta));
c = [0 0 -.11];
k = [-.53 .91];

% c = [1 1 1];
% k = [1 1];
[y, s] = proj2sfg_iterate(c, k, [0; 0], delta);

[y_iter, s_iter] = proj2sfg_statespace_iterate(c, k, [0; 0], delta);
plot(n, y_iter)
hold on
plot(n, y)