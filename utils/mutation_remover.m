function dnew = mutation_remover(d, mutations, OPCODE)
%
%    remove mutations form a dataset
%

switch upper(OPCODE)
    case 'REMOVE'
        I = ones(size(d.X1,1),1);
        for j = 1:length(mutations)
            I(find(d.X1(:,mutations(j)))) = 0; 
        end
    case 'SELECT',
        I = zeros(size(d.X1,1),1);
        for j = 1:length(mutations)
            I(find(d.X1(:,mutations(j)))) = 1; 
        end      
    otherwise,
        error('mutation_remover: operation must be either "select" or "remove"');
end    

I = find(I);
J = find(sum(d.X1(I,:),1)~=0);

dnew.rownames = d.rownames(I);
dnew.y        = d.y(I);
dnew.ystd     = d.ystd(I);
dnew.colidx   = J;

dnew.X1       = d.X1(I,J);
[I2, J2, diagn] = Design2nd(dnew.X1);
dnew.X          = [dnew.X1, sparse(I2, J2, ones(length(I2),1), size(dnew.X1,1), max(J2))];
dnew.diagn      = [[1;1]*[1:size(dnew.X1,2)],diagn];

