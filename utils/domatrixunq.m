function d = domatrixunq(A)
%
%    
%

% process mutations by iterating through barcodes
rownames = unique(A.rownames);
M        = containers.Map(rownames, num2cell([1:length(rownames)]));
for j = 1:length(A.rownames)
    I(j)     = M(A.rownames{j});
    J(j)     = sscanf(A.smatrix{j,2},'%d');
    mfrom(j) = A.smatrix(j,1);
    mto(j)   = A.smatrix(j,3);
end

% remove funny negative and 0 locations (it happens to have some)
K     = find(J>0);
I     = I(K);
J     = J(K);
mfrom = mfrom(K);
mto   = mto(K);



% construct forward and backward dictionaries for the mutations
nmut   = max(J);
M      = cell(nmut,1);
mcount = zeros(nmut,1);
for j=1:length(M),
    M{j} = [];
end
for j = 1:length(J),
    ss  = strcat(mfrom(j), '->', mto(j));
    if ~any(strcmp(M{J(j)}, ss)),
        M{J(j)}      = [ M{J(j)}, ss]; 
    end
end
mcount = cellfun(@length,M);

for j = 1:length(M),
    M{j} = sort(M{j}); 
end


nz     = sum(mcount);
mutidx = zeros(nz, 1);
k = 0;
for j=1:nmut,
    mutidx(k+1:k+mcount(j)) = j;
    k                       = k + mcount(j);
end

mstart = cumsum(mcount);
mstart = [0; mstart(1:end-1)];
JX     = zeros(size(J));
for j = 1:length(J),
    ss  = strcat(mfrom(j), '->', mto(j));
    idx = find(strcmp(M{J(j)}, ss)); 
    idx = mstart(J(j)) +idx;
    mutfrom(idx) = mfrom(j);
    mutto(idx)   = mto(j);
    JX(j)        = idx;   
end

Midx = cell(length(M),1);
for j=1:length(M)
    Midx{j} = mstart(j) + [1:length(M{j})];
end

X        = sparse(I, JX, ones(length(I),1));
Inz      = find(sum(X,2)~=0);
X        = X(Inz,:);
rownames = rownames(Inz);

d.X         = X;
d.rownames  = rownames;
d.mut_dict  = M;
d.mut_idx   = Midx;
d.find_site = mutidx;
d.find_from = mutfrom;
d.find_to   = mutto;
