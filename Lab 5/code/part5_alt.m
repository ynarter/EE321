% Generate sampled version of g(t)
a = randi([2, 6]);
Ts = 1 / (20 * a);
t = -3:Ts:3;

n = t/Ts;
%n = 0:length(t)-1; 

g = zeros(size(t));
g((-1 <= t) & (t < 0)) = -2;
g((0 < t) & (t <= 1)) = 3;
figure;
stem(n, g, 'filled')
title('Sampled Signal g(nTs)')
xlabel('n')
ylabel('g(nTs)')

% Reconstruct the signal using different interpolation methods
dur = 6; % Duration for reconstruction
type = [0, 1, 2]; % Interpolation types: 0 for zero-order, 1 for linear, 2 for ideal
xR = cell(1, numel(type));
for i = 1:numel(type)
xR{i} = DtoA(type(i), Ts, dur, g);
end
% Plot the reconstructed signals
tR = linspace(-dur/2, dur/2, numel(xR{1}));
figure;
subplot(3, 1, 1)
plot(tR, xR{1})
title('Reconstructed Signal using Zero-Order Interpolation')
xlabel('t')
ylabel('xR(t)')
subplot(3, 1, 2)
plot(tR, xR{2})
title('Reconstructed Signal using Linear Interpolation')
xlabel('t')
ylabel('xR(t)')
subplot(3, 1, 3)
plot(tR, xR{3})
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
    g((-3 <= t) & (t < -1)) = -3;
    g((-1 < t) & (t <= 0)) = 4;
    % Reconstruct the signal using DtoA function
    reconstructed_signals{i} = DtoA(2, Ts, 6, g);
end
figure;
for i = 1:numel(Ts_values)
figure
stem(reconstructed_signals{i}, 'filled');
title(['Reconstructed Signal for Ts = ' num2str(Ts_values(i))]);
xlabel('n');
ylabel('g(nTs)');
end

function xR = DtoA(type, Ts, dur, Xn)
    N = numel(Xn); % Number of samples
    t = -dur/2:Ts/500:dur/2; % Discrete time axis for generating the pulses
    % Generate the interpolating pulse
    p = generateInterp(type, Ts, dur);
    % Perform the interpolation
    xR = conv(Xn, p, 'same');
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
