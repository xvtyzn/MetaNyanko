#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe smp 60
#$ -e log/
#$ -o log/
source ~/.bash_profile
runMetaBat.sh megahit/final.contigs.fa mapping/mapped.sort.bam