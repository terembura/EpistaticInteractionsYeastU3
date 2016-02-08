function dump_data(d, filetext)
%
%    this is a file to dump all results and data stored in the data .mat files
%

% write out the lambda and count data fits
%colnames    = cell(1+length(d.lamfit.count_times),1);
%colnames{1} = 'barcodes';
%for j = 1:length(d.lamfit.count_times)
%    colnames{1+j} = num2str(d.lamfit.count_times(j));
%end
%
%writetable(strcat('count-', filetext,'.txt'), ...
%    d.lamfit.y, ...
%    d.lamfit.rownames, colnames);
%    
%writetable(strcat('count-fit-mean-', filetext,'.txt'), ...
%    d.lamfit.fit_mean, ...
%    d.lamfit.rownames, colnames);
%
%writetable(strcat('lam-', filetext,'.txt'), ...
%    [d.lamfit.lam_mean, d.lamfit.lam_std], ...
%    d.lamfit.rownames, {'barcode', 'lam_mean', 'lam_std'});

% write out the z coefficients
[dada, I]   = sort(abs(d.reg_data.zopt), 'descend');
diagn_srt   = d.reg_data.diagn(:,I);
zopt_srt    = d.reg_data.zopt(I);

  
fid = fopen(strcat('coeff-', filetext,'.txt'), 'w');
fprintf(fid, 'mut_1\tfrom_1\tto_1\tmut_2\tfrom_2\tto_2\tcoeff\n');
for j = 1:max(find(dada>0)),
    fprintf(fid, '%d\t%s\t%s\t%d\t%s\t%s\t%f\n', ...
        d.snp_data.find_site(diagn_srt(1,j)), d.snp_data.find_from{diagn_srt(1,j)}, d.snp_data.find_to{diagn_srt(1,j)},...
        d.snp_data.find_site(diagn_srt(2,j)), d.snp_data.find_from{diagn_srt(2,j)}, d.snp_data.find_to{diagn_srt(2,j)},...
        zopt_srt(j));
end    
fclose(fid);    

% write out the lamdiff values and the z scores
%meandiff(dorig,[],[],strcat('lamdiff-', filetext,'.txt'));
%close all;

% write out the processing details like data-file, snp-file, snp-processing etc.
f = fopen(strcat('details-', filetext,'.txt'),'w');
%fprintf(f, 'snp data file:\n\t%s\n',                  d.snp_data.source_file);
fprintf(f, 'snp data file:\n\t%s\n',                  d.snp_data.filename);
fprintf(f, 'count data file:\n\t%s\n',                d.count_data.fname);
fprintf(f, 'count times:\n\t%s\n',                    num2str(d.lamfit.count_times));
fprintf(f, 'fitness median:\n\t%f\n',                 d.lam_median);
fprintf(f, 'l1 optimal selection shrinkage:\n\t%f\n', d.reg_data.lamopt);
fclose(f);