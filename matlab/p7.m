focus = 65280;
delta = 255;
lookahead = 5;

yn = conv(xn, hn);
subplot(2,1,1)
plot(xn)
hold on
x_h = focus-254:focus;
ylim([-10 10])
yyaxis right
plot(x_h, fliplr(hn))
ylim([-2 2])
grid on
xlim([focus-delta focus+lookahead])
title('Convolution Input and Flipped Impulse Response')
legend('Convolution Input','Flipped Impulse Response')

subplot(2,1,2)
plot(yn)
grid on
xlim([focus-delta focus+lookahead])
title('Convolution Output')

