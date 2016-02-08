function [m, v, V, proj, terms] = ep_slopes_bt(y, count_times, m0, v0, options, varargin)
% [m, v, V, proj, terms] = ep_slopes_bt(y, count_times, m0, v0, options, varargin)
% Description:
%    does Poisson regression by Expectation Propagation (EP) on tabular count data using the model
%    y(i,j) ~ Poisson(exp(z(i,j)))   
%    z(i,j) = lambda(i)*t(j) + b(i) + bt(j) 
%               (bt(1) is orced to 0 by a strong prior to kill overspec.)  
% In:
%    y           -- the count data nrows x ncols matrix   
%    count_times -- the times t(j)
%    m0, v0      -- prior means and variances for the parameters [lambda, b, bt] same 
%                   Gaussiam prior for all lambda(i) and b(i); m0 and v0 have size (2+ncols) x 1 
% Out:
%    m, v  -- mean and variance values structured like [lambda(:); b(:); bt(:)]
%    V     -- large sparse covariance matrix corresponding to interactions
%    proj  -- cavity distributions for the terms in EP
%    terms -- the term approximations EP
% Author: bcseke@inf.ed.ac.uk
%

% processing input parameters
nrows  = size(y,1);
ncols  = size(y,2);
t      = count_times;

h0                  = zeros(2*nrows + ncols, 1);
h0(1:nrows)         = m0(1)/v0(1);
h0(nrows+1:2*nrows) = m0(2)/v0(2);
h0(2*nrows+1:end)   = reshape(m0(3:end)./v0(3:end), length(v0)-2, 1);

tmp                  = ones(2*nrows + ncols, 1);
tmp(1:nrows)         = 1/v0(1);
tmp(nrows+1:2*nrows) = 1/v0(2);
tmp(2*nrows+1:end)   = reshape(1./v0(3:end), length(v0)-2, 1);
Q0                   = spdiags(tmp,[0], 2*nrows + ncols, 2*nrows + ncols); 


% data holders and parameters
Q    = [speye(nrows), speye(nrows), ones(nrows,ncols); speye(nrows), speye(nrows), ones(nrows, ncols); ones(ncols, 2*nrows), speye(ncols)];
h    = zeros(2*nrows + ncols, 1);
pamd = symamd(Q);

ipamd       = zeros(length(pamd),1);
ipamd(pamd) = [1:length(pamd)]';

V = spones(Q);
m = zeros(size(h));

if ~isempty(varargin)
    terms.h = varargin{1};
    terms.q = varargin{2};
else    
    terms.h = zeros(size(y));
    terms.q = ones(size(y));
end

 
cav.m   = zeros(size(y));
cav.v   = zeros(size(y));

proj.m  = zeros(size(y));
proj.v  = zeros(size(y));

logZ = zeros(nrows*ncols, 1);
mnew = zeros(nrows*ncols, 1);
vnew = zeros(nrows*ncols, 1);

% some indices
I1  =           [1:nrows]';
I2  = nrows +   [1:nrows]';
I3  = 2*nrows + [1:ncols]';
I11 = sub2ind(size(Q),         [1:nrows]',         [1:nrows]');
I12 = sub2ind(size(Q),         [1:nrows]', nrows + [1:nrows]');
I21 = sub2ind(size(Q), nrows + [1:nrows]',         [1:nrows]');
I22 = sub2ind(size(Q), nrows + [1:nrows]', nrows + [1:nrows]');
I33 = sub2ind(size(Q), [2*nrows+1 : 2*nrows + ncols], [2*nrows+1 : 2*nrows + ncols]);

% setting likelihood parameters and adding fractional EP options 
sitepar      = ones(nrows*ncols,2);
sitepar(:,1) = options.alpha;
sitepar(:,2) = y(:);
mshift       = zeros(nrows,ncols); % this should be removed altogether

% loop control
counter   = 0;
converged = 0;

while ~converged,
    counter = counter + 1;

    % update moments: create new precision and do the canonical to moment transformation
    Q(I11)    = terms.q*(t(:).*t(:));
    Q(I22)    = sum(terms.q, 2);
    Q(I33)    = sum(terms.q, 1)';
    Q(I12)    = terms.q*t(:);
    Q(I21)    = Q(I12);
    Q(I1, I3) = bsxfun(@times, terms.q, t(:)');
    Q(I3, I1) = Q(I1, I3)'; 
    Q(I2, I3) = terms.q;
    Q(I3, I2) = Q(I2, I3)';
    h(I1)     = terms.h*t(:);
    h(I2)     = sum(terms.h, 2);
    h(I3)     = sum(terms.h, 1)';     
    
    L       = chol(Q(pamd, pamd) + Q0(pamd, pamd), 'lower');
    m(pamd) = L'\(L\(h(pamd) + h0(pamd)));   
    S       = fastinvc(L);
    V       = S(ipamd, ipamd); 
    
    % compute projections, extract projected marginals from the mean and covariance
    proj.m = bsxfun(@times, m(I1), t(:)') + bsxfun(@plus, m(I2), m(I3)');  
    for j = 1:ncols
        proj.v(:,j) = t(j)*t(j)*V(I11) + 2*t(j)*(V(I12) + V(I1, 2*nrows + j)) + V(I22) + 2*V(I2,2*nrows + j) + V(2*nrows + j, 2*nrows + j); 
    end
    
    % compute cavity terms
    cav.v = 1./(1 - options.alpha*terms.q.*proj.v);
    cav.m = (proj.m - options.alpha*terms.h.*proj.v).*cav.v;
    cav.v = proj.v.*cav.v; 
    
    % update terms
    terms_old = terms;
    
%    [logZ, mnew, vnew] = likpoiss(sitepar, cav.m(:) + mshift(:), cav.v(:), options.xgauss, options.logwgauss);
%    mnew               = mnew - mshift(:);
    
    [logZ, mnew, vnew] = likpoissX([sitepar, mshift(:)], cav.m(:), cav.v(:), options.xgauss, options.logwgauss);    
    terms.h            = (1 - options.eps)*terms.h + (options.eps/options.alpha)*(reshape(mnew./vnew, nrows, ncols) - cav.m./cav.v);
    terms.q            = (1 - options.eps)*terms.q + (options.eps/options.alpha)*(reshape(1./vnew,    nrows, ncols) - 1./cav.v);
        
    % convergence check
    dpar      = max(max(abs(terms_old.h(:) -  terms.h(:))), max(abs(terms_old.q(:) -  terms.q(:))));
    converged = (counter >= options.MaxIter) | (dpar < options.TolX) ; 

    if options.Verb
        fprintf('Cycle %d done with dpar = %f \n', counter, dpar);
    end
end

v = spdiags(V, [0]);
