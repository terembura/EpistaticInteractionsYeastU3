%
% demo file to do Poisson regression  and L1 regression on the unary + binary data 
%

addpath(genpath('../utils'));

% load data from files
d.count_data = process_count_file('example-read-cunts-file.txt',[]);

% run ep, please see the details in the file
d.lamfit     = run_ep_bt(d.count_data, cellfun(@str2num, d.count_data.colnames));

% write out fitness data
writetable('fitness-values.txt', [d.lamfit.lam_mean, d.lamfit.lam_std], d.lamfit.rownames, {'barcode', 'lam_mean', 'lam_std'})

% load the snp_file and fill in the fitness median
d.lam_median = 0.8452; % !!! this is chosen for every data set after asessing the results in fitness-values.txt
d.snp_data   = process_snp_file('example-snp-file.txt',[]);

% create the regression data
d.reg_data = create_regdata(d.lamfit, d.lam_median, d.snp_data);

% save the data in matlab format
save data_all_37Csmall_2015_04_10.mat d;

% run cross-validation, see runmut.m and runmuts.sh to run this in background and in parallel
lampath = 10.^linspace(0, log(25), 3);
nexp    = 5;
r       = cvl1reg_pp(d.reg_data.y, d.reg_data.X, lampath, nexp, 'cv-results.mat');

% save the optimal values
d.reg_data.lamopt = r.lamopt;
d.reg_data.zopt   = r.zopt;
save data_all_37Csmall_2015_04_10.mat d;

% dump the data in the agreed format
dump_data(d, 'results.mat');
