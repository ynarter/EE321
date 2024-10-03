D4 = rem(22102718, 4);
M = 5+D4;
a = zeros(1, 10);
arr = 0:M-1;
b = exp(-1*arr)
Ny = 11;

delta = zeros(1, Ny);
delta(1) = 1; %Kronecker delta function is 1 only at n=0

h = DTLTI(zeros(1, length(b)), b, delta, Ny)

%h(8)=0;
%h(9)=0;
%h(10)=0;
%h(11)=0;

figure;
stem(0:Ny-1, h, 'LineWidth', 1.5, 'Marker', 'o');
title('Impulse Response h[n]');
xlabel('n');
ylabel('h[n]');
grid on;

function y = DTLTI(a, b, x, Ny)

    y = zeros(1, Ny);

    N = length(a); %corresponds to N in eqn 1
    M = length(b) - 1; %corresponds to M in eqn 2
    Nx = length(x);
       
    % Compute y[n] for 0 ≤ n ≤ Ny-1
    for n = 1:Ny
        % Compute the first summation term: Σ a[l]y[n−l]
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


