function [I, J, diagn] = Design3nd(X)
%
% Design the second order matrix 
%
n = size(X,1);
p = size(X,2);

nzall    = 0;
colcount = 0;

for i = 1:p
    for j = i+1:p
        for k = j+1:p
            for l = k+1:p
                K       = find(X(:,i).*X(:,j).*X(:,k).*X(:,l));
                nzcount = length(K);
                if nzcount
                    colcount = colcount + 1;
        
                    diagn(1, colcount) = i;
                    diagn(2, colcount) = j;
                    diagn(3, colcount) = k;
                    diagn(4, colcount) = l;
                    
                    
                    I(nzall+1:nzall + nzcount) = K(:);  
                    J(nzall+1:nzall + nzcount) = colcount;         
                    
                    nzall = nzall + nzcount;
                end
            end
        end
    end
end