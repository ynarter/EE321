t=[0:1/8192:1];
a = 2013;
x4 = cos(a * pi * t.^2);

x5= cos(2 * pi * (-500 * t.^2 + 1600 * t))

plot(t,x5)

soundsc(x4)