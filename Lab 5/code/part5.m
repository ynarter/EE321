% Generate sampled version of g(t)
a = randi([2, 6]);
Ts = 1 / (20 * a);
t = -3:Ts:3;
n = t/Ts;

g = zeros(size(t));
g((-1 <= t) & (t < 0)) = -2;
g((0 < t) & (t <= 1)) = 3;
figure;
stem(n, g, 'filled')
title('Sampled Signal g(nTs)')
xlabel('n')
ylabel('g(nTs)')


dur = 6; %for -3<t<3
xR0 = DtoA(0, Ts, dur, g); %zero-order
xR1 = DtoA(1, Ts, dur, g); %linear
xR2 = DtoA(2, Ts, dur, g); %ideal


% Plot the reconstructed signals
tR = linspace(-dur/2, dur/2, numel(xR0));
figure;
%subplot(3, 1, 1)
plot(tR, xR0)
title('Reconstructed Signal using Zero-Order Interpolation')
xlabel('t')
ylabel('xR(t)')
%subplot(3, 1, 2)
figure;
plot(tR, xR1)
title('Reconstructed Signal using Linear Interpolation')
xlabel('t')
ylabel('xR(t)')
%subplot(3, 1, 3)
figure;
plot(tR, xR2)
title('Reconstructed Signal using Ideal Interpolation')
xlabel('t')
ylabel('xR(t)')


% Generate sampled version of g(t)
a = randi([2, 6]); % Random integer between 2 and 6
Ts_values = linspace(1/(20*a), 1/(20*a*10), 10);
reconstructed_signals = cell(size(Ts_values));
for i = 1:numel(Ts_values)
    Ts = Ts_values(i);
    t = -3:Ts:3; % Time axis
    n = 0:length(t)-1; % Sample indices
    g = zeros(size(t));
    g((-1 <= t) & (t < 0)) = -2;
    g((0 < t) & (t <= 1)) = 3;
    % Reconstruct the signal using DtoA function
    reconstructed_signals{i} = DtoA(2, Ts, 6, g);
end
figure;
for i = 1:numel(Ts_values)
    subplot(numel(Ts_values)/2, 2, i)
    stem(reconstructed_signals{i}, 'filled');
    title(['Reconstructed Signal for Ts = ' num2str(Ts_values(i))]);
    xlabel('n');
    ylabel('g(nTs)');
end
%}

function xR=DtoA(type,Ts,dur,Xn)
    t = -dur/2 : Ts/500 : dur/2;
    p = generateInterp(type,Ts,dur);
    len = length(t) + length(Xn)*500; %find length of the convolved array xR
    xR = zeros(1, len);
    
    for n = 0:length(Xn)-1
        xR(500*n+1:500*n+length(p)) = xR(500*n+1:500*n+length(p)) + Xn(n+1)*p;
    end
    
    xR = xR(250*length(Xn)+1: end-250*length(Xn)); %crop accordingly
end



function p = generateInterp(type, Ts, dur)

    t = -dur/2:Ts/500:dur/2;
    switch type
        case 0 %zero-order interpolation
            p = zeros(size(t));
            p(abs(t) <= Ts/2) = 1;
        case 1 % linear interpolation
            p = zeros(size(t));
            p = max(1 - abs(t)/Ts, 0);
        case 2 %ideal interpolation
            p = sinc(t/Ts);
            p(t==0) = 1;
    end
end