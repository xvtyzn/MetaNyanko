#!/bin/sh
#$ -S /bin/sh
# -cwd
# -l s_vmem=4G -l mem_req=4G
# -pe smp 1
source ~/.bash_profile
bbmap.sh in=reads.fq out=clean.fq qtrim=r trimq=10 minlen=100