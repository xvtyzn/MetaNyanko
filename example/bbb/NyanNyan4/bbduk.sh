#!/bin/sh
#$ -S /bin/sh
# -cwd
# -l s_vmem=8G -l mem_req=8G
# -pe smp 60

source ~/.bash_profile
bbduk.sh in1=/home/ide/bitbiome/example/out/190624A_S1_L001_R1_001.part_004.fastq in2=/home/ide/bitbiome/example/out/190624A_S1_L001_R2_001.part_004.fastq out1=qc/clean1.fq out2=qc/clean2.fq qtrim=r trimq=10 minlen=40