
a = zeros(1, 101);

tic; 
for i = 1:101
    a(i) = 1 + (i - 1) * 0.01;
end

toc;
