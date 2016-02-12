function generate_toy_data(lam_shift)
%
%   
%

addpath(genpath('../utils'));

nm       = 50;
ny       = 1000;
%lam_mean = 1;
sigz     = 0.5;
sigy     = 0.25;
t        = [0:5];
nt       = length(t);
lam_base = 0;

% generate design matrix
U = sparse(ny, nm);
for i = 1:ny
    nnz_row = 2 + floor(9*rand(1));
    I       = 1 + floor(nm*rand(1,nnz_row));
    U(i,I)  = 1; 
end
I = find(sum(U,2));
J = find(sum(U,1));
X1 = U(I, J);
nm = size(X1,2);
ny = size(X1,1);

[I, J] = Design2nd(X1);
X  = [X1, sparse(I,J, ones(length(I),1))];
nz = size(X,2);

% generate coefficients 0.5 % of the possible mutations
K      = find(rand(nz,1) < 0.05);
z      = zeros(nz,1);
z(K)   = sigz*randn(length(K),1);
wnoise = randn(ny,1);
lam    = X*z + sigy*wnoise - lam_shift;
 
% generate Poisson mean values
b0 = 6 + randn(ny, 1);
bt = lam_base*t;
y  = poissrnd(exp(bsxfun(@plus, bsxfun(@plus, lam*t, b0), bt)));

% generate barcodes and mutations
codes = ['A','T','C','G'];
[I,J] = find(X1);
mfrom = codes(1 + floor(4*rand(length(I),1)));
mto   = codes(1 + floor(4*rand(length(I),1)));

uniquebc = false;
k = 0;
M = 2^40-1;
c = zeros(ny,1);

k = 0;
fillok = false;
while(~fillok)
    c = 1 + floor(M*rand(ny,1));
    fillok = (length(unique(c))== ny);
    if ~fillok
        disp('Wow, rare event! resampling barcodes');
    end
end

B = de2bi(c);
barcodes = cell(ny,1);
for i = 1:ny
    barcodes{i} = codes(2*B(i,1:2:end) + B(i, 2:2:end) + 1);
end
barcodes = sort(barcodes);

colnames = cell(length(t)+1,1);
colnames{1} = 'time';
for i=1:length(colnames)-1
    colnames{i+1} = num2str(t(i));
end

writetable('example-count-data.txt', int64(y) , barcodes, colnames, 'int');

[J, I] = find(X1');
fid = fopen('example-snp-data.txt','w');
for i = 1:length(I)
    fprintf(fid,'%s\t%s\t%d\t%s',barcodes{I(i)}, mfrom(i), J(i), mto(i));
    if i~=length(I)
        fprintf(fid,'\n');
    end
end
fclose(fid);

save('td.mat');