clear all
syms b0 b1 b2
a1 = 1;
a2 = 0;
ans = (b0 - a1*b1 + 2*a2*b0 - a2*b2 + a2^2*b0 + a1^2*b2 - 2*a2^2*b2 - a2^3*b2 - 2*a1*a2*b1 + 2*a1^2*a2*b2)/((a2 + 1)^2*(a1 + a2 + 1))
