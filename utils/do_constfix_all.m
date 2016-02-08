clear all
load ../Data-2015-05-04/data_all/data_all_30C_2015_05_04.mat;
d.reg_data.y = 3*tanh(d.reg_data.y/3);
save ../Data-2015-05-04/data_all/data_all_tan_30C_2015_05_04.mat d;
figure; hist(d.reg_data.y);

clear all
load ../Data-2015-04-10/data_all/data_all_37C_2015_04_10.mat;
d.reg_data.y = 3*tanh(d.reg_data.y/3);
save ../Data-2015-04-10/data_all/data_all_tan_37C_2015_04_10.mat d;
figure; hist(d.reg_data.y);

clear all
load ../Data-2015-01-16/data_all/data_all_2015_01_16_skiplast.mat;
d.reg_data.y = 3*tanh(d.reg_data.y/3);
save ../Data-2015-01-16/data_all/data_all_tan_2015_01_16_skiplast.mat d;
figure; hist(d.reg_data.y);

clear all
load ../Data-2014-10-31/data_all/data_all_2014_10_31.mat;
d.reg_data.y = 3*tanh(d.reg_data.y/3);
save ../Data-2014-10-31/data_all/data_all_tan_2014_10_31.mat d;
figure; hist(d.reg_data.y);

%clear all
%
%load ../Data-2014-10-31/data_all/data_all_constfix_2014_10_31.mat;
%[zs, Is]   = sort(abs(d.reg_data.zsingle), 'descend');
%[zd, Id]   = sort(abs(d.reg_data.zopt), 'descend');
%diagn_new  = [ones(2,1)*d.reg_data.idx_ys(Is), d.reg_data.diagn(:,Id)];
%emp        = [ones(length(zs),1);zeros(length(zd),1)];
%A          = [emp, diagn_new', [d.reg_data.zsingle; d.reg_data.zopt]];
%[dummy, I] = sort(abs(A(:,end)), 'descend');
%A          = A(I,:);
%writetable('coeff-constfix-2014-10-31.txt', A, ...
%    {}, {'is-emp', 'mutation_1', 'mutation_2', 'regression_coeff'});
%
%
%clear all
%load ../Data-2015-01-16/data_all/data_all_constfix_2015_01_16_skiplast.mat;
%[zs, Is]   = sort(abs(d.reg_data.zsingle), 'descend');
%[zd, Id]   = sort(abs(d.reg_data.zopt), 'descend');
%diagn_new  = [ones(2,1)*d.reg_data.idx_ys(Is), d.reg_data.diagn(:,Id)];
%emp        = [ones(length(zs),1);zeros(length(zd),1)];
%A          = [emp, diagn_new', [d.reg_data.zsingle; d.reg_data.zopt]];
%[dummy, I] = sort(abs(A(:,end)), 'descend');
%A          = A(I,:);
%writetable('coeff-constfix-2015-01-16.txt', A, ...
%    {}, {'is-emp', 'mutation_1', 'mutation_2', 'regression_coeff'});
%
%clear all
%load ../Data-2015-04-10/data_all/data_all_constfix_37C_2015_04_10.mat;
%[zs, Is]   = sort(abs(d.reg_data.zsingle), 'descend');
%[zd, Id]   = sort(abs(d.reg_data.zopt), 'descend');
%diagn_new  = [ones(2,1)*d.reg_data.idx_ys(Is), d.reg_data.diagn(:,Id)];
%emp        = [ones(length(zs),1);zeros(length(zd),1)];
%A          = [emp, diagn_new', [d.reg_data.zsingle; d.reg_data.zopt]];
%[dummy, I] = sort(abs(A(:,end)), 'descend');
%A          = A(I,:);
%writetable('coeff-constfix-2015-04-10.txt', A, ...
%    {}, {'is-emp', 'mutation_1', 'mutation_2', 'regression_coeff'});
%    
%
%clear all
%load ../Data-2015-05-04/data_all/data_all_constfix_30C_2015_05_04.mat;
%[zs, Is]   = sort(abs(d.reg_data.zsingle), 'descend');
%[zd, Id]   = sort(abs(d.reg_data.zopt), 'descend');
%diagn_new  = [ones(2,1)*d.reg_data.idx_ys(Is), d.reg_data.diagn(:,Id)];
%emp        = [ones(length(zs),1);zeros(length(zd),1)];
%A          = [emp, diagn_new', [d.reg_data.zsingle; d.reg_data.zopt]];
%[dummy, I] = sort(abs(A(:,end)), 'descend');
%A          = A(I,:);
%writetable('coeff-constfix-2015-05-04.txt', A, ...
%    {}, {'is-emp', 'mutation_1', 'mutation_2', 'regression_coeff'});
    

%clear all
%load ../Data-2015-05-04/data_all/data_all_constfix_30C_2015_05_04.mat;
%r = load('../Data-2015-05-04/data_all/R-data-all-constfix-2015-05-04.mat');
%d.reg_data.lamopt = r.lamopt;
%d.reg_data.zopt   = r.zopt;
%save ../Data-2015-05-04/data_all/data_all_constfix_30C_2015_05_04.mat d;
%
%
%clear all
%load ../Data-2015-04-10/data_all/data_all_constfix_37C_2015_04_10.mat;
%r = load('../Data-2015-04-10/data_all/R-data-all-constfix-2015-04-10.mat');
%d.reg_data.lamopt = r.lamopt;
%d.reg_data.zopt   = r.zopt;
%save ../Data-2015-04-10/data_all/data_all_constfix_37C_2015_04_10.mat d;
%
%clear all
%load ../Data-2015-01-16/data_all/data_all_constfix_2015_01_16_skiplast.mat;
%r = load('../Data-2015-01-16/data_all/R-data-all-constfix-2015-01-16.mat');
%d.reg_data.lamopt = r.lamopt;
%d.reg_data.zopt   = r.zopt;
%save ../Data-2015-01-16/data_all/data_all_constfix_2015_01_16_skiplast.mat d;
%
%
%clear all
%load ../Data-2014-10-31/data_all/data_all_constfix_2014_10_31.mat;
%r = load('../Data-2014-10-31/data_all/R-data-all-constfix-2014-10-31.mat');
%d.reg_data.lamopt = r.lamopt;
%d.reg_data.zopt   = r.zopt;
%save ../Data-2014-10-31/data_all/data_all_constfix_2014_10_31.mat d;




%clear all
%load ../Data-2015-05-04/data_all/data_all_30C_2015_05_04.mat;
%d.reg_data = create_regdata_olga_refit(d.reg_data);
%save ../Data-2015-05-04/data_all/data_all_constfix_30C_2015_05_04.mat d;
%
%
%clear all
%load ../Data-2015-04-10/data_all/data_all_37C_2015_04_10.mat;
%d.reg_data = create_regdata_olga_refit(d.reg_data);
%save ../Data-2015-04-10/data_all/data_all_constfix_37C_2015_04_10.mat d;
%
%clear all
%load ../Data-2014-10-31/data_all/data_all_2014_10_31.mat;
%d.reg_data = create_regdata_olga_refit(d.reg_data);
%save ../Data-2014-10-31/data_all/data_all_constfix_2014_10_31.mat d;
%
%clear all
%load ../Data-2015-01-16/data_all/data_all_2015_01_16_skiplast.mat;
%d.reg_data = create_regdata_olga_refit(d.reg_data);
%save ../Data-2015-01-16/data_all/data_all_constfix_2015_01_16_skiplast.mat d;

