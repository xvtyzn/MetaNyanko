#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=4G -l mem_req=4G
#$ -pe def_slot 1
#$ -e log/
#$ -o log/
source ~/.bash_profile
bbmerge.sh in1=qc/clean1.fq in2=qc/clean2.fq out=qc/merged.fq outu1=qc/unmerged1.fq outu2=qc/unmerged2.fq