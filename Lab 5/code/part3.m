


dur = mod(22102718, 7);
Ts = dur/5;

pZ = generateInterp(0, Ts, dur);
pL = generateInterp(1, Ts, dur);
pI = generateInterp(2, Ts, dur);
t = -dur/2:Ts/500:dur/2;

subplot(3, 1, 1)
plot(t, pZ)
title('Zero-Order Interpolation')
xlabel('t')
ylabel('pZ(t)')

subplot(3, 1, 2)
plot(t, pL)
title('Linear Interpolation')
xlabel('t')
ylabel('pL(t)')

subplot(3, 1, 3)
plot(t, pI)
title('Ideal Interpolation')
xlabel('t')
ylabel('pI(t)')


function p = generateInterp(type, Ts, dur)
    t = -dur/2:Ts/500:dur/2;
    p = zeros(size(t));
    if type == 0 %zero-order interpolation
         p(abs(t) <= Ts/2) = 1;
    elseif type == 1 % linear interpolation
         p = max(1 - abs(t)/(Ts * 0.5), 0);
    elseif type == 2 %ideal interpolation
         p = sinc(t/Ts);
         p(t==0) = 1;
    end
end









