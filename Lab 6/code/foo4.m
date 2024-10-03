n1 = 2+2;
n2 = 2+2;
n3 = 2+1;
n4 = 2+0;
n5 = 2+2;
n6 = 2+7;
n7 = 2+1;
n8 = 2+8;

z1 = (n2 + 1i*n3)/sqrt(n2^2 + n3^2);
p1 = (n1 + 1i*n5)/sqrt(1+ n1^2 + n5^2);
p2 = (n8 + 1i*n6)/sqrt(1+ n8^2 + n6^2);

omega = -pi:0.001:pi;
freq_response = zeros(1, length(omega));


for m = 1:length(omega)
    a1= 1-z1*exp(-1i*omega(m));
    a2 = (1-p1*exp(-1i*omega(m))) * (1-p2*exp(-1i*omega(m)));
    freq_response(m) = a1/a2 ;
end

figure;
plot(omega, abs(freq_response));
title('Magnitude response of the filter');
xlabel('Omega (Ω)');
ylabel('|H(e^j^Ω)|');
grid on;


fs = 1400;
t1 = 0:(1/fs):1;
t2 = 0:(1/fs):10;
t3 = 0:(1/fs):100;

f0 = -700;
f_final = 700;

k1 = (f_final - f0) / 1; %at k=1/10/100, f = f_ins, at k=0, f = f_0
k2 = (f_final - f0) / 10;
k3 = (f_final - f0) / 100;

x1 = exp(1j * pi * (k1 * (t1.^2)));
x2 = exp(1j * pi * (k2 * (t2.^2)));
x3 = exp(1j * pi * (k3 * (t3.^2)));

a = [(p1+p2), -p1*p2];
b = [0, -z1];

y1 = DTLTI(a, b, x1, length(x1));
y2 = DTLTI(a, b, x2, length(x2));
y3 = DTLTI(a, b, x3, length(x3));

N1 = length(y1);
N2 = length(y2);
N3 = length(y3);
f_axis1 = linspace(-pi, pi, N1);
f_axis2 = linspace(-pi, pi, N2);
f_axis3 = linspace(-pi, pi, N3);

figure;
subplot(2,3,1);
plot(f_axis1, abs(y1));
title('Linear chirp magnitude response for 0 ≤ t ≤ 1');
xlabel('Frequency (rad/sample)');
ylabel('Magnitude');
xlim([-pi, pi]);
grid on;

subplot(2,3,2);
plot(f_axis2, abs(y2));
title('Linear chirp magnitude response for 0 ≤ t ≤ 10');
xlabel('Frequency (rad/sample)');
ylabel('Magnitude');
xlim([-pi, pi]);
grid on;

subplot(2,3,3);
plot(f_axis3, abs(y3));
title('Linear chirp magnitude response for 0 ≤ t ≤ 100');
xlabel('Frequency (rad/sample)');
ylabel('Magnitude');
xlim([-pi, pi]);
grid on;

subplot(2,3,4);
plot(f_axis1, angle(y1));
title('Linear chirp phase response for 0 ≤ t ≤ 1');
xlabel('Frequency (rad/sample)');
ylabel('Phase');
xlim([-pi, pi]);
grid on;

subplot(2,3,5);
plot(f_axis2, angle(y2));
title('Linear chirp phase response for 0 ≤ t ≤ 10');
xlabel('Frequency (rad/sample)');
ylabel('Phase');
xlim([-pi, pi]);
grid on;

subplot(2,3,6);
plot(f_axis3, angle(y3));
title('Linear chirp phase response for 0 ≤ t ≤ 100');
xlabel('Frequency (rad/sample)');
ylabel('Phase');
xlim([-pi, pi]);
grid on;

function [y]=DTLTI(a,b,x,Ny)
N = length(a);
M = length(b) - 1;
y = zeros(1, Ny);

    for n = 0:Ny-1        
        for l = 1:N
            if (n+1-l) < 1
                y(n+1) = y(n+1);
            else
                y(n+1) = a(l)*y(n+1-l) + y(n+1);
            end
        end

        for k = 0:M
            if (n+1-k) < 1
                 y(n+1) = y(n+1);
            else
                y(n+1) = b(k+1)*(x(n+1-k)) + y(n+1);
            end
        end
    end
end