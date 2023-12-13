# AnolisSims
This repository will contain scripts to simulate demographic scenarios in msprime. The scripts are associated with [Farleigh et al., 2023](https://onlinelibrary.wiley.com/doi/full/10.1111/mec.17170). See below for details on the files contained in this repository and please do not hesitate to reach out to Keaka Farleigh (farleik@miamioh.edu) if you have any questions or need any help. Please use the citation below if you use any of these scripts in your work. 

## MSprime
This folder contains the python script ([MSprime_sims.py](https://github.com/kfarleigh/AnolisSims/blob/main/MSprime/MSprime_sims.py)), that was used to run the msprime simulations; a R script ([Anolis_MSprime_combine.R](https://github.com/kfarleigh/AnolisSims/blob/main/MSprime/Anolis_MSprime_combine.R)), that processes output from the shell script, note that this script can be rund from the command line; a shell script ([Run_MSprime.sh](https://github.com/kfarleigh/AnolisSims/blob/main/MSprime/Run_MSprime.sh)), that runs the python script however many times you want and processes the output with the R script; and a slurm batch file ([Anolis_Ref_MSprime.txt](https://github.com/kfarleigh/AnolisSims/blob/main/MSprime/Anolis_Ref_MSprime.txt)) that runs everything as a batch job. 

## Citation
Farleigh, K., Ascanio, A., Farleigh, M. E., Schield, D. R., Card, D. C., Leal, M., Castoe, T. A., Jezkova, T., & Rodríguez-Robles, J. A. (2023). Signals of differential introgression in the genome of natural hybrids of Caribbean anoles. _Molecular Ecology_, 32, 6000–6017. https://doi.org/10.1111/mec.17170
