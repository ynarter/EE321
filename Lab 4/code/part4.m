x = ReadMyImage('Part4.bmp');
%DisplayMyImage(x);

d7 = rem(22102718, 7);

Mh = 30 + d7;
Nh = 30 + d7;
B1 = 0.7;
B2 = 0.4;
B3 = 0.1;

h1 = zeros(Mh, Nh);
h2 = zeros(Mh, Nh);
h3 = zeros(Mh, Nh);

for m=0:Mh-1
    for n=0:Nh-1
        k = B1 * (m - (Mh-1)/2);
        l = B1 * (n - (Nh-1)/2);
        h1(m+1, n+1) = sinc(k) * sinc(l);        
    end
end

for m=0:Mh-1
    for n=0:Nh-1
        k = B2 * (m - (Mh-1)/2);
        l = B2 * (n - (Nh-1)/2);
        h2(m+1, n+1) = sinc(k) * sinc(l);        
    end
end

for m=0:Mh-1
    for n=0:Nh-1
        k = B3 * (m - (Mh-1)/2);
        l = B3 * (n - (Nh-1)/2);
        h3(m+1, n+1) = sinc(k) * sinc(l);        
    end
end



y1=DSLSI2D(h1, x);
y2=DSLSI2D(h2, x);
y3=DSLSI2D(h3, x);

figure
subplot(2,2,1);
DisplayMyImage(x);
title('Original image');
subplot(2,2,2);
DisplayMyImage(y1);
title('B = 0.7');
subplot(2,2,3);
DisplayMyImage(y2);
title('B = 0.4');
subplot(2,2,4);
DisplayMyImage(y3);
title('B = 0.1');






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

