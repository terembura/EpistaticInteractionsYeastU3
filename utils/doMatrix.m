function d = doMatrix(A, mutation_types)
%
%    
%

% process mutations by iterating through barcodes
rownames = unique(A.rownames);
M        = containers.Map(rownames, num2cell([1:length(rownames)]));
for j = 1:length(A.rownames)
    I(j)     = M(A.rownames{j});
    J(j)     = sscanf(A.smatrix{j,2},'%d');
    mtype(j) = A.smatrix(j,3);
end

% remove funny negative and 0 locations (it happens to have some)
K = find(J>0);
I     = I(K);
J     = J(K);
mtype = mtype(K);

% select desired mutations
mok = ones(length(I),1);
if ~isempty(mutation_types)
    for j=1:length(I)
        mok(j) = any(ismember(mutation_types, mtype(j)));
    end    
else
    mutation_types = unique(A.smatrix(:,3));
end
K = find(mok);
I = I(K);
J = J(K);

% remove empty rows (it can happen after the above step)
X        = sparse(I,J,ones(length(I),1));
Inz      = find(sum(X,2)~=0);
rownames = rownames(Inz);
X        = X(Inz,:);

% check if there is a missing mutation
Imiss = find(sum(X,1)==0);
Iok   = find(sum(X,1)~=0);

if ~isempty(Imiss),
    warning('doMatrix: some mutations are missing!\n');
end

d.rownames = rownames;
d.X        = X(:,Iok);
d.I=I;
d.J=J;
d.mtype=mtype;
d.mutation_labels            = unique(A.smatrix(:,3));
d.mutation_selected          = mutation_types;
d.mutation_location          = Iok;
d.mutation_location_missing  = Imiss;

% keyboard;
