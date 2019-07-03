#!/bin/sh
#$ -S /bin/sh
# -cwd
# -l s_vmem=8G -l mem_req=8G
# -pe smp 60
# -N metabat2_NyanNyan
source ~/.bash_profile
runMetaBat.sh assembly.fasta sample1.bam