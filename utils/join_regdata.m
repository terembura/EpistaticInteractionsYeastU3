function d = join_data(regdata1, regdata2)
%
%    joining two regression datasets
%

n1 = length(regdata1.y);
n2 = length(regdata2.y);

d.rownames           = cell(n1+n2,1);
d.rownames(1:n1)     = regdata1.rownames;
d.rownames(n1+1:end) = regdata2.rownames;

d.y  =[regdata1.y;  regdata2.y];
if isfield(regdata1,'ystd') & isfield(regdata2,'ystd'),
    d.ystd  =[regdata1.ystd;  regdata2.ystd];    
end 

d.X1             =[regdata1.X1; regdata2.X1];
[I2, J2, diagn2] = Design2nd(d.X1);
d.X              = [d.X1, sparse(I2, J2, ones(length(I2),1))];
d.diagn          = [[1;1]*[1:size(d.X1,2)], diagn2]; 