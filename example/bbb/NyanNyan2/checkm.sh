#!/bin/sh
#$ -S /bin/sh
# -cwd
# -l s_vmem=8G -l mem_req=8G
# -pe smp 10
# -N checkm_NyanNyan2
source ~/.bash_profile
checkm lineage_wf -t 30 -x fasta output/ checkm_output