#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe def_slot 10
#$ -e log/
#$ -o log/
source ~/.bash_profile
bbmap.sh in1=qc/clean1.fq in2=qc/clean2.fq out=mapping/mapped.sam threads=10 ref=megahit/final.contigs.fa covstats=mapping/sample.stats
 samtools sort -@ 10 mapping/mapped.sam > mapping/mapped.sort.bam