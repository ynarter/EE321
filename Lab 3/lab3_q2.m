Number = [8 1 7 2 2];
x = DTMFTRA(Number);
omega=linspace(-8192*pi,8192*pi,10241); 
omega=omega(1:10240);
len_t = 2048;
len_n = length(Number);

rec= zeros(1, length(omega));
rec(1, 4*len_t +1 : 5*len_t) = ones(1, len_t);
x_1 = rec .* x;
X = FT(x_1);

plot(omega, abs(X));
grid("on");
xlabel("Omega (W)");
ylabel("Magnitude of X(W)");
title("Fifth digit magnitude");

function [x]=DTMFTRA(Number)
t = 0:1/8192:0.25;
t = t(1:end-1);
len_t = length(t);
len_N = length(Number);
x = zeros(1,len_N*len_t);
A = [941 697 697 697 770 770 770 852 852 852; 1336 1209 1336 1477 1209 1366 1477 1209 1336 1477];
for n = 1:len_N
    a = [A(1,Number(n)+1) A(2,Number(n)+1)]';
    x(1,(n-1)*len_t+1:n*len_t) = cos(2*pi*a(1)*t)+cos(2*pi*a(2)*t);
end 


end





