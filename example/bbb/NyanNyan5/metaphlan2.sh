#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe def_slot 10
#$ -e log/
#$ -o log/
source ~/.bash_profile
source activate metanyanko
 metaphlan2.py qc/merged.fq -o metaphlan2/all.txt --input_type fastq --nproc 10