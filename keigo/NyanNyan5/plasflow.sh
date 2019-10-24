#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=4G -l mem_req=4G
#$ -pe def_slot 1
#$ -e log/
#$ -o log/
source ~/.bash_profile
conda activate plasflow
 PlasFlow.py --input megahit/final.contigs.fa --output plasflow/final.contigs.fa.tsv --threshold 0.7