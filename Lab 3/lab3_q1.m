Number = [8 1 7 2 2];
x = DTMFTRA(Number);
soundsc(x,8192);

X=FT(x);
omega=linspace(-8192*pi,8192*pi,10241); 
omega=omega(1:10240);
plot(omega,abs(X));
grid("on");
xlabel("Omega (W)");
ylabel("Magnitude of X(W)");
title("Magnitude of X(W) vs W");

Number = [5 3 8 7 3 4 5 2 5 4];
x = DTMFTRA(Number);
soundsc(x,8192);

function [x]=DTMFTRA(Number)
t = 0:1/8192:0.25;
t = t(1:end-1);
len_t = length(t);
len_N = length(Number);
x = zeros(1,len_N*len_t);
R = [941 697 697 697 770 770 770 852 852 852]; 
C = [1336 1209 1336 1477 1209 1366 1477 1209 1336 1477];
for k = 1:len_N
    fr = R(Number(k)+1);
    fc = C(Number(k)+1);
    x((k-1)*len_t+1 : k*len_t) = cos(2*pi*fr*t)+cos(2*pi*fc*t);
end 


end





