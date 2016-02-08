function d = process_count_file(fname, selcols)
%Description:
%     processes count data file
%In:
%    fname   -- name of input files
%    selcols -- which columns to select (in some cases we don't want all)
%Out:
%    d.fname    -- the name of the processed file
%    d.colnames -- the column labels
%    d.rownames -- the row labels
%    d.y        -- the count data
%

%A       = readtable('readcounts-37Csmall-2015-04-10_mod.txt');
A       = readtable(fname);
if isempty(selcols)
    selcols = [1:size(A.matrix,2)];
end
y       = A.matrix(:, selcols);
% y = A.matrix(:,[1 3 4 5]);
I = find(sum(y(:,2:end),2)~=0);

d.fname    = A.fname;
d.colnames = A.colnames(selcols);
% d.colnames = A.colnames([1 3 4 5]);
d.rownames = A.rownames(I);
d.y        = y(I,:);

d.processing_file = 'process_count_file';
