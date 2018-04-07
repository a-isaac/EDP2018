clear workspace;
roots = [5 complex(3,4) complex(2,3)];

tic
for j=1:size(roots)
    if isreal(roots(j))
        num = roots(j)
    end
end
toc