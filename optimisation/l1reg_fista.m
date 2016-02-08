function x = l1reg_fista(x0, A, y, L, lam, options)
% x = l1reg_fista(x0, A, y, L, lam, options)
% Description: 
%    algorithm to minimise F(x) = (y-Ax)'*(y-Ax)/2 + lam*|x| 
%    A. Beck and M. Teboulle: A Fast Iterative Shrinkage-Thresholding Algorithm for Linear Inverse Problems
% In:
%    x0      -- starting value
%    A       -- design matrix
%    y       -- observations/data
%    L       -- empty matris [] or svds(A,1)^2 to save time
%    lam     -- regularisation parameter
%    options -- optinos vector using infopt.m
% Out:
%    x -- optimal parameter
% Author: bcseke@inf.ed.ac.uk
%


if isempty(L),
    %  max eigenvalue of A'*A (try to compute it somehow), ex power method might work
    fprintf('l1reg_fista: computing max eigenvalue of A^{T}A. Please DO this before calling if possible!\n');
    % t = cputime;
    L = svds(A,1)^2;
    % fprintf('l1reg_fista: Done in %f\n', cputime-t);
end

linv = 1/L;
t    = 1;

x = x0(:);
z = x;

converged = 0;
counter   = 0;

while ~converged,
    
    xold = x;
    x    = shrinkage( z - linv*((A*z - y)'*A)', linv*lam);
    
    told = t;
    t    = 0.5*(1 + sqrt(1 + 4*told*told));

    z    = x + ((told -1)/t)*(x-xold);
    
    converged = (max(abs(x-xold))< options.eps) | (counter >= options.MaxIter);
end

function x = shrinkage(z, kappa)
    x = max(0, z-kappa) - max(0, -z-kappa);
