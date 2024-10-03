clear all;
clear;

T=2;
W=1;
t=[-5:0.001:5];
D11 = mod(22102718, 11);
D5 = mod(22102718, 5);
K=20+D11;
K1=2+D5;
K2=7+D5;
K3=15+D5; 
K4=50+D5;
K5=100+D5;

xt = FSWave(t, K, T, W);

re_xt = real(xt);
im_xt = imag(xt);

figure
grid("on");
subplot(1, 2, 1);
plot(t, re_xt, 'b');
xlabel('Time (t)');
ylabel('Real part of xt(t)');
title('Re(xt) versus t');
grid("on");


subplot(1, 2, 2);
plot(t, im_xt, 'r');
xlabel('Time (t)');
ylabel('Imaginary part of xt(t)');
title('Im(xt) versus t');
grid("on");


sgtitle('Real and Imaginary Parts of xt(t)');


function [xt] = FSWave(t,K,T,W)

    Xk = zeros(1,2*K+1);
    omega = zeros(1,2*K+1);

    for k = -K:K
        omega(k+K+1) = 2*pi*k/T;
        syms x
        fun = (1 - 2* x^2) *exp(-1j * omega(k+K+1) * x);
        Xk(k+K+1) = (1/T)*int(fun, -W/2, W/2);
    end
        
    xt = SUMCS(t, Xk, omega);

end


function [xs] = SUMCS(t, A, omega)
    xs = zeros(size(t));

    L = length(A);

    for i = 1:L
        xs = xs + A(i) * exp(1j * omega(i) * t);
    end
end