
t=[0:0.001:1];
n=mod(22102718, 41);

real_part = 3 * rand(1, n);
imaginary_part = 3 * rand(1, n);
A = real_part + 1j * imaginary_part;

omega = pi * rand(1, n);

xs= SUMCS(t, A, omega);

real_part_xs = real(xs);
imaginary_part_xs = imag(xs);

magnitude_xs = abs(xs);
phase_xs = angle(xs);

figure
grid("on");
subplot(1, 2, 1);
plot(t, real_part_xs, 'b');
xlabel('Time (t)');
ylabel('Real part of xs(t)');
title('Re(xs) versus t');
grid("on");

subplot(1, 2, 2);
plot(t, imaginary_part_xs, 'r');
xlabel('Time (t)');
ylabel('Imaginary part of xs(t)');
title('Im(xs) versus t');
grid("on");

sgtitle('Real and Imaginary Parts of xs(t)');

figure
subplot(1, 2, 1);
plot(t, magnitude_xs, 'g');
xlabel('Time (t)');
ylabel('Magnitude of xs(t)');
title('Magnitude of xs(t) versus t');
grid("on");

subplot(1, 2, 2);
plot(t, phase_xs, 'm');
xlabel('Time (t)');
ylabel('Phase of xs(t)');
title('Phase of xs(t) versus t');
grid("on");
sgtitle('Magnitude and Phase of xs(t)');





function [xs] = SUMCS(t, A, omega)
    xs = zeros(size(t));

    L = length(A);

    for i = 1:L
        xs = xs + A(i) * exp(1j * omega(i) * t);
    end
end