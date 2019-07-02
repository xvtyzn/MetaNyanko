#!/bin/sh
#$ -S /bin/sh
# -cwd
# -l s_vmem=4G -l mem_req=4G
# -pe smp 1
source ~/.bash_profile
bbduk.sh in1=reads.fq in2=reads.fq out1=clean.fq in2=reads.fq qtrim=r trimq=10 minlen=100