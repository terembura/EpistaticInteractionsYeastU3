function [I1, J1, diagn1, I2, J2, diagn2] = Design2nd_paired(X,types)
%
% Design the second order matrix 
%
n = size(X,1);
p = size(X,2);
[J,I]=find(X); %recovers barcode and position indices of mutation
nzall    = 0;
nzpaired = 0;
colcount = 0;
paired_vec={'AT','TA','CG','GC'};
for i = 1:p
    for j = i+1:p
        K     = find(X(:,i).*X(:,j));
        
        nzcount = length(K);
vec_paired=zeros(length(K));
for l=1:length(K)
	type1=types(find(I==i&J==K(l)));
        type2=types(find(I==j&J=K(l)));
        vec_paired(l)=sum(strcmp(strcat(type1,type2),paired_vec));
end

        if nzcount
            colcount = colcount + 1;

            diagn1(1, colcount) = i;
            diagn1(2, colcount) = j;
            diagn1(3,colcount)='U';
                        
            diagn2(1, colcount) = i;
            diagn2(2, colcount) = j;
            diagn2(3,colcount)='P';

            
            I1(nzall+1:nzall + nzcount) = K(:);  
            J1(nzall+1:nzall + nzcount) = colcount;         
            
            nzall = nzall + nzcount;
        end
K2=K(find(vec_paired));
nzcount_paired=length(K2);
      if nzcount_paired
I2(nzpaired+1:nzpaired + nzcount_paired) = K2(:);  
            J1(nzpaired+1:nzpaired + nzcount_paired) = colcount;         
            
            nzpaired = nzpaired + nzcount_paired;
end

    end
end
