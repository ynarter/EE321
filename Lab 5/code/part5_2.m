% Generate sampled version of g(t)
a = randi([2, 6]);
Ts_values = linspace(1/(20*a), 1/(20*a*10), 10);
reconstructed_signals = cell(size(Ts_values));
for i = 1:numel(Ts_values)
    Ts = Ts_values(i);
    t = -3:Ts:3;
    n = t/Ts;
    g = zeros(size(t));
    g((-1 <= t) & (t < 0)) = -2;
    g((0 < t) & (t <= 1)) = 3;
    % Reconstruct the signal using DtoA function
    reconstructed_signals{i} = DtoA(2, Ts, 6, g);
end
tR = linspace(-3, 3, numel(reconstructed_signals{1}));
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