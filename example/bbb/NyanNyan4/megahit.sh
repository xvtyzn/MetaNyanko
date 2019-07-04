#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe smp 10
#$ -e log/
#$ -o log/
source ~/.bash_profile
megahit -o megahit -t 10 -1 qc/clean1.fq -2 qc/clean2.fq