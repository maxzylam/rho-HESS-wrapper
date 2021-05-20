# rho-HESS-wrapper

## The following wrapper was written to allow scaling of local genetic correlation analyses that are reported in **Lam et al : Dissecting Biological Pathways of Psychopathology Using Cognitive Genomics**. <br><br> The wrapper works with rho-HESS version 0.5.4 and LDSC 1.0.1. We assume that users would have the respective rho-HESS and LDSC environment set up. We would highly recommend the use of Anaconda to set up the respective environments as described in the github repositories of the software indicated above. <br><br> Also, we would assume that users have the appropriate LD score files and genome partition files downloaded and stored in an easily accesible folder. (LD score files : https://github.com/bulik/ldsc, genome partition files : https://huwenboshi.github.io/hess/input_format/#genome-partition) <p> 

## **WRAPPER** 

In the current repository, there are two files that make up the rho-HESS wrapper. HESS_LOCAL_RG and HESS_wrapper_.sh. The primary user interface HESS_LOCAL_RG would reference scripts within HESS_wrapper_.sh. Available options within the user interface are as follows : <p>


```
# general options
-h or --help : call the helpscript 
--hesswrapperloc : path to the rho-HESS wrapper
--sumstats1 : filename of GWAS summary statistics 1
--sumstats2 : filename of GWAS summary statistics 2
--prefix1 : prefix of intermediate files for GWAS summary statistics 1
--prefix2 : prefix of intermediate files for GWAS summary statistics 2
--output : general output file name
--path2hess : path to rho-hess .py file
--hess_env : path to hess environmental dependencies
--path2ldsc : path to ldsc .py file
--ldsc_env : path to ldsc environmental dependencies
--path2ldscores : path to ld scores 
--bfile_dir : path to directory that contains the reference files
--partition_dir : path to directory that contains the partition files
--localout : output directory for rho-hess analysis

# The following options is applicable to GWAS summary statistics 1
--sum1snpcol : numeric variable - which column is the SNP? 
--sum1bpcol : numeric variable - which column is the base pair coordinate? 
--sum1chrcol : numeric variable - which column is the chromosome? 
--sum1a1col : numeric variable - which column is A1? 
--sum1a2col : numeric variable - which column is A2? 
--sum1zcol : numeric variable - which column is Z? 
--sum1pcol : numeric variable - which column is the P-value?
--sum1traittype : string (specify if the the trait is Binary or Quantitative)
--sum1ncasecol : numeric variable - which column indicate case sample size? 
--sum1nconcol : numeric variable - which column indicate control sample size?
--sum1ncol : numeric variable - which column indicate total sample size (Quantitative or only Neff available)

# The following ooptions is applicable to GWAS summary statistics 2
--sum2snpcol
--sum2bpcol   
--sum2chrcol
--sum2a1col
--sum2a2col
--sum2zcol
--sum2pcol
--sum2traittype
--sum2ncasecol
--sum2nconcol
--sum2ncol
```
