t = linspace(1,4,151);
x=sin(2*pi*t+pi/3)

figure
plot(t,x,'b');

hold on

t = [0:0.01:1];
x=sin(2*pi*t+pi/3);
plot(t,x,'r');

t = [0:0.1:1];
x=sin(2*pi*t+pi/3);
plot(t,x,'g');

t = [0:0.2:1];
x=sin(2*pi*t+pi/3);
plot(t,x,'m');






