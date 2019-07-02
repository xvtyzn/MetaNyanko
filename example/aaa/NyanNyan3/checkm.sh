#!/bin/sh
#$ -S /bin/sh
# -cwd
# -l s_vmem=4G -l mem_req=4G
# -pe smp 1
source ~/.bash_profile
checkm lineage_wf -t 30 -x fasta output/ checkm_output