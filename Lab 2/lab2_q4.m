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

xt = FSWave(t, K, T, W)

re_xt = real(xt);
im_xt = imag(xt);

figure
grid("on");
%subplot(1, 2, 1);
plot(t, re_xt, 'b');
xlabel('Time (t)');
ylabel('Real part of xt(t)');
title('Re(xt) versus t');
grid("on");
title('Part D');

%{
subplot(1, 2, 2);
plot(t, im_xt, 'r');
xlabel('Time (t)');
ylabel('Imaginary part of xt(t)');
title('Im(xt) versus t');
grid("on");
%}

%sgtitle('Real and Imaginary Parts of xt(t)');


function [xt] = FSWave(t,K,T,W)
    syms x k
    Xk = zeros(1,2*K+1);
    omega = (-K:1:K)* 2 * pi /T;
    fun1 = (1 - 2* x.^2).*exp(-1j* 2 * pi * k * x / T);
    int_f = (1/T)*int(fun1, x, -W/2, W/2);

    for i = 1:2*K+1
        if i == K+1
            sub = 1/T*int((1-2*x^2), x, -W/2, W/2);
            Xk(i) = sub;
        else
            sub = subs(int_f, k, i-(K+1));
            Xk(i) = sub;
        end
    end

    %for Part 4a
    Yk = Xk(2*K+1 : -1 : 1);
   
    xt = SUMCS(t, Yk, omega);

end


    %for Part 4a
    Yk = Xk(2*K+1 : -1 : 1);

    %for Part 4b
    t_0 = 0.6;
    arr = [-K:1:K];
    phase = exp(-1j*2*pi*t_0*arr/T);
    Yk = Xk .* phase;

    %for Part 4c
    arr = [-K:1:K];
    Yk=1j*2*pi*arr.*Xk / T;

    %for Part 4d
    Yk = [Xk(K:-1:1)  Xk(K+1)  Xk(2*K+1:-1:K+2)];



function [xs] = SUMCS(t, A, omega)
    xs = zeros(size(t));

    L = length(A);

    for i = 1:L
        xs = xs + A(i) * exp(1j * omega(i) * t);
    end
end