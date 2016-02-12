function res = cvl1reg_pp(y, X, lampath, nexp, varargin)
% cvl1reg_pp(y,X, lampath, nexp, varargin)
% Desciptions:
%    crossvalidation for l1 regression
% In:    
%    y           -- data/observations
%    X           -- design matrix
%    lampath     -- regularidation parameter path
%    nexp        -- number of random permutation of data
%    varargin{1} -- filename to save the results to 
% Out:
%    r -- crossvalidation scores as a matrix of size 5*length(lampath)*nexp
%    

nfold = 5;

nx    = size(X,2);
ny    = length(y);

SAVE_ON = 0; 
if ~isempty(varargin)
    SAVE_ON    = 1; 
    fname_save = varargin{1};
end

%choose the cv sets
nfifth = fix(ny/nfold);
I      = cell(nfold,1);
for j=1:nfold-1
    I{j} = [(j-1)*nfifth+1:j*nfifth]';
end
I{nfold} = [(nfold-1)*nfifth+1:ny]';

for j=1:nfold
    Itrain{j} = setdiff([1:ny]', I{j});
    Itest{j}  = I{j};
end
p = zeros(ny, nexp);
for k = 1:nexp
    p(:,k) = randperm(ny);
end

L       = svds(X,1)^2;
rho     = 1;
options = infopt({'TolX', 1e-4});
z       = zeros(nx,1);
zold    = z;
r       = zeros(length(lampath)*nexp, nfold);

for k = 1:nfold*length(lampath)*nexp,
    [l, i, j] = ind2sub([nfold, length(lampath), nexp], k);
    
    t0 = cputime;            
    % zold     = z;
    % z        = l1reg_admm(zold, X(p(Itrain{i}),:), y(p(Itrain{i})), rho, lampath(j), options);
    % z        = l1regbias_fista(zold, X(p(Itrain{i}),:), y(p(Itrain{i})), L, lampath(j), options);
    z    = l1reg_fista(zold, X(p(Itrain{l},j),:), y(p(Itrain{l},j)), L, lampath(i), options);
    r(k) = norm(y(p(Itest{l},j)) - X(p(Itest{l},j),:)*z)^2;
    
    fprintf('Experiment %d, lam %d of %d (%f), fold %d done in %f secs.\n', j, i, length(lampath), lampath(i), l, cputime - t0);                     
end

res.r = reshape(r, [nfold, length(lampath), nexp]);

[bubu,imin] = min(mean(sum(r,1),3));
res.lamopt      = lampath(imin);
res.zopt        = l1reg_fista(zold, X, y, L, lamopt, options);

%zpath = zeros(length(zopt), length(lampath));
%parfor j=1:length(lampath)
%    zpath(:,j) = l1reg_fista(zold, X, y, L, lampath(j), options);
%end

if SAVE_ON
    save(fname_save);
end 
