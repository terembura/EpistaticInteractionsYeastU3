disp('Data-2015-04-10');

clear all
load ../Data-2015-04-10/data_all/data_all_37C_2015_04_10.mat;
[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
save ../Data-2015-04-10/data_all/data_all_37C_2015_04_10.mat d;
clear all
load ../Data-2015-04-10/data_all/data_all_37C_2015_04_10_fix.mat;
[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
save ../Data-2015-04-10/data_all/data_all_37C_2015_04_10_fix.mat d;


clear all
load ../Data-2015-04-10/data_atcg/data_atcg_37C_2015_04_10.mat;
[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
save ../Data-2015-04-10/data_atcg/data_atcg_37C_2015_04_10.mat d;
clear all
load ../Data-2015-04-10/data_atcg/data_atcg_37C_2015_04_10_fix.mat;
[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
save ../Data-2015-04-10/data_atcg/data_atcg_37C_2015_04_10_fix.mat d;

clear all
load ../Data-2015-04-10/data_nodel/data_nodel_37C_2015_04_10.mat;
[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
save ../Data-2015-04-10/data_nodel/data_nodel_37C_2015_04_10.mat d;
clear all
load ../Data-2015-04-10/data_nodel/data_nodel_37C_2015_04_10_fix.mat;
[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
save ../Data-2015-04-10/data_nodel/data_nodel_37C_2015_04_10_fix.mat d;

clear all
load ../Data-2015-04-10/data_noins/data_noins_37C_2015_04_10.mat;
[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
save ../Data-2015-04-10/data_noins/data_noins_37C_2015_04_10.mat d;
clear all
load ../Data-2015-04-10/data_noins/data_noins_37C_2015_04_10_fix.mat;
[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
save ../Data-2015-04-10/data_noins/data_noins_37C_2015_04_10_fix.mat d;




%disp('Data-2015-01-16/data_all');
%
%clear all
%load ../Data-2015-01-16/data_all/data_all_2015_01_16_skiplast.mat;
%[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
%d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
%save ../Data-2015-01-16/data_all/data_all_2015_01_16_skiplast.mat d;
%clear all
%load ../Data-2015-01-16/data_all/data_all_2015_01_16_skiplast_fix.mat;
%[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
%d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
%save ../Data-2015-01-16/data_all/data_all_2015_01_16_skiplast_fix.mat d;
%
%clear all
%load ../Data-2015-01-16/data_atcg/data_atcg_2015_01_16_skiplast.mat;
%[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
%d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
%save ../Data-2015-01-16/data_atcg/data_atcg_2015_01_16_skiplast.mat d;
%clear all
%load ../Data-2015-01-16/data_atcg/data_atcg_2015_01_16_skiplast_fix.mat;
%[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
%d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
%save ../Data-2015-01-16/data_atcg/data_atcg_2015_01_16_skiplast_fix.mat d;
%
%clear all
%load ../Data-2015-01-16/data_nodel/data_nodel_2015_01_16_skiplast.mat;
%[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
%d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
%save ../Data-2015-01-16/data_nodel/data_nodel_2015_01_16_skiplast.mat d;
%clear all
%load ../Data-2015-01-16/data_nodel/data_nodel_2015_01_16_skiplast_fix.mat;
%[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
%d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
%save ../Data-2015-01-16/data_nodel/data_nodel_2015_01_16_skiplast_fix.mat d;
%
%clear all
%load ../Data-2015-01-16/data_noins/data_noins_2015_01_16_skiplast.mat;
%[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
%d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
%save ../Data-2015-01-16/data_noins/data_noins_2015_01_16_skiplast.mat d;
%clear all
%load ../Data-2015-01-16/data_noins/data_noins_2015_01_16_skiplast_fix.mat;
%[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
%d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
%save ../Data-2015-01-16/data_noins/data_noins_2015_01_16_skiplast_fix.mat d;




%disp('Data-2014-10-31/data_all');
%
%clear all
%load ../Data-2014-10-31/data_all/data_all_2014_10_31.mat;
%[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
%d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
%save ../Data-2014-10-31/data_all/data_all_2014_10_31.mat d;
%clear all
%load ../Data-2014-10-31/data_all/data_all_2014_10_31_fix.mat;
%[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
%d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
%save ../Data-2014-10-31/data_all/data_all_2014_10_31_fix.mat d;
%
%clear all
%load ../Data-2014-10-31/data_atcg/data_atcg_2014_10_31.mat;
%[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
%d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
%save ../Data-2014-10-31/data_atcg/data_atcg_2014_10_31.mat d;
%clear all
%load ../Data-2014-10-31/data_atcg/data_atcg_2014_10_31_fix.mat;
%[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
%d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
%save ../Data-2014-10-31/data_atcg/data_atcg_2014_10_31_fix.mat d;
%
%clear all
%load ../Data-2014-10-31/data_nodel/data_nodel_2014_10_31.mat;
%[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
%d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
%save ../Data-2014-10-31/data_nodel/data_nodel_2014_10_31.mat d;
%clear all
%load ../Data-2014-10-31/data_nodel/data_nodel_2014_10_31_fix.mat;
%[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
%d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
%save ../Data-2014-10-31/data_nodel/data_nodel_2014_10_31_fix.mat d;
%
%
%clear all
%load ../Data-2014-10-31/data_noins/data_noins_2014_10_31.mat;
%[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
%d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
%save ../Data-2014-10-31/data_noins/data_noins_2014_10_31.mat d;
%clear all
%load ../Data-2014-10-31/data_noins/data_noins_2014_10_31_fix.mat;
%[r1, I11, I12] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%[r2, I21, I22] = intersect(d.reg_data.rownames, d.lamfit.rownames);
%d.reg_data.ystd(I11) = d.lamfit.lam_std(I12);
%d.reg_data.ystd(I21) = d.lamfit.lam_std(I22);
%save ../Data-2014-10-31/data_noins/data_noins_2014_10_31_fix.mat d;



%disp('Data-joint/data_all');
%
%clear all
%load ../Data-joint/data_all/regdata_joint_all.mat;
%[r1, I11, I12] = intersect(d.rownames, d.source1.lamfit.rownames);
%[r2, I21, I22] = intersect(d.rownames, d.source2.lamfit.rownames);
%d.ystd(I11)    = d.source1.lamfit.lam_std(I12);
%d.ystd(I21)    = d.source2.lamfit.lam_std(I22);
%save ../Data-joint/data_all/regdata_joint_all.mat d;
%clear all
%load ../Data-joint/data_all/regdata_joint_all_fix.mat;
%[r1, I11, I12] = intersect(d.rownames, d.source1.lamfit.rownames);
%[r2, I21, I22] = intersect(d.rownames, d.source2.lamfit.rownames);
%d.ystd(I11)    = d.source1.lamfit.lam_std(I12);
%d.ystd(I21)    = d.source2.lamfit.lam_std(I22);
%save ../Data-joint/data_all/regdata_joint_all_fix.mat d;
%
%clear all
%load ../Data-joint/data_atcg/regdata_joint_atcg.mat;
%[r1, I11, I12] = intersect(d.rownames, d.source1.lamfit.rownames);
%[r2, I21, I22] = intersect(d.rownames, d.source2.lamfit.rownames);
%d.ystd(I11)      = d.source1.lamfit.lam_std(I12);
%d.ystd(I21)      = d.source2.lamfit.lam_std(I22);
%save ../Data-joint/data_atcg/regdata_joint_atcg.mat d;
%clear all
%load ../Data-joint/data_atcg/regdata_joint_atcg_fix.mat;
%[r1, I11, I12] = intersect(d.rownames, d.source1.lamfit.rownames);
%[r2, I21, I22] = intersect(d.rownames, d.source2.lamfit.rownames);
%d.ystd(I11)    = d.source1.lamfit.lam_std(I12);
%d.ystd(I21)    = d.source2.lamfit.lam_std(I22);
%save ../Data-joint/data_atcg/regdata_joint_atcg_fix.mat d;
%
%clear all
%load ../Data-joint/data_nodel/regdata_joint_nodel.mat;
%[r1, I11, I12] = intersect(d.rownames, d.source1.lamfit.rownames);
%[r2, I21, I22] = intersect(d.rownames, d.source2.lamfit.rownames);
%d.ystd(I11)    = d.source1.lamfit.lam_std(I12);
%d.ystd(I21)    = d.source2.lamfit.lam_std(I22);
%save ../Data-joint/data_nodel/regdata_joint_nodel.mat d;
%clear all
%load ../Data-joint/data_nodel/regdata_joint_nodel_fix.mat;
%[r1, I11, I12] = intersect(d.rownames, d.source1.lamfit.rownames);
%[r2, I21, I22] = intersect(d.rownames, d.source2.lamfit.rownames);
%d.ystd(I11)    = d.source1.lamfit.lam_std(I12);
%d.ystd(I21)    = d.source2.lamfit.lam_std(I22);
%save ../Data-joint/data_nodel/regdata_joint_nodel_fix.mat d;
%
%clear all
%load ../Data-joint/data_noins/regdata_joint_noins.mat;
%[r1, I11, I12] = intersect(d.rownames, d.source1.lamfit.rownames);
%[r2, I21, I22] = intersect(d.rownames, d.source2.lamfit.rownames);
%d.ystd(I11)    = d.source1.lamfit.lam_std(I12);
%d.ystd(I21)    = d.source2.lamfit.lam_std(I22);
%save ../Data-joint/data_noins/regdata_joint_noins.mat d;
%clear all
%load ../Data-joint/data_noins/regdata_joint_noins_fix.mat;
%[r1, I11, I12] = intersect(d.rownames, d.source1.lamfit.rownames);
%[r2, I21, I22] = intersect(d.rownames, d.source2.lamfit.rownames);
%d.ystd(I11)    = d.source1.lamfit.lam_std(I12);
%d.ystd(I21)    = d.source2.lamfit.lam_std(I22);
%save ../Data-joint/data_noins/regdata_joint_noins_fix.mat d;
