function reg_data_new = create_regdata_olga_refit(reg_data)
%
%
%

% for all unaries find the mean replecement if there is

idx_ns   = [];
nsrow   = ones(size(reg_data.X,1),1);
Im1     = sum(reg_data.X1,2)==1; 
zsingle = zeros(size(reg_data.X1,2),1);
for j = 1:size(reg_data.X1,2)
    Isingle{j} = find((reg_data.X1(:,j)==1) & Im1);
    if isempty(Isingle{j}), 
        idx_ns = [idx_ns, j];
    else
        zsingle(j)        = mean(reg_data.y(Isingle{j}));
        nsrow(Isingle{j}) = 0;
    end
end
idx_ys    = setdiff([1:size(reg_data.X1,2)], idx_ns);
idx_nsrow = find(nsrow);
idx_nscol = setdiff([1:size(reg_data.X,2)], idx_ys);
% compute emprical coeff values
reg_data_new.rownames = reg_data.rownames(idx_nsrow);
reg_data_new.y        = reg_data.y(idx_nsrow) - reg_data.X1(idx_nsrow, idx_ys)*zsingle(idx_ys);
reg_data_new.ystd     = reg_data.ystd(idx_nsrow);
reg_data_new.X1       = reg_data.X1(idx_nsrow, idx_ns);
reg_data_new.X        = reg_data.X(idx_nsrow, idx_nscol);
reg_data_new.diagn    = reg_data.diagn(:, idx_nscol);
reg_data_new.idx_ys   = idx_ys;
reg_data_new.zsingle  = zsingle(idx_ys);



