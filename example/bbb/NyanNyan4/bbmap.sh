#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe smp 60
#$ -e log/
#$ -o log/
source ~/.bash_profile
bbmap.sh in1=qc/clean1.fq in2=qc/clean2.fq out=mapping/mapped.sam ref=megahit/final.contigs.fa covstats=mapping/sample.stats
 samtools sort -@ 4 mapping/mapped.sam > mapping/mapped.sort.bam