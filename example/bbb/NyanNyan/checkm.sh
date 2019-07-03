#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe smp 60
#$ -e /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan/log/
#$ -o/Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan/log/
source ~/.bash_profile
checkm lineage_wf -t 30 -x fasta output/ checkm_output