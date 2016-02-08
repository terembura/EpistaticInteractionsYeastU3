function d = create_regdata_noBin(lam_data, lam_shift, snp_data)
%Description:
%    creates regression data (without binary coefficients) from the fitness fits, the median fitness and the snp_data
%In:
%    lam_data  -- the fitness data as returned by run_ep_bt.m
%    lam_shift -- the fitness shift = fitness median provided by Olga
%    snp_data  -- the snp data as read by process_snp_file    
%Out:
%    d.rownames -- barcodes
%    d.y        -- the fitness values
%    d.ystd     -- the fitness standard deviations, this is needed later in meandiff
%    d.X1       -- the design matrix for the single mutants as provided by process_snp_file
%    d.X        -- the joint design matrix for singel and double mutants
%    d.diagn    -- the matrix storing the pairs corresoinding to the coefficients
%
    
% find joint set of barcodes
[d.rownames, Iep, Isnp] = intersect(lam_data.rownames, snp_data.rownames); 

% select submatrices and create regression data from  
d.y    = lam_data.lam_mean(Iep) - lam_shift; 
d.ystd = lam_data.lam_std(Iep); 

d.X   = snp_data.X(Isnp,:);

% check empty stuff
%if ~isempty(find(sum(d.X1,1)==0)) | ~isempty(find(sum(d.X1,2)==0)),
%    error('create_regdata: empty rows or columns in the single mutation design matrix');
%end 

%[I2, J2, diagn2] = Design2nd(d.X1);
%d.X              = [d.X1, sparse(I2, J2, ones(length(I2),1), size(d.X1,1), max(J2))];
d.diagn          = [[1;1]*[1:size(d.X,2)]]; 

