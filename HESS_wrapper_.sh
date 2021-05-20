################################################
#### HESS wrapper 

    # The following scripts would carry out HESS local genetic correlations according to 
    # instructions found in https://huwenboshi.github.io/hess/


    function helpscript {
        echo "The following wrapper script will carry out steps that have been detailed in https://huwenboshi.github.io/hess/"
        echo ""
        echo "The wrapper could be carried out as follows
        
        ./HESS_wrapper_.sh --flag=[options]"
    }
################################################


################################################
### Add Parsers

    while [ "$1" != "" ];do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
            -h | --help)
                    helpscript
                    exit 1
                    ;;
            --sumstats1)
                    sumstats1=$VALUE 
                    ;;
            --sumstats2)
                    sumstats2=$VALUE
                    ;;
            --prefix1)
                    prefix1=$VALUE 
                    ;;
            --prefix2)
                    prefix2=$VALUE 
                    ;;
            --sum1snpcol)
                    sum1snpcol=$VALUE
                    ;;
            --sum1bpcol)   
                    sum1bpcol=$VALUE 
                    ;;
            --sum1chrcol)
                    sum1chrcol=$VALUE 
                    ;;
            --sum1a1col)
                    sum1a1col=$VALUE 
                    ;;
            --sum1a2col)
                    sum1a2col=$VALUE 
                    ;;
            --sum1zcol)
                    sum1zcol=$VALUE
                    ;;
            --sum1pcol)
                    sum1pcol=$VALUE 
                    ;;
            --sum1traittype)
                    sum1traittype=$VALUE
                    ;;
            --sum1ncasecol)
                    sum1ncasecol=$VALUE
                    ;;
            --sum1nconcol)
                    sum1nconcol=$VALUE
                    ;;
            --sum1ncol)
                    sum1ncol=$VALUE
                    ;;
            --sum2snpcol)
                    sum2snpcol=$VALUE
                    ;;
            --sum2bpcol)   
                    sum2bpcol=$VALUE 
                    ;;
            --sum2chrcol)
                    sum2chrcol=$VALUE 
                    ;;
            --sum2a1col)
                    sum2a1col=$VALUE 
                    ;;
            --sum2a2col)
                    sum2a2col=$VALUE 
                    ;;
            --sum2zcol)
                    sum2zcol=$VALUE
                    ;;
            --sum2pcol)
                    sum2pcol=$VALUE 
                    ;;
            --sum2traittype)
                    sum2traittype=$VALUE
                    ;;
            --sum2ncasecol)
                    sum2ncasecol=$VALUE
                    ;;
            --sum2nconcol)
                    sum2nconcol=$VALUE
                    ;;
            --sum2ncol)
                    sum2ncol=$VALUE
                    ;;
            --output)
                    output=$VALUE
                    ;;
            --path2hess)
                    path2hess=$VALUE
                    ;;
            --hess_env)
                    hess_env=$VALUE
                    ;;
            --path2ldsc)
                    path2ldsc=$VALUE
                    ;;
            --ldsc_env)
                    ldsc_env=$VALUE
                    ;;
            --path2ldscores)
                    path2ldscores=$VALUE
                    ;;
            --bfile_dir)
                    bfile_dir=$VALUE
                    ;;
            --partition_dir)
                    partition_dir=$VALUE
                    ;;
            --localout)
                    localout=$VALUE 
                    ;;
            --hessstep)
                    hessstep=$VALUE
                    ;;
            $)
                    echo "ERROR:unknown parameter \ "$PARAM\ ""
                    helpscript
            esac
            shift
    done
################################################

################################################
### Prepare HESS input files

    if [ "$hessstep" == "input" ]; then 
        
        # check what format files is in 

            # Initiate logger

                printf "\n##################################################\n##### HESS LOCAL GENETIC CORRELATIONS - \n##################################################\n" 2>&1 | tee $output.hess.log
                printf "\n\nHESS local rg and h2 initiated by\n\nAnalyst Initials : $(id -u -n) \n\nPipeline initiated on $(date)\n" 2>&1 | tee -a $output.hess.log
            #>>>>



            if [ ! -f "$sumstats1" ]; then 
                echo "I can't find sumstats1 - exiting"
                exit 1
            fi

            if [ ! -f "$sumstats2" ]; then 
                echo "I can't find sumstats2 - exiting"
                exit 1
            fi 

            # check if sumstats1 and susmtats2 are gzipped 

                gzipped1=$(echo $sumstats1 | grep gz | wc -l)

                    if [ "$gzipped1" -eq 1 ]; then 

                        echo "sumstats1 is gzipped....proceeding..."
                    
                    else 

                        gzip $sumstats1

                        sumstats1=$sumstats1.gz
                    fi 

                gzipped2=$(echo $sumstats2 | grep gz | wc -l)

                    if [ "$gzipped2" -eq 1 ]; then 

                        echo "sumstats2 is gzipped....proceeding..."
                    
                    else 

                        gzip $sumstats2

                        sumstats2=$sumstats2.gz
                    fi 

            sumstats_1=$(echo $sumstats1 | sed 's/.gz//g')
            sumstats_2=$(echo $sumstats2 | sed 's/.gz//g')

        # format file for HESS input 

            printf "\nProcessing HESS input sumstats\n\n" 2>&1 | tee -a $output.hess.log

            if [ "$sum1traittype" == "Quantitative" ]; then 

                printf "\nProcessing Sumstats 1 - Quantitative Trait\n\n" 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1snpcol" ]; then echo "sum1snpcol not specified"; exit 1; else echo "    --sum1snpcol=$sum1snpcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1chrcol" ]; then echo "sum1chrcol not specified"; exit 1; else echo "    --sum1chrcol=$sum1chrcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1bpcol" ]; then echo "sum1bpcol not specified"; exit 1; else echo "    --sum1bpcol=$sum1bpcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1a1col" ]; then echo "sum1a1col not specified"; exit 1; else echo "    --sum1a1col=$sum1a1col"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1a2col" ]; then echo "sum1a2col not specified"; exit 1; else echo "    --sum1a2col=$sum1a2col"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1zcol" ]; then echo "sum1zcol not specified"; exit 1; else echo "    --sum1zcol=$sum1zcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1pcol" ]; then echo "sum1pcol not specified"; exit 1; else echo "    --sum1pcol=$sum1pcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1ncol" ]; then echo "sum1ncol not specified"; exit 1; else echo "    --sum1ncol=$sum1ncol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1snpcol" ]; then echo "sum1snpcol not specified"; exit 1; else echo "    --sum1snpcol=$sum1snpcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1chrcol" ]; then echo "sum1chrcol not specified"; exit 1; else echo "    --sum1chrcol=$sum1chrcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1bpcol" ]; then echo "sum1bpcol not specified"; exit 1; else echo "    --sum1bpcol=$sum1bpcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1a1col" ]; then echo "sum1a1col not specified"; exit 1; else echo "    --sum1a1col=$sum1a1col"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1a2col" ]; then echo "sum1a2col not specified"; exit 1; else echo "    --sum1a2col=$sum1a2col"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1zcol" ]; then echo "sum1zcol not specified"; exit 1; else echo "    --sum1zcol=$sum1zcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1pcol" ]; then echo "sum1pcol not specified"; exit 1; else echo "    --sum1pcol=$sum1pcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1ncol" ]; then echo "sum1ncol not specified"; exit 1; else echo "    --sum1ncol=$sum1ncol"; fi 2>&1 | tee -a $output.hess.log

                    zcat $sumstats_1.gz | awk -v C1=$sum1snpcol -v C2=$sum1chrcol -v C3=$sum1bpcol -v C4=$sum1a1col -v C5=$sum1a2col -v C6=$sum1zcol -v C7=$sum1pcol -v C8=$sum1ncol '{print $C1, $C2, $C3, $C4, $C5, $C6, $C7, $C8}' | sed '1,1d' | sed '1 i\SNP CHR BP A1 A2 Z P N' > $prefix1.hess.input.txt
            fi 

            if [ "$sum2traittype" == "Quantitative" ]; then 

                printf "\nProcessing Sumstats 2 - Quantitatitve Trait\n\n" 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2snpcol" ]; then echo "sum2snpcol not specified"; exit 1; else echo "    --sum2snpcol=$sum2snpcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2chrcol" ]; then echo "sum2chrcol not specified"; exit 1; else echo "    --sum2chrcol=$sum2chrcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2bpcol" ]; then echo "sum2bpcol not specified"; exit 1; else echo "    --sum2bpcol=$sum2bpcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2a1col" ]; then echo "sum2a1col not specified"; exit 1; else echo "    --sum2a1col=$sum2a1col"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2a2col" ]; then echo "sum2a2col not specified"; exit 1; else echo "    --sum2a2col=$sum2a2col"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2zcol" ]; then echo "sum2zcol not specified"; exit 1; else echo "    --sum2zcol=$sum2zcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2pcol" ]; then echo "sum2pcol not specified"; exit 1; else echo "    --sum2pcol=$sum2pcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2ncol" ]; then echo "sum2ncol not specified"; exit 1; else echo "    --sum2ncol=$sum2ncol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2snpcol" ]; then echo "sum2snpcol not specified"; exit 1; else echo "    --sum2snpcol=$sum2snpcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2chrcol" ]; then echo "sum2chrcol not specified"; exit 1; else echo "    --sum2chrcol=$sum2chrcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2bpcol" ]; then echo "sum2bpcol not specified"; exit 1; else echo "    --sum2bpcol=$sum2bpcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2a1col" ]; then echo "sum2a1col not specified"; exit 1; else echo "    --sum2a1col=$sum2a1col"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2a2col" ]; then echo "sum2a2col not specified"; exit 1; else echo "    --sum2a2col=$sum2a2col"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2zcol" ]; then echo "sum2zcol not specified"; exit 1; else echo "    --sum2zcol=$sum2zcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2pcol" ]; then echo "sum2pcol not specified"; exit 1; else echo "    --sum2pcol=$sum2pcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2ncol" ]; then echo "sum2ncol not specified"; exit 1; else echo "    --sum2ncol=$sum2ncol"; fi 2>&1 | tee -a $output.hess.log


                    zcat $sumstats_2.gz | awk -v C1=$sum2snpcol -v C2=$sum2chrcol -v C3=$sum2bpcol -v C4=$sum2a1col -v C5=$sum2a2col -v C6=$sum2zcol -v C7=$sum2pcol -v C8=$sum2ncol '{print $C1, $C2, $C3, $C4, $C5, $C6, $C7, $C8}' | sed '1,1d' | sed '1 i\SNP CHR BP A1 A2 Z P N' > $prefix2.hess.input.txt
            fi 

            if [ "$sum1traittype" == "Binary" ]; then 

                printf "\nProcessing Sumstats 1 - Binary Trait\n\n" 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1snpcol" ]; then echo "sum1snpcol not specified"; exit 1; else echo "    --sum1snpcol=$sum1snpcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1chrcol" ]; then echo "sum1chrcol not specified"; exit 1; else echo "    --sum1chrcol=$sum1chrcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1bpcol" ]; then echo "sum1bpcol not specified"; exit 1; else echo "    --sum1bpcol=$sum1bpcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1a1col" ]; then echo "sum1a1col not specified"; exit 1; else echo "    --sum1a1col=$sum1a1col"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1a2col" ]; then echo "sum1a2col not specified"; exit 1; else echo "    --sum1a2col=$sum1a2col"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1zcol" ]; then echo "sum1zcol not specified"; exit 1; else echo "    --sum1zcol=$sum1zcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1pcol" ]; then echo "sum1pcol not specified"; exit 1; else echo "    --sum1pcol=$sum1pcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1ncol" ]; then echo "sum1ncol not specified"; exit 1; else echo "    --sum1ncol=$sum1ncol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1snpcol" ]; then echo "sum1snpcol not specified"; exit 1; else echo "    --sum1snpcol=$sum1snpcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1chrcol" ]; then echo "sum1chrcol not specified"; exit 1; else echo "    --sum1chrcol=$sum1chrcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1bpcol" ]; then echo "sum1bpcol not specified"; exit 1; else echo "    --sum1bpcol=$sum1bpcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1a1col" ]; then echo "sum1a1col not specified"; exit 1; else echo "    --sum1a1col=$sum1a1col"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1a2col" ]; then echo "sum1a2col not specified"; exit 1; else echo "    --sum1a2col=$sum1a2col"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1zcol" ]; then echo "sum1zcol not specified"; exit 1; else echo "    --sum1zcol=$sum1zcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1pcol" ]; then echo "sum1pcol not specified"; exit 1; else echo "    --sum1pcol=$sum1pcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1ncasecol" ]; then echo "sum1ncasecol not specified"; exit 1; else echo "    --sum1ncasecol=$sum1ncasecol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum1nconcol" ]; then echo "sum1nconcol not specified"; exit 1; else echo "    --sum1nconcol=$sum1nconcol"; fi 2>&1 | tee -a $output.hess.log

                    zcat $sumstats_1.gz | awk -v C1=$sum1snpcol -v C2=$sum1chrcol -v C3=$sum1bpcol -v C4=$sum1a1col -v C5=$sum1a2col -v C6=$sum1zcol -v C7=$sum1pcol -v C8=$sum1ncasecol -v C9=$sum1nconcol '{print $C1, $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C9}' | awk '{print $1,$2,$3,$4,$5,$6,$7,$8+$9}' | sed '1,1d' | sed '1 i\SNP CHR BP A1 A2 Z P N' > $prefix1.hess.input.txt
            fi 

            if [ "$sum2traittype" == "Binary" ]; then 

                printf "\nProcessing Sumstats 2 - Binary Trait\n\n" 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2snpcol" ]; then echo "sum2snpcol not specified"; exit 1; else echo "    --sum2snpcol=$sum2snpcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2chrcol" ]; then echo "sum2chrcol not specified"; exit 1; else echo "    --sum2chrcol=$sum2chrcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2bpcol" ]; then echo "sum2bpcol not specified"; exit 1; else echo "    --sum2bpcol=$sum2bpcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2a1col" ]; then echo "sum2a1col not specified"; exit 1; else echo "    --sum2a1col=$sum2a1col"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2a2col" ]; then echo "sum2a2col not specified"; exit 1; else echo "    --sum2a2col=$sum2a2col"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2zcol" ]; then echo "sum2zcol not specified"; exit 1; else echo "    --sum2zcol=$sum2zcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2pcol" ]; then echo "sum2pcol not specified"; exit 1; else echo "    --sum2pcol=$sum2pcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2ncol" ]; then echo "sum2ncol not specified"; exit 1; else echo "    --sum2ncol=$sum2ncol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2snpcol" ]; then echo "sum2snpcol not specified"; exit 1; else echo "    --sum2snpcol=$sum2snpcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2chrcol" ]; then echo "sum2chrcol not specified"; exit 1; else echo "    --sum2chrcol=$sum2chrcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2bpcol" ]; then echo "sum2bpcol not specified"; exit 1; else echo "    --sum2bpcol=$sum2bpcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2a1col" ]; then echo "sum2a1col not specified"; exit 1; else echo "    --sum2a1col=$sum2a1col"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2a2col" ]; then echo "sum2a2col not specified"; exit 1; else echo "    --sum2a2col=$sum2a2col"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2zcol" ]; then echo "sum2zcol not specified"; exit 1; else echo "    --sum2zcol=$sum2zcol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2ncasecol" ]; then echo "sum2ncasecol not specified"; exit 1; else echo "    --sum2ncasecol=$sum2ncasecol"; fi 2>&1 | tee -a $output.hess.log
                    if [ -z "$sum2nconcol" ]; then echo "sum2nconcol not specified"; exit 1; else echo "    --sum2nconcol=$sum2nconcol"; fi 2>&1 | tee -a $output.hess.log


                    zcat $sumstats_2.gz | awk -v C1=$sum2snpcol -v C2=$sum2chrcol -v C3=$sum2bpcol -v C4=$sum2a1col -v C5=$sum2a2col -v C6=$sum2zcol -v C7=$sum2pcol -v C8=$sum2ncasecol -v C9=$sum2nconcol '{print $C1, $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C9}' | awk '{print $1,$2,$3,$4,$5,$6,$7,$8+$9}' | sed '1,1d' | sed '1 i\SNP CHR BP A1 A2 Z P N' > $prefix2.hess.input.txt
            fi 
            
    fi

            var1=$prefix1.hess.input.txt
            var2=$prefix2.hess.input.txt

################################################

################################################
### Perform HESS Step 1 = extract eigen matrices

        # HESS step 1 - multithread

            if [ "$hessstep" == "1a" ]; then 
                
                # initiate HESS step 1
                
                mkdir $localout/non_zero_partitions

                printf "" > exec.$output.hess_step1a.sh
                

                for chrom in {1..22}
                    do
                            printf "\nRunning HESS step1 for the following Chromosomes\n===========================================================\n\nChromosomes "$chrom"\n\nSubmitting scripts for multicpu-multithread run....\n" 2>&1 | tee -a $output.hess.log

                            #echo "nohup $hess_env/python $path2hess/hess.py --local-rhog $localout/$var1 $localout/$var2 --chrom $chrom --bfile $bfile_dir/eur_chr"$chrom"_SNPmaf5 --partition $partition_dir/eur_chr"$chrom".bed --out $localout/step1 >/dev/null 2>&1 &" >> exec.$output.hess_step1a.sh

                            echo "nohup $hess_env/python $path2hess/hess.py --local-rhog $localout/$var1 $localout/$var2 --chrom $chrom --bfile $bfile_dir/eur_chr"$chrom"_SNPmaf5 --partition $partition_dir/eur_chr"$chrom".bed --out $localout/step1 >/dev/null 2>&1" >> exec.$output.hess_step1a.sh

                            #declare PIDstep1_"$chrom"=$(echo $!)
                done

                bash exec.$output.hess_step1a.sh

            fi 

            if [ "$hessstep" == "1b" ]; then 

                printf "" > exec.$output.hess_step1b.sh
                
                cat *.log | grep -w "0 SNPs" | tr ':' ' '  | awk '{print $6}' | sed 's/chr//g' > zerosnpsegments.list

                while read chrom
                    do 

                           echo "cat step1_chr"$chrom".log | grep -vw \"0 SNPs\" | grep locus | awk '{print \$6}' | tr ':' ' ' | tr '-' ' ' | sed '1 i\chr start stop' | tr ' ' '\t' > $localout/non_zero_partitions/non_zero_eur_hess_chr"$chrom".bed" >> exec.$output.hess_step1b.sh
                done < zerosnpsegments.list

                bash exec.$output.hess_step1b.sh
            
            fi           

            if [ "$hessstep" == "1c" ]; then 

                printf "" > exec.$output.hess_step1c.sh

                for chrom in {1..22}
                    do 

                        if [ -f $localout/non_zero_partitions/non_zero_eur_hess_chr"$chrom".bed ]; then 

                            #echo "nohup $hess_env/python $path2hess/hess.py --local-rhog $localout/$var1 $localout/$var2 --chrom $chrom --bfile $bfile_dir/eur_chr"$chrom"_SNPmaf5 --partition $localout/non_zero_partitions/non_zero_eur_hess_chr"$chrom".bed --out $localout/step1 >/dev/null 2>&1 &" >> exec.$output.hess_step1c.sh

                            echo "nohup $hess_env/python $path2hess/hess.py --local-rhog $localout/$var1 $localout/$var2 --chrom $chrom --bfile $bfile_dir/eur_chr"$chrom"_SNPmaf5 --partition $localout/non_zero_partitions/non_zero_eur_hess_chr"$chrom".bed --out $localout/step1 >/dev/null 2>&1" >> exec.$output.hess_step1c.sh
                            #echo "Re-running $chrom...."

                            #declare PIDstep1r_"$chrom"=$(echo $!)

                        else

                            echo "HESS Step 1 - chr $chrom complete" 2>&1 | tee -a $output.hess.log

                            printf "" > $output.hess.chr$chrom.step1.done

                        fi
                done

                bash exec.$output.hess_step1c.sh

            fi   

            if [ "$hessstep" == "1d" ]; then
                
                followuphess=$(cat *.log | grep -w "0 SNPs" | wc | awk '{print $1}')
                
                
                if [ "$followuphess" == 0 ]; then 

                    for chrom in {1..22}
                        do 
                            
                                echo "HESS Step 1 - chromoaome $chrom complete!" 2>&1 | tee -a $output.hess.log

                                printf "" > $output.hess.chr$chrom.step1.done
                    done

                fi

                printf "\n##################################################\n##### HESS STEP1 COMPLETE - \n##################################################\n" 2>&1 | tee -a  $output.hess.log
                printf "\n\nHESS STEP 1 estimation completed on $(date)\n" 2>&1 | tee -a $output.hess.log
            fi

################################################

################################################
### Perform HESS Step 2 = calculate heritability

    # Perform HESS step 2 if step 1 is complete

        if [ "$hessstep" == 2 ]; then 

                printf "\nRunning HESS step2 estimation for local heritability\n===========================================================\n\nSubmitting scripts for multicpu-multithread run....\n" 2>&1 | tee -a  $output.hess.log

                    $hess_env/python $path2hess/hess.py --prefix step1_trait1 --out step2_trait1  

                    $hess_env/python $path2hess/hess.py --prefix step1_trait2 --out step2_trait2 


                    printf "\nHESS Step 2 Trait 1 heritability - complete\041\041\n" 2>&1 | tee -a $output.hess.log

                    printf "\nHESS Step 2 Trait 2 heritability - complete\041\041\n" 2>&1 | tee -a $output.hess.log

        fi

################################################

################################################
### Calculate phenocor

    if [ "$hessstep" == 3 ]; then 
        printf "\nRunning HESS step3 estimation for local heritability\n===========================================================\n\nSubmitting scripts for multicpu-multithread run....\n" 2>&1 | tee -a  $output.hess.log
        
        # Munge sumstats for LDSC

            $ldsc_env/python $path2ldsc/munge_sumstats.py --sumstats $prefix1.hess.input.txt --info-min 0.3 --maf-min 0.005 --merge-alleles $path2ldscores/w_hm3.snplist --snp SNP --N-col N --a1 A1 --a2 A2 --p P --frq FRQ --signed-sumstats Z,0 --chunksize 500000 --out $prefix1.ldsc.munge 
            $ldsc_env/python $path2ldsc/munge_sumstats.py --sumstats $prefix2.hess.input.txt --info-min 0.3 --maf-min 0.005 --merge-alleles $path2ldscores/w_hm3.snplist --snp SNP --N-col N --a1 A1 --a2 A2 --p P --frq FRQ --signed-sumstats Z,0 --chunksize 500000 --out $prefix2.ldsc.munge 
        
        # Conducte global bivariate LDSC

            $ldsc_env/python $path2ldsc/ldsc.py --rg $prefix1.ldsc.munge.sumstats.gz,$prefix2.ldsc.munge.sumstats.gz --ref-ld-chr $path2ldscores/ --w-ld-chr $path2ldscores/ --print-cov --out $localout/$output.ldsc.bivar.rg
        
                globalrgresult=$localout/$output.ldsc.bivar.rg.log
                trait1samplesize=$(cat step2_trait1.log | grep sample | awk '{print int($9)}')
                trait2samplesize=$(cat step2_trait2.log | grep sample | awk '{print int($9)}')
                #sigma12=$(cat $globalrgresult | grep Intercept | sed -n '3,3p' | awk '{print $2}')

                    if [ "$trait1samplesize" -lt "$trait2samplesize" ]; then 

                        samplehat=$(echo $trait1samplesize)
                    else 

                        samplehat=$(echo $trait2samplesize)
                    fi 

                for i in {1..10}
                    do 
                        declare estNs_"$i"=$(echo $samplehat | awk -v j=$i '{print $1*j/10}')
                done     

                phenocor_0=$($hess_env/python  $path2hess/misc/estimate_phenocor.py --ldsc-log $globalrgresult --n1 $trait1samplesize --n2 $trait2samplesize --ns 1)
                phenocor_1=$($hess_env/python  $path2hess/misc/estimate_phenocor.py --ldsc-log $globalrgresult --n1 $trait1samplesize --n2 $trait2samplesize --ns $estNs_1)
                phenocor_2=$($hess_env/python  $path2hess/misc/estimate_phenocor.py --ldsc-log $globalrgresult --n1 $trait1samplesize --n2 $trait2samplesize --ns $estNs_2)
                phenocor_3=$($hess_env/python  $path2hess/misc/estimate_phenocor.py --ldsc-log $globalrgresult --n1 $trait1samplesize --n2 $trait2samplesize --ns $estNs_3)
                phenocor_4=$($hess_env/python  $path2hess/misc/estimate_phenocor.py --ldsc-log $globalrgresult --n1 $trait1samplesize --n2 $trait2samplesize --ns $estNs_4)
                phenocor_5=$($hess_env/python  $path2hess/misc/estimate_phenocor.py --ldsc-log $globalrgresult --n1 $trait1samplesize --n2 $trait2samplesize --ns $estNs_5)
                phenocor_6=$($hess_env/python  $path2hess/misc/estimate_phenocor.py --ldsc-log $globalrgresult --n1 $trait1samplesize --n2 $trait2samplesize --ns $estNs_6)
                phenocor_7=$($hess_env/python  $path2hess/misc/estimate_phenocor.py --ldsc-log $globalrgresult --n1 $trait1samplesize --n2 $trait2samplesize --ns $estNs_7)
                phenocor_8=$($hess_env/python  $path2hess/misc/estimate_phenocor.py --ldsc-log $globalrgresult --n1 $trait1samplesize --n2 $trait2samplesize --ns $estNs_8)
                phenocor_9=$($hess_env/python  $path2hess/misc/estimate_phenocor.py --ldsc-log $globalrgresult --n1 $trait1samplesize --n2 $trait2samplesize --ns $estNs_9)
                phenocor_10=$($hess_env/python  $path2hess/misc/estimate_phenocor.py --ldsc-log $globalrgresult --n1 $trait1samplesize --n2 $trait2samplesize --ns $estNs_10)

                echo "0 $estNs_1 $estNs_3  $estNs_3  $estNs_4  $estNs_5  $estNs_6  $estNs_7  $estNs_8  $estNs_9  $estNs_10" > $localout/phenocor.txt
                echo "$phenocor_0 $phenocor_1 $phenocor_2 $phenocor_3 $phenocor_4 $phenocor_5 $phenocor_6 $phenocor_7 $phenocor_8 $phenocor_9 $phenocor_10" >> $localout/phenocor.txt

                #if [ "$sampleoverlap" == 100 ];then 

                    phenocor10=$phenocor_10
                    estoverlapsample10=$estNs_10
                
                #elif [ "$sampleoverlap" == 50 ]; then 

                    phenocor5=$phenocor_5
                    estoverlapsample5=$estNs_5

                #elif [ "$sampleoverlap" == 0 ]; then 

                    phenocor0=$phenocor_0
                    estoverlapsample0=1
                
                #else 

                #    printf "\nPlease state the phenotype correlation to be entered into HESS\041\n"

                #fi
    

            
            # HESS correlations
            $hess_env/python $path2hess/hess.py --prefix step1 --local-hsqg-est step2_trait1.txt step2_trait2.txt --num-shared $estoverlapsample0 --pheno-cor $phenocor0 --out $localout/step3_0overlap   
            $hess_env/python $path2hess/hess.py --prefix step1 --local-hsqg-est step2_trait1.txt step2_trait2.txt --num-shared $estoverlapsample5 --pheno-cor $phenocor5 --out $localout/step3_50overlap 
            $hess_env/python $path2hess/hess.py --prefix step1 --local-hsqg-est step2_trait1.txt step2_trait2.txt --num-shared $estoverlapsample10 --pheno-cor $phenocor10 --out $localout/step3_100overlap

            #declare PIDstep3=$(echo $!)

            #wait -n $PIDstep3; 

                printf "\nHESS Step 3 - complete\041\041\n" 2>&1 | tee -a $output.hess.log

    fi