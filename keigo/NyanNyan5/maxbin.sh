#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=4G -l mem_req=4G
#$ -pe def_slot 1
#$ -e log/
#$ -o log/
source ~/.bash_profile
cut -f 1,2 mapping/sample.stats > maxbin/myabund 
run_MaxBin.pl -contig megahit/final.contigs.fa -abund maxbin/myabund -out maxbin/maxbin -thread 10