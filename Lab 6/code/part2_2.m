omega = -pi:0.001:pi;
impulse_response = zeros(1, length(omega));

for m = 1:length(omega)
    sum = 0;
    for k= 0:6
        sum = sum + exp(-k) * exp(-1i * omega(m) * -k);
    end

    impulse_response(m) = sum;

end

figure;
plot(omega, abs(impulse_response));
title('Magnitude Response of the Impulse Response h[n]');
xlabel('Omega (Ω)');
ylabel('|H(e^j^Ω)|');
xlim([-pi, pi]);
grid on;

fs = 1400;
t1 = 0:(1/fs):1;
t2 = 0:(1/fs):10;
t3 = 0:(1/fs):1000;

f0 = 0;
f_final = 700;

D4 = rem(22102718, 4);
M = 5+D4;
a = zeros(1, 10);
arr = 0:M-1;
b = exp(-1*arr);

k1 = (f_final - f0) / 1; %at k=1/10/100, f = f_ins, at k=0, f = f_0
k2 = (f_final - f0) / 10;
k3 = (f_final - f0) / 1000;

x1 = cos(2 * pi * ((k1/2) * (t1.^2)) + f0 * t1); %integrate to obtain phi(t)
x2 = cos(2 * pi * ((k2/2) * (t2.^2)) + f0 * t2);
x3 = cos(2 * pi * ((k3/2) * (t3.^2)) + f0 * t3);


y1 = DTLTI(a, b, x1, length(x1));
y2 = DTLTI(a, b, x2, length(x2));
y3 = DTLTI(a, b, x3, length(x3));


N1 = length(y1);
N2 = length(y2);
N3 = length(y3);
f_axis1 = linspace(0, pi, N1);
f_axis2 = linspace(0, pi, N2);
f_axis3 = linspace(0, pi, N3);

figure;
%subplot(1,3,1);
plot(f_axis1, abs(y1));
title('Linear chirp response for 0 ≤ t ≤ 1');
xlabel('Frequency (rad/sample)');
ylabel('Magnitude');
xlim([0, pi]);
grid on;

%subplot(1,3,2);
figure;
plot(f_axis2, abs(y2));
title('Linear chirp response for 0 ≤ t ≤ 10');
xlabel('Frequency (rad/sample)');
ylabel('Magnitude');
xlim([0, pi]);
grid on;

%subplot(1,3,3);
figure;
plot(f_axis3, abs(y3));
title('Linear chirp response for 0 ≤ t ≤ 1000');
xlabel('Frequency (rad/sample)');
ylabel('Magnitude');
xlim([0, pi]);
grid on;

function y = DTLTI(a, b, x, Ny)

    y = zeros(1, Ny);

    N = length(a); %corresponds to N in eqn 1
    M = length(b) - 1; %corresponds to M in eqn 2
    Nx = length(x);
       
    % compute y[n] for 0 ≤ n ≤ Ny-1
    for n = 1:Ny
        % compute the first summation term: Σ a[l]y[n−l]
        sum1 = 0;
        for l = 1:N
            if n - l > 0 %since y[n] is zero for n<0
                sum1 = sum1 + a(l) * y(n - l);
            end
        end
        
        % compute the second summation term: Σ b[k]x[n−k]
        sum2 = 0;
        for k = 0:M
            if n - k > 0 && n - k <= Nx %since x[n] is zero for n<0
                sum2 = sum2 + b(k + 1) * x(n - k);
            end
        end
        
        % compute y[n] using Eq. 1
        y(n) = sum1 + sum2;
    end
end