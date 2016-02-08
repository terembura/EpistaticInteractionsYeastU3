function dorig = fix_mut_joint(regdata)
%
%    this is a function for fixing the interpretation of coefficients and regression problmes in case of missing mutations 
%


% reconstruct the original data with the missing mutations
nmut  = max(regdata.colidx);
diagn = regdata.diagn;
diagn = regdata.colidx(diagn);
X                   = sparse(size(regdata.X1,1), nmut);
X(:,regdata.colidx) = regdata.X1;

% do a sanity check on the expanded data matrix
a = find(sum(X,1)~=0);
if any(a~=regdata.colidx),
    error('fix_mut_joint: somehting got fucked up wit the design matrix!');
end

% if no error till here then we have good news and all is well
fprintf('fix_mut_miss: Good news: sanity checks passed!\n');
dorig.rownames = regdata.rownames;
dorig.y        = regdata.y;
dorig.ystd     = regdata.ystd; 
dorig.X1       = X;
dorig.diagn    = diagn;
dorig.zopt     = regdata.zopt;