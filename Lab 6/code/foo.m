
M = 5 + mod(21501843,5);
N = 20;
k = [0:M-1];
a = zeros(1, N);
b = exp(-k/2);
x = zeros(1,20); x(1) = 1;

y = DTLTI(a,b,x,length(x));
stem(y);
title('Impulse response')
ylabel('amplitude');
xlabel('n');

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
                y(n+1) = b(k+1)*x(n+1-k) + y(n+1);
            end
        end
    end
end