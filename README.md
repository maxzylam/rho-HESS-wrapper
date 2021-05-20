# rho-HESS-wrapper

The following wrapper was written to allow scaling of local genetic correlation analyses that are reported in **Lam et al : Dissecting Biological Pathways of Psychopathology Using Cognitive Genomics**. <br><br> The wrapper works with rho-HESS version 0.5.4 and LDSC 1.0.1. We assume that users would have the respective rho-HESS and LDSC environment set up. We would highly recommend the use of Anaconda to set up the respective environments as described in the github repositories of the software indicated above. <br><br> Also, we would assume that users have the appropriate LD score files and genome partition files downloaded and stored in an easily accesible folder. (LD score files : https://github.com/bulik/ldsc, genome partition files : https://huwenboshi.github.io/hess/input_format/#genome-partition) <p> 

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

An example of the usage is as follows : 

```
bash /home/mlm/bin/HESS_LOCAL_RG \
    --hesswrapperloc=/home/mlm/bin/ \
    --sumstats1=cognition_mtag.1000G.EUR.ref.SumstatsQC.AF_0.005.INFO_0.3.AFB_0.15.results.finalqc.txt.gz \
    --sumstats2=schizophrenia_pgc3.1000G.EUR.ref.SumstatsQC.AF_0.005.INFO_0.3.AFB_0.15.results.finalqc.txt.gz \
    --prefix1=cognition_mtag \
    --prefix2=schizophrenia_pgc3 \
    --sum1snpcol=4 \
    --sum1bpcol=7 \
    --sum1chrcol=6 \
    --sum1a1col=8 \
    --sum1a2col=9 \
    --sum1zcol=18 \
    --sum1pcol=16 \
    --sum1ncol=17 \
    --sum1traittype=Quantitative \
    --sum2snpcol=4 \
    --sum2bpcol=7 \
    --sum2chrcol=6 \
    --sum2a1col=8 \
    --sum2a2col=9 \
    --sum2zcol=19 \
    --sum2pcol=16 \
    --sum2ncasecol=17 \
    --sum2nconcol=18 \
    --sum2traittype=Binary \
    --output=cognition_mtag_schizophrenia_pgc3 \
    --path2hess=/home/mlm/bin/supergnova-dev-1/hess-0.5.4 \
    --hess_env=/home/mlm/bin/py-anaconda/anaconda2/envs/hess/bin \
    --path2ldsc=/home/mlm/bin/ldsc \
    --ldsc_env=/home/mlm/bin/py-anaconda/anaconda2/envs/ldsc/bin \
    --path2ldscores=/home/mlm/cognition-ext-disk-1/ldsc_reference_files/eur_w_ld_chr \
    --bfile_dir=/home/mlm/cognition-ext-disk-1/hess_reference_files/data/bfiles \
    --partition_dir=/home/mlm/cognition-ext-disk-1/hess_reference_files/data/partition/hess_phase3 \
    --localout=/home/mlm/cog-loc-rg-proj-1/sumstats-input-files-1/hess-loco-run-1/hess_test_data-1
```

The output of the the wrapper interface produces a series of helper scripts 

```
cognition_mtag_schizophrenia_pgc3.1a.step.sh
cognition_mtag_schizophrenia_pgc3.1b.step.sh
cognition_mtag_schizophrenia_pgc3.1c.step.sh
cognition_mtag_schizophrenia_pgc3.1d.step.sh
cognition_mtag_schizophrenia_pgc3.2.step.sh
cognition_mtag_schizophrenia_pgc3.3.step.sh
```

Each of the scripts should be run in succession based on the labeled steps. 1a > 1b > 1c > 1d > 2 > 3. Step 1 prepares the input files for rho-HESS analysis. Step 2 runs the heritability estimates for either phenotype. Step 3 runs both global and local bivariate genetic correlations. 