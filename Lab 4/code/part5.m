clear figure;
x = ReadMyImage('Part5.bmp');
DisplayMyImage(x);
title('Original image');

h1 = [0.5 -0.5];
y1 = DSLSI2D(h1,x);
s1 = y1.^2;
DisplayMyImage(y1);
title('y1[m,n]');

h2 = [0.5 ; -0.5];
y2 = DSLSI2D(h2,x);
s2 = y2.^2;
DisplayMyImage(y2);
title('y2[m,n]');

h3 = 0.5*h1 + 0.5*h2;
y3 = DSLSI2D(h3,x);
s3 = y3.^2;
DisplayMyImage(y3);
title('y3[m,n]');







function [y]=DSLSI2D(h,x)

Mh = size(h,1);
Nh = size(h,2);
Mx = size(x,1);
Nx = size(x,2);

My = Mx + Mh - 1;
Ny = Nx + Nh - 1;

y= zeros(My, Ny);

for k=0:Mh-1
    for l=0:Nh-1
        y(k+1:k+Mx,l+1:l+Nx)=y(k+1:k+Mx,l+1:l+Nx)+h(k+1,l+1)*x;
    end
end

end

