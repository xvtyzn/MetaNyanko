#!/bin/sh
#$ -S /bin/sh
# -cwd
# -l s_vmem=8G -l mem_req=8G
# -pe smp 60
# -N bbduk_NyanNyan3
source ~/.bash_profile
bbduk.sh in1=/Users/ide/Documents/MetaNyanko/Nyanko_R1.fastq in2=/Users/ide/Documents/MetaNyanko/Nyanko_R2.fastq out1=qc/clean1.fq out2=qc/clean2.fq qtrim=r trimq=10 minlen=40