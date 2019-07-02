#!/bin/sh
#$ -S /bin/sh
# -cwd
# -l s_vmem=4G -l mem_req=4G
# -pe smp 1
source ~/.bash_profile
megahit -o output -t 60 -1 190624A_S1_L001_R1_001_clean.fq -2 190624A_S1_L001_R2_001_clean.fq