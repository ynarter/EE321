
a = [1, -0.5, 0.2];   % Coefficients for a[l]
b = [0.3, 0.6, -0.1]; % Coefficients for b[k]
x = rand(1, 10);      % Input signal x[n] (random for demonstration)
Ny = 15;              % Desired length of the output signal

y = DTLTI(a, b, x, Ny);
disp(y);




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
