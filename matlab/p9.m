% syms k1 k2 c0 c1 c2 
syms a1 a2 b0 b1 b2


k2 = a2
k1 = a1/(1+k2)

c0 = b2
c1 = (b1-c0*k1-c0*k1*k2)/(1+k2);
[c1n c1d] = numden(c1);
c1 = c1n/c1d
c2 = (b0-c0*k2-c1*k1-c1*k1*k2-c1*k1*k2)/(1+k1+k2+k1*k2);
[c2n c2d] = numden(c2);
c2 = c2n/c2d
