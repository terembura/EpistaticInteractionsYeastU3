function d = join_data(data1, data2)
%
%    joining two regression datasets
%

n1 = length(data1.reg_data.y);
n2 = length(data2.reg_data.y);

d.rownames           = cell(n1+n2,1);
d.rownames(1:n1)     = data1.reg_data.rownames;
d.rownames(n1+1:end) = data2.reg_data.rownames;

d.y  =[data1.reg_data.y;  data2.reg_data.y];
if isfield(data1.reg_data,'ystd') & isfield(data2.reg_data,'ystd'),
    d.ystd  =[data1.reg_data.ystd;  data2.reg_data.ystd];    
end 

% here we must be careful with the design
XX1 = sparse([],[],[], size(data1.snp_data.X,1), length(data1.snp_data.mutation_location) + length(data1.snp_data.mutation_location_missing));
XX2 = sparse([],[],[], size(data2.snp_data.X,1), length(data2.snp_data.mutation_location) + length(data2.snp_data.mutation_location_missing));
if size(XX1,2)~=size(XX2,2)
    warning('join_data: size problems with joining the design matrices');
end


% this is really stupid but I am lazy and this code is not used often anyways
XX1(:,data1.snp_data.mutation_location) = data1.snp_data.X;
XX2(:,data2.snp_data.mutation_location) = data2.snp_data.X;
XX                                      = [XX1; XX2];

% keyboard;

% do the checking
d.colidx = find(sum(XX,1)~=0);
if length(d.colidx)~=size(XX,2)
    XX = XX(:,d.colidx);
end

% finish design
d.X1             = XX;
[I2, J2, diagn2] = Design2nd(d.X1);
d.X              = [d.X1, sparse(I2, J2, ones(length(I2),1), size(d.X1,1), max(J2))];
d.diagn          = [[1;1]*[1:size(d.X1,2)], diagn2]; 

d.source1 = data1;
d.source2 = data2;
