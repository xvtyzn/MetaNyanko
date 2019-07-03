#!/bin/sh
#$ -S /bin/sh
# -cwd
# -l s_vmem=8G -l mem_req=8G
# -pe smp 60

source ~/.bash_profile
cut -f 1,2 mapping/sample.stats > maxbin/myabund 
 run_MaxBin.pl -contig megahit/final.contigs.fa -abund maxbin/myabund -out maxbin -thread 60