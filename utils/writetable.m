function writetable(fname, matrix, rownames, colnames, TYPE)
%
%    write a matrix into a coma separeted file
%

fid = fopen(fname,'w');

if ~isempty(colnames)
    s= colnames{1};
    for j=2:length(colnames)
        s = strcat(s, sprintf('\t%s',colnames{j}));              
    end
    fprintf(fid,'%s\n',s);
end
    
for j=1:size(matrix,1)
    switch upper(TYPE)
    case 'INT'
        s = sprintf(' %d',matrix(j,:));
    case 'DOUBLE'
        s = sprintf(' %g',matrix(j,:));
    otherwise
        s = sprintf(' %f',matrix(j,:));
    end
    if ~isempty(rownames)    
        s = strcat(rownames{j}, s);
        fprintf(fid,'%s\n',s);
    else
        % s = strcat(' ',s);
        fprintf(fid,'%s\n',s);
    end    
end
fclose(fid);