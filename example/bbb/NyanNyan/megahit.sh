#!/bin/sh
#$ -S /bin/sh
# -cwd
# -l s_vmem=8G -l mem_req=8G
# -pe smp 60
# -N megahit_NyanNyan
source ~/.bash_profile
megahit -o megahit -t 60 -1 qc/clean1.fq -2 qc/clean2.fq