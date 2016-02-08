function dorig = fix_mut_miss(d)
%
%    this is a function for fixing the interpretation of coefficients and regression problmes in case of missing mutations 
%


nmut = max(union(d.snp_data.mutation_location, d.snp_data.mutation_location_missing));
% saniity check for rownames
[rowsnames, Isnp, Ireg] = intersect(d.snp_data.rownames, d.reg_data.rownames);
if ~isempty(setdiff(d.reg_data.rownames, d.snp_data.rownames)),
    error('fix_mut_miss: something wrong with the rownames');
end

% transforming indices
diagn = d.reg_data.diagn;
if isfield(d.reg_data, 'colidx'),
    colidx = d.reg_data.colidx;
    if ~isempty(d.reg_data.colidx)
        diagn = d.reg_data.colidx(diagn);
    end
    fprintf('fix_mut_miss: colidx present, reductions for regression have been made, do check manually');
else
    if size(d.reg_data.X1,2) ~= size(d.snp_data.X,2),
        error('fix_mut_miss: colidx missing while reduction of design matrix for regression is present');
    end  
    colidx = [1:size(d.snp_data.X,2)];
end    

if ~isempty(d.snp_data.mutation_location_missing),
    fprintf('fix_mut_miss: missign mutations in the snp, take care\n');
    diagn = d.snp_data.mutation_location(diagn);
end

% sanity check of the X matrices and construction of the full original matrix
if (nnz(d.snp_data.X(Isnp, colidx) - d.reg_data.X1) > 0),
    error('fix_mut_miss: something is wrong with the manupulation of the design matrices');
end 
if nnz(d.reg_data.X1 - d.snp_data.X(:,colidx))>0
    error('fix_mut_miss: indices and matrices not consistent, reg_data.X1 and snp_data.X do not match');  
end 

Xsnp                                 = sparse(size(d.reg_data.X1,1), nmut);
Xsnp(:,d.snp_data.mutation_location) = d.snp_data.X(Isnp,:);


% if no error till here then we have good news and all is well
fprintf('fix_mut_miss: Good news: sanity checks passed!\n');
dorig.rownames = d.reg_data.rownames;
dorig.y        = d.reg_data.y;
dorig.ystd     = d.reg_data.ystd; 
dorig.X1       = Xsnp;
dorig.diagn    = diagn;
dorig.zopt     = d.reg_data.zopt;



