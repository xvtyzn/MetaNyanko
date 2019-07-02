#!/bin/sh
#$ -S /bin/sh
# -cwd
# -l s_vmem=4G -l mem_req=4G
# -pe smp 1
source ~/.bash_profile
metaphlan2.py 190624A_S1_L001_merged.fq -o all.txt --input_type fastq --nproc 60