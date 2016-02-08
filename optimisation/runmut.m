function [r,lampath]=runmut(file, nexp)
% run cv on server

mypool = parpool(12);

load(file)
lampath = linspace(-1,log10(25),20);
r       = cvl1reg_pp(reg_data.y, reg_data.X, 10.^(lampath), nexp, file);
  


