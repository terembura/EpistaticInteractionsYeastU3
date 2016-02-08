# log in to tom or jerry
# cd to /disk/scratch/mutants/optimisation
# run the first part of the demo file until the regression data is created and saved
# type command "longjob -28day -c ./runmut.sh"
# wait and check the log file to see all starts well
# log out and come back later to check upon things

nice -n 10 matlab13 -nodisplay -nosplash -r "runmut" > R-data_all_37Csmall_2015_04_10.mat.log

