function [logZ, mnew, vnew, z, vv] = likpoissX(y, m, v, xgauss, logwgauss)
%[logZ, mnew, vnew, z, q] = emergency(y, m, v, xgauss, logwgauss)
%Description:
%    this function computes the normalisation and the first and second moments of  e^{y(1)e^{-y(2)*x}}N(x,m,v)
%In:
%    y - a 2-col vector as explained above
%    m - a 1-col vector of the means
%    v - a 1-col vector of the variances
%    [xgauss, logwgauss] - Gauss-Hermite integrarion parameters
%Out:
%    logZ - the normalisation constant
%    m    - the mean 
%    v    - variance
%    [z,q] - other parameters used for testing reasons
%

%
% first find the optimum and then use Laplace approximation to compute local Gaussian approximaiton
I = find(y(:,1)~=0);

a = m(I) + v(I).*y(I,2);
b = log(v(I)) + y(I,3); 
z = zeros(size(a));

for j=1:length(a),
    err   = 1; 
    count = 0;
    zold  = 0;
    while err > 1e-8, 
        zold  = z(j); 
        count = count+1;
        aux   = exp( - (z(j) + b(j)));
        z(j)  = (z(j) - 1 + aux*a(j))./(1 + aux); 
        err   = abs(z(j)-zold);
    end;
end

% keyboard;

% do the expansion and integrate the residual
vv = v(I)./(1 + exp(z + b));
G  = bsxfun(@times,  (y(I,2) - (z - m(I))./v(I)).*sqrt(vv), xgauss(:)') ...
        - exp(bsxfun(@plus, sqrt(vv)*xgauss(:)', z + y(I,3))) ...
        - (0.5*(vv./v(I) - 1))*(xgauss(:).*xgauss(:))' ...
        + ones(length(I), 1)*logwgauss(:)';


Gmax = max(G,[],2);
Gnew = exp(bsxfun(@minus, G, Gmax));
znew = sum(Gnew,2);

t1 = sum(bsxfun(@times,Gnew,xgauss(:)'),2)./znew;
t2 = sum(bsxfun(@times,Gnew,(xgauss(:).^2)'),2)./znew;

mnew = m;
vnew = v;
logZ = zeros(size(m));

mnew(I) = z + sqrt(vv).*t1;       
vnew(I) = vv.*(t2 - t1.^2); 
logZ(I) = Gmax + log(znew) - 0.5*(log(v(I)) - log(vv));


%mnew(I) = z;       
%vnew(I) = vv; 
%logZ(I) = Gmax + log(znew) - 0.5*(log(v(I)) - log(vv));

Jm       = find(isnan(mnew(I)));
mnew(Jm) = z(Jm);
Jv       = find(isnan(vnew(I)));
mnew(Jv) = vv(Jv);

if ~isempty(Jm) | ~isempty(Jv)
    warning('likpoissX: something is wrong!!!');
    keyboard;
end 

% keyboard;