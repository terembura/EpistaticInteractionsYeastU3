%
% demo file to do Poisson regression and L1 regression on the unary + binary data 
%

addpath(genpath('../utils'));

% load data from files
d.count_data = process_count_file('example-count-data.txt',[]);

% run ep, please see the details in the file
d.lamfit     = run_ep_bt(d.count_data, cellfun(@str2num, d.count_data.colnames));

% write out fitness data
writetable('fitness-values.txt', [d.lamfit.lam_mean, d.lamfit.lam_std], d.lamfit.rownames, {'barcode', 'lam_mean', 'lam_std'},'double');

% removing linear trend picked up by baseline
a  = [sum(d.lamfit.count_times.^2), sum(d.lamfit.count_times); ...
      sum(d.lamfit.count_times), 1]\[sum(d.lamfit.bt_mean.*d.lamfit.count_times); sum(d.lamfit.bt_mean)];
d.lam_median = -a(1); 
d.snp_data   = process_snp_file('example-snp-data.txt',[]);


% create the regression data
d.reg_data = create_regdata(d.lamfit, d.lam_median, d.snp_data);

% save the data in matlab format
save data.mat d;

% run cross-validation, see runmut.m and runmuts.sh to run this in background and in parallel
lampath = 10.^linspace(-2, 1, 10);
nexp    = 3;
cvres   = cvRidgeReg_pp(d.reg_data.y, d.reg_data.X, lampath, nexp, 'cv-results.mat');

d.reg_data.lamopt   = cvres.lamopt;
d.reg_data.zopt     = cvres.zopt;
d.reg_data.zvar     = cvres.var;
d.reg_data.cvscores = cvres.r;

% write out the z coefficients
dorig     = fix_mut_miss(d);
[dada, I] = sort(abs(dorig.zopt), 'descend');
J         = find(dada>1e-4);
I         = I(J); 

writetable(strcat('regression-coefficients.txt'), ...
    [dorig.diagn(:,I)', dorig.zopt(I)], ...
    {}, {'mutation_1', 'mutation_2', 'regression_coeff'},'double');

% save the optimal values
d.reg_data.lamopt = r.lamopt;
d.reg_data.zopt   = r.zopt;

save data.mat d;

