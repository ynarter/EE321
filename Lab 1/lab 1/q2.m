t=[0:1/8192:1];
f0=510;
f1=6;

a=7;
x1 = cos(2*pi*f0*t);
x2 = exp(-a*t).*cos(2*pi*f0*t);
x3 = cos(2*pi*f0*t).*cos(2*pi*f1*t);

plot(t, x2)
sound(x3)

