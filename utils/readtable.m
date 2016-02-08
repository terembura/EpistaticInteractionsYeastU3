function data = readtable(fname)

data.fname    = fname; 
tmp           = textread(fname,'%s%*[^\n]');
data.rownames = tmp(2:end);
A             = textread(fname,'%s','delimiter','\n');

tmp           = textscan(A{1},'%s');
tmp           = tmp{1};
data.colnames = tmp(2:end);
data.matrix   = zeros(length(data.rownames), length(data.colnames));
% keyboard;
for j = 1:size(data.matrix,1)
    sline = A{1 + j}(length(data.rownames{j}) + 1 : end);
    if isempty(sline),
        fprintf('empty line %j \n', j);
        keyboard;
    end
    tmp = textscan(sline,'%d')';
    % keyboard;
    data.matrix(j,:) = tmp{1}';
end
