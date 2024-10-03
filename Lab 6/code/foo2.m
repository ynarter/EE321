clear all;
close all;
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

a = [ (p1+p2), -p1*p2];
b = [1 , -z1];
dw = 0.001;
w = [0:dw:2*pi-dw];
 
x = (exp(1i*w) - z1)./((exp(1i*w)-p1).*(exp(1i*w)-p2));
figure;
plot(w,abs(x)); 
xlabel('omega'); ylabel('amplitude');
title('Frequency Response');

 L = 512;
n = 0:L-1;
x = exp((1i*pi*(n.^2))/L);
Ny = length(x);
x2 = linspace(0,2*pi,length(x));
y3=DTLTI(a,b,x,Ny);
figure; subplot(2,3,1); plot(x2,abs(y3)); xlim([0, 2*pi]);
xlabel('omega'); title('L=512/ABS');
subplot(2,3,4); plot(x2,angle(y3)); xlim([0, 2*pi]);
xlabel('omega'); title('L=512/PHASE');

L = 512/2;
n = -L:L;
x = exp((1i*pi*(n.^2))/L);
Ny = length(x);
x2 = linspace(-2*pi,2*pi,length(x));
y3=DTLTI(a,b,x,Ny);
subplot(2,3,2); plot(x2,abs(y3)); xlim([-2*pi, 2*pi]);
xlabel('omega'); title('L=256/ABS');
subplot(2,3,5); plot(x2,angle(y3)); xlim([-2*pi, 2*pi]);
xlabel('omega'); title('L=256/PHASE');


L = 512*2;
n = 0:L-1;
x = exp((1i*pi*(n.^2))/L);
Ny = length(x);
x2 = linspace(0,2*pi,length(x));
y3=DTLTI(a,b,x,Ny);
subplot(2,3,3); plot(x2,abs(y3)); xlim([0, 2*pi]);
xlabel('omega'); title('L=1024/ABS');
subplot(2,3,6); plot(x2,angle(y3)); xlim([0, 2*pi]);
xlabel('omega'); title('L=1024/PHASE');

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