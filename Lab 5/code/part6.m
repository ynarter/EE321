
D = 22102718;
D7 = rem(D, 7);
Ts = 0.005 * (D7 + 1);
Ts = 0.25+ 0.01 * D7;
Ts = 0.18 + 0.005 * (D7 + 1);
Ts =0.099;

t = linspace(-2, 2, 1000);
tx = -2:Ts:2;
n = tx/Ts;

x = 0.25 * cos(2*pi*3*t + pi/8) + 0.4 * cos(2*pi*5*t - 1.2) + 0.9 * cos(2*pi*t + pi/4);
Xn = 0.25 * cos(2*pi*3*n*Ts + pi/8) + 0.4 * cos(2*pi*5*n*Ts - 1.2) + 0.9 * cos(2*pi*n*Ts + pi/4);
figure;
plot(t, x, 'r', 'LineWidth', 1.5);
hold on;
stem(n*Ts, Xn, 'b', 'filled');
title('Continuous Signal x(t) and Sampled Signal x(nTs)');
xlabel('t');
ylabel('x(t), x(nTs)');
legend('Continuous Signal x(t)', 'Sampled Signal x(nTs)');
xR0 = DtoA(0, Ts, 4, Xn);
xR1 = DtoA(1, Ts, 4, Xn);
xR2 = DtoA(2, Ts, 4, Xn);

tR = linspace(-2, 2, numel(xR0));

figure;
subplot(3, 1, 1);
plot(tR, xR0, 'LineWidth', 1.5);
title('Zero-Order Interpolation');
xlabel('t');
ylabel('xR(t)');
subplot(3, 1, 2);
plot(tR, xR1, 'LineWidth', 1.5);
title('Linear Interpolation');
xlabel('t');
ylabel('xR(t)');
subplot(3, 1, 3);
plot(tR, xR2, 'LineWidth', 1.5);
title('Ideal Band-Limited Interpolation');
xlabel('t');
ylabel('xR(t)');

function xR=DtoA(type,Ts,dur,Xn)
    t = -dur/2 : Ts/500 : dur/2-Ts/500;
    p = generateInterp(type,Ts,dur);
    len = length(Xn)*500+length(p);
    xR = zeros(1, len);
    
    for n = 0:length(Xn)-1
        xR(500*n+1:500*n+length(p)) =  xR(500*n+1:500*n+length(p)) + Xn(n+1)*p;
    end
    
    xR = xR(250*length(Xn)+1: end-250*length(Xn));
end

function p = generateInterp(type, Ts, dur)
    t = -dur/2 : Ts/500 : dur/2-Ts/500; % Discrete time axis
    switch type
    case 0 % Zero-order interpolation
        p = zeros(size(t));
        p(abs(t) <= Ts/2) = 1;
    case 1 % Linear interpolation
        p = zeros(size(t));
        p = max(1 - abs(t)/Ts, 0);
    case 2 % Ideal interpolation
        p = sinc(t/Ts);
        p(t==0) = 1;
    end
end
