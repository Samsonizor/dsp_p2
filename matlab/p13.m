%% filter 1

c = [-.11 0 0];
k = [-.53 .91];

c0 = c(1);
c1 = c(2);
c2 = c(3);
k1 = k(1);
k2 = k(2);

a = [1 k1 + k1*k2 k2];
b = [c2 + c0*k2 + c1*k1 + c2*k1 + c2*k2 + c1*k1*k2 + c2*k1*k2, c1 + c0*k1 + c1*k2 + c0*k1*k2, c0];

% plot holes and zeros
figure(1)
hold on
grid on
plot(roots(a), 'bx')
plot(roots(b), 'bo')
viscircles([0 0],1);
xlim([-1.2 1.2])
ylim([-1.2 1.2])
pbaspect([1 1 1])
legend('poles', 'zeroes')
title('Pole-Zero Plot for c=[-0.11 0 0]')

figure(2)
freqz(b,a,2^18)
title('Frequency Response for c=[-0.11 0 0]')
ylim([-20 0])

%% filter 2
c = [0 0 -.11];
k = [-.53 .91];

c0 = c(1);
c1 = c(2);
c2 = c(3);
k1 = k(1);
k2 = k(2);

a = [1 k1 + k1*k2 k2];
b = [c2 + c0*k2 + c1*k1 + c2*k1 + c2*k2 + c1*k1*k2 + c2*k1*k2, c1 + c0*k1 + c1*k2 + c0*k1*k2, c0];

figure(3)
% plot holes and zeros
hold on
grid on
plot(roots(a), 'bx')
plot(roots(b), 'bo')
viscircles([0 0],1);
xlim([-1.2 1.2])
ylim([-1.2 1.2])
pbaspect([1 1 1])
legend('poles', 'zeroes')
title('Pole-Zero Plot for c=[0 0 -0.11]')

figure(4)
freqz(b,a,2^18)
title('Frequency Response for c=[0 0 -0.11]')
