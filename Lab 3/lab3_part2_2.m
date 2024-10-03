sample_rate = 8192;
[x, fs] = audioread("part2record.wav");
x = x(1:sample_rate*12)'; %crop the recording
len_x = length(x);

%soundsc(x);


t=0:1/8192:12-1/8192;

Ai = [0.65 0.50 0.30 0.22 0.15 0.1];
ti = [0.25 0.75 1 1.25 2 3.25];

x_1 = [zeros(1, sample_rate*ti(1)) Ai(1)*x(1: len_x - sample_rate*ti(1))];
x_2 = [zeros(1, sample_rate*ti(2)) Ai(2)*x(1: len_x - sample_rate*ti(2))];
x_3 = [zeros(1, sample_rate*ti(3)) Ai(3)*x(1: len_x - sample_rate*ti(3))];
x_4 = [zeros(1, sample_rate*ti(4)) Ai(4)*x(1: len_x - sample_rate*ti(4))];
x_5 = [zeros(1, sample_rate*ti(5)) Ai(5)*x(1: len_x - sample_rate*ti(5))];
x_6 = [zeros(1, sample_rate*ti(6)) Ai(6)*x(1: len_x - sample_rate*ti(6))];

x_1 = x_1(1:sample_rate*12); %crop the delayed signals
x_2 = x_2(1:sample_rate*12);
x_3 = x_3(1:sample_rate*12);
x_4 = x_4(1:sample_rate*12);
x_5 = x_5(1:sample_rate*12);
x_6 = x_6(1:sample_rate*12);

y = x + x_1 + x_2 + x_3 + x_4 + x_5 + x_6;

figure
plot(t, x);
xlabel('Time (t)');
ylabel('x(t)');
title('x(t) vs. t');
grid("on");

figure
plot(t, y, 'r');
xlabel('Time (t)');
ylabel('y(t)');
title('y(t) vs. t');
grid("on");


Y=FT(y);

omega=linspace(-8192*pi,8192*pi,98305); 
omega=omega(1:98304);

H = ones(1, length(omega));
for i=1:6
    H = H+Ai(i)*exp(-1j * omega * ti(i));
end
h = IFT(H);

X_e = Y./H;
x_e = IFT(X_e);

soundsc(x_e);

figure
plot(t, h);
xlabel('Time (t)');
ylabel('h(t)');
title('h(t) vs. t');
grid("on");

figure
plot(omega, abs(H), 'r');
xlabel('Omega (ω)');
ylabel('Magnitude of H(ω)');
title('|H(ω)| vs. ω');
grid("on");

figure
plot(t, x_e, 'm');
xlabel('Time (t)');
ylabel('x_e(t)');
title('x_e(t) vs. t');
grid("on");

audiowrite('part2record_echo.wav', y, 8192);
audiowrite('part2record_estimated.wav',x_e, 8192);


%H = 1+ Ai(1)*exp(-1j * omega * ti(1))+ Ai(2)*exp(-1j * omega * ti(2))+ Ai(3)*exp(-1j * omega * ti(3))+ Ai(4)*exp(-1j * omega * ti(4))+ Ai(5)*exp(-1j * omega * ti(5))+ Ai(6)*exp(-1j * omega * ti(6));
%H = 1+ 0.65*exp(-1j * omega * 0.25)+ 0.5*exp(-1j * omega * 0.75)+ 0.3*exp(-1j * omega * 1)+ 0.22*exp(-1j * omega * 1.25)+ 0.15*exp(-1j * omega * 2)+ 0.1*exp(-1j * omega * 3.25);



