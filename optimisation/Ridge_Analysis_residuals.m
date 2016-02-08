function ridge_out=Ridge_Analysis_residuals(fitness_file,snps_file, ridgePath,unary_file)

%RIDGE_ANALYSIS function for ridge regression for snps
  %In: - fitness_file a .txt file with first column barcodes and second column fitness values (with median removed)
% - snps_file a file with the mutations corresponding to the barcodes
     % Out: struct with the following
% - .ridge_path the various regularisation coefficients used
% - .cv_errors a vector of CV RMSEs for all ridge_path
% - .coeffs regression coefficients
% - .preds predicted fitness values

addpath(genpath('../utils'));

addpath(genpath('../optimisation'));

% load data from files

[barcodes,lamfit]=textread(fitness_file, '%s%f');
lam_data.lam_mean=lamfit;
lam_data.rownames=barcodes;
lam_shift=0;
snp_data= process_snp_file(snps_file,[]);
lam_data.lam_std=0.1*ones(size(lam_data.lam_mean));
reg_data=create_regdata_residuals(lam_data,lam_shift,snp_data);
unaries=load(unary_file);
%effective_unaries=[zeros(7,1);unaries(:,2)];
ridge_out.y=reg_data.y-reg_data.X1*unaries(:,2);


ridge_out.design=reg_data.X2;

%now cross-validate ridge regression

ridge_out.ridge_path=ridgePath;

nexp=5; %use five-fold CV

ridge_out.cv_results=cvRidgeReg_pp(ridge_out.y, reg_data.X2, ridgePath, nexp);

save(strcat('Ridge-residuals-results-',fitness_file))
