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
xlim([-pi, pi]);
grid on;


fs = 1700;
t1 = 0:(1/fs):1;
t2 = 0:(1/fs):10;
t3 = 0:(1/fs):1000;

f0 = -600;
f_final = 800;

k1 = (f_final - f0) / 1; %at k=1/10/1000, f = f_ins, at k=0, f = f_0
k2 = (f_final - f0) / 10;
k3 = (f_final - f0) / 1000;

x1 = exp(2j * pi * ((k1/2) * (t1.^2) + f0 * t1));
x2 = exp(2j * pi * ((k2/2) * (t2.^2) + f0 * t2));
x3 = exp(2j * pi * ((k3/2) * (t3.^2) + f0 * t3));

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
%subplot(2,3,1);
plot(f_axis1, abs(y1));
title('Linear chirp magnitude response for 0 ≤ t ≤ 1');
xlabel('Frequency (rad/sample)');
ylabel('Magnitude');
xlim([-pi, pi]);
grid on;

figure;
%subplot(2,3,2);
plot(f_axis2, abs(y2));
title('Linear chirp magnitude response for 0 ≤ t ≤ 10');
xlabel('Frequency (rad/sample)');
ylabel('Magnitude');
xlim([-pi, pi]);
grid on;

figure;
%subplot(2,3,3);
plot(f_axis3, abs(y3));
title('Linear chirp magnitude response for 0 ≤ t ≤ 1000');
xlabel('Frequency (rad/sample)');
ylabel('Magnitude');
xlim([-pi, pi]);
grid on;

figure;
%subplot(2,3,4);
plot(f_axis1, angle(y1));
title('Linear chirp phase response for 0 ≤ t ≤ 1');
xlabel('Frequency (rad/sample)');
ylabel('Phase');
xlim([-pi, pi]);
grid on;

figure;
%subplot(2,3,5);
plot(f_axis2, angle(y2));
title('Linear chirp phase response for 0 ≤ t ≤ 10');
xlabel('Frequency (rad/sample)');
ylabel('Phase');
xlim([-pi, pi]);
grid on;

figure;
%subplot(2,3,6);
plot(f_axis3, angle(y3));
title('Linear chirp phase response for 0 ≤ t ≤ 1000');
xlabel('Frequency (rad/sample)');
ylabel('Phase');
xlim([-pi, pi]);
grid on;

function y = DTLTI(a, b, x, Ny)

    y = zeros(1, Ny);

    N = length(a); %corresponds to N in eqn 1
    M = length(b) - 1; %corresponds to M in eqn 2
    Nx = length(x);
       
    %compute y[n] for 0 ≤ n ≤ Ny-1
    for n = 1:Ny
        %compute the first summation term: Σ a[l]y[n−l]
        sum1 = 0;
        for l = 1:N
            if n - l > 0 %since y[n] is zero for n<0
                sum1 = sum1 + a(l) * y(n - l);
            end
        end
        
        % Compute the second summation term: Σ b[k]x[n−k]
        sum2 = 0;
        for k = 0:M
            if n - k > 0 && n - k <= Nx %since x[n] is zero for n<0
                sum2 = sum2 + b(k + 1) * x(n - k);
            end
        end
        
        % Compute y[n] using Eq. 1
        y(n) = sum1 + sum2;
    end
end
