record = audiorecorder(8192, 16, 1);
x = zeros(1, 8192*12);
time = 12;

disp("Recording starts.");
recordblocking(record, time);
disp("End of recording.");

x = getaudiodata(record);
audiowrite('part2record.wav', x, 8192);

t=0:1/8192:12-1/8192;


plot(x, t);