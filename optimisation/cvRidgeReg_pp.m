function res = cvRidgeReg_pp(y, X, lampath, nexp, varargin)
% cvl1reg_pp(y,X, lampath, nexp, varargin)
% Desciptions:
%    cross-validation for ridge regression
% In:    
%    y           -- data/observations
%    X           -- design matrix
%    lampath     -- regularisation parameter path
%    nexp        -- number of random permutation of data
%    varargin{1} -- filename to save the results to 
% Out:
%    r -- cross-validation scores as a matrix of size 5*length(lampath)*nexp
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


r       = zeros(length(lampath)*nexp, nfold);
vari     = zeros(length(lampath)*nexp, nfold);
for k = 1:nfold*length(lampath)*nexp,
    [l, i, j] = ind2sub([nfold, length(lampath), nexp], k);
    tic
    t0 = cputime;            
    
    z    = ridgeRegVanilla(y(p(Itrain{l},j)),X(p(Itrain{l},j),:),lampath(i));
    r(k) = norm(y(p(Itest{l},j)) - X(p(Itest{l},j),:)*z)^2/length(y(p(Itest{l},j)));
    vari(k)=var((y(p(Itest{l},j))));
    toc
    fprintf('Experiment %d, lam %d of %d (%f), fold %d done in %f secs.\n', j, i, length(lampath), lampath(i), l, cputime - t0);                     
end

r = reshape(r, [nfold, length(lampath), nexp]);
vari = reshape(vari, [nfold, length(lampath), nexp]);

[bubu,imin] = min(mean(sum(r,1),3));
lamopt      = lampath(imin);
zopt        = ridgeRegVanilla(y,X,lamopt);

res.lamopt = lamopt;
res.zopt   = zopt;
res.r      = r;
res.var    = vari;


if SAVE_ON
    save(fname_save);
end 
