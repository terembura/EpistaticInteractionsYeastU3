function d = process_snp_file_extra(fname)
A                  = readtable_string(fname);
d                  = domatrixunq(A);
d.filename         = A.fname;   
d.processing_file  = 'process_snp_file_extra';    