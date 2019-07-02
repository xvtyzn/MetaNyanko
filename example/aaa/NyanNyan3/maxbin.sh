#!/bin/sh
#$ -S /bin/sh
# -cwd
# -l s_vmem=4G -l mem_req=4G
# -pe smp 1
source ~/.bash_profile
run_MaxBin.pl -contig final.contigs.fa -abund myabund -out output -thread 30