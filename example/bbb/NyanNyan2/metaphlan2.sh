#!/bin/sh
#$ -S /bin/sh
# -cwd
# -l s_vmem=8G -l mem_req=8G
# -pe smp 10
# -N metaphlan2_NyanNyan2
source ~/.bash_profile
metaphlan2.py qc/merged.fq -o metaphlan2/all.txt --input_type fastq --nproc 60