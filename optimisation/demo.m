%
% demo file to do Poisson regression and L1 regression on the unary + binary data 
%

addpath(genpath('../utils'));

% load data from files
<<<<<<< HEAD
d.count_data = process_count_file('example-count-data.txt',[]);
=======
d.count_data = process_count_file('example-read-counts-file.txt',[]);
>>>>>>> 7321f659b6a934e23937f2966ad2b631bce3b188

% run ep, please see the details in the file
d.lamfit     = run_ep_bt(d.count_data, cellfun(@str2num, d.count_data.colnames));

% write out fitness data
writetable('fitness-values.txt', [d.lamfit.lam_mean, d.lamfit.lam_std], d.lamfit.rownames, {'barcode', 'lam_mean', 'lam_std'},'double');

% load the snp_file and fill in the fitness median
<<<<<<< HEAD
% removing linear trend picked up by baseline
a  = [sum(d.lamfit.count_times.^2), sum(d.lamfit.count_times); ...
      sum(d.lamfit.count_times), 1]\[sum(d.lamfit.bt_mean.*d.lamfit.count_times); sum(d.lamfit.bt_mean)];
d.lam_median = -a(1); 
d.snp_data   = process_snp_file('example-snp-data.txt',[]);
=======
d.lam_median = 0.8452; % !!! this is chosen for every data set after assessing the results in fitness-values.txt
d.snp_data   = process_snp_file('example-snp-file.txt',[]);
>>>>>>> 7321f659b6a934e23937f2966ad2b631bce3b188

% create the regression data
d.reg_data = create_regdata(d.lamfit, d.lam_median, d.snp_data);

% save the data in matlab format
<<<<<<< HEAD
save data.mat d;
=======
save data_save.mat d;
>>>>>>> 7321f659b6a934e23937f2966ad2b631bce3b188

% run cross-validation, see runmut.m and runmuts.sh to run this in background and in parallel
lampath = 10.^linspace(-2, 1, 10);
nexp    = 3;
r       = cvRidgeReg_pp(d.reg_data.y, d.reg_data.X, lampath, nexp, 'cv-results.mat');

% save the optimal values
d.reg_data.lamopt = r.lamopt;
d.reg_data.zopt   = r.zopt;
<<<<<<< HEAD
save data.mat d;
=======
save data_save.mat d;
>>>>>>> 7321f659b6a934e23937f2966ad2b631bce3b188

% dump the data in the agreed format
% dump_data(d, 'results.mat');

keyboard;