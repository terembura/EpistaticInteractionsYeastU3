function data = readtable_string(fname)

data.fname    = fname; 
tmp           = textread(fname,'%s%*[^\n]');
data.rownames = tmp(1:end);
A             = textread(fname,'%s','delimiter',' ');

%tmp           = textscan(A{1},'%s');
%tmp           = tmp{1};
%data.colnames = tmp(2:end);

% keyboard;
data.smatrix   = cell(length(data.rownames), 3);
for i=1:size(data.smatrix,1)
    tmp                          = textscan(A{i}(length(data.rownames{i})+1:end),'%s');
    
    for j = 1:3
        data.smatrix{i,j} = tmp{1}{j};
    end
end
