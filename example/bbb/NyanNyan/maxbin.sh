#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe smp 0
#$ -e log/
#$ -o log/
source ~/.bash_profile
cut -f 1,2 mapping/sample.stats > maxbin/myabund 
run_MaxBin.pl -contig megahit/final.contigs.fa -abund maxbin/myabund -out maxbin/maxbin -thread 10