function I = single_mutants(X)

I = cell(size(X,2),1);
for j = 1:size(X,2)
    J = find(X(:,j));
    K = find(sum(X(J,:),2)==1);
    I{j} = J(K);
end