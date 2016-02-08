function d = process_snp_file(fname, mutation_types)
%Desciption:
%    processes the snp files provided by Olga
%In:
%    fname           -- the name of the snp files
%    mutatiuon types -- the types of mutations to select, use [] for all
%Out
%    d.fileneme -- the used file
%    d.
%
%
%

A                  = readtable_string(fname);
d                  = doMatrix(A, mutation_types);
d.filename         = A.fname;   
d.processing_file  = 'process_snp_file';    