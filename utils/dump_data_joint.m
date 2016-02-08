function dump_data_joint(d, filetext)
%
%    this is a file to dump all results and data stored in the data .mat files
%

% write out the z coefficients
dorig     = fix_mut_miss_joint(d);
[dada, I] = sort(abs(dorig.zopt), 'descend');
J         = find(dada>1e-4);
I         = I(J); 

writetable(strcat('coeff-', filetext,'.txt'), ...
    [dorig.diagn(:,I)', dorig.zopt(I)], ...
    {}, {'mutation_1', 'mutation_2', 'regression_coeff'});

% write out the lamdiff values and the z scores
meandiff(dorig,[],[],strcat('lamdiff-', filetext,'.txt'));
close all;

% write out the processing details like data-file, snp-file, snp-processing etc.
f = fopen(strcat('details-', filetext,'.txt'),'w');
fprintf(f, 'snp data file:\n\t%s\\n\t%s\n',           ...
    d.source1.snp_data.source_file, d.source2.snp_data.source_file );
fprintf(f, 'snp mutation labels 1:\n%s\n',    sprintf('\t%s\n', d.source1.snp_data.mutation_labels{:}));
fprintf(f, 'snp mutations selected 1:\n%s\n', sprintf('\t%s\n', d.source1.snp_data.mutation_selected{:}));
fprintf(f, 'snp mutation labels 2:\n%s\n',    sprintf('\t%s\n', d.source2.snp_data.mutation_labels{:}));
fprintf(f, 'snp mutations selected 2:\n%s\n', sprintf('\t%s\n', d.source2.snp_data.mutation_selected{:}));

fprintf(f, 'count data file 1:\n\t%s\n', d.source1.count_data.fname);
fprintf(f, 'count data file 2:\n\t%s\n', d.source2.count_data.fname);

fprintf(f, 'count data file 1:\n\t%s\n', d.source1.count_data.fname);
fprintf(f, 'count data file 2:\n\t%s\n', d.source2.count_data.fname);


fprintf(f, 'count times 1:\n\t%s\n', num2str(d.source1.lamfit.count_times));
fprintf(f, 'count times 2:\n\t%s\n', num2str(d.source2.lamfit.count_times));

fprintf(f, 'fitness median 1:\n\t%f\n', d.source1.lam_median);
fprintf(f, 'fitness median 2:\n\t%f\n', d.source2.lam_median);

fprintf(f, 'l1 optimal selection shrinkage :\n\t%f\n', d.lamopt);


fclose(f);
