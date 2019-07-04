#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe smp 10
#$ -e log/
#$ -o log/
source ~/.bash_profile
jgi_summarize_bam_contig_depths mapping/mapped.sort.bam --outputDepth mapping/depth.txt
 metabat2 -i megahit/final.contigs.fa -a mapping/depth.txt -o metabat2/bins -t 10