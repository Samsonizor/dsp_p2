syms k1 k2 c0 c1 c2 z
z_inv = 1/z;

a_1 = k1-1;
a_2 = k1*k2;

denom = 1/(1+a_1*z_inv+a_2*z_inv^2);

ct_1 = -c2*k1+c1*(1-k1);
ct_2 = c2*(-k1*k2-k2)-c1*k1*k2+c0*(1-k2);

A = [-k1 -k1*k2-k2; 1-k1 -k1*k2];
ct = [ct_1 ct_2];
d = c2*(1+k2+k1+k1*k2) + ...
    c1*(k1+k1*k2) + ...
    c0*(k2);
b = [1+k2+k1+k1*k2; k1+k1*k2];
I = [1 0; 0 1];

H = d+ct*inv(z*I-A)*b;

H = collect(H, 'z')

