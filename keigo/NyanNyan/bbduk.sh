#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=4G -l mem_req=4G
#$ -pe def_slot 1
#$ -e log/
#$ -o log/
source ~/.bash_profile
bbduk.sh in1=/home/ide/bitbiome/example/out/190624A_S1_L001_R1_001.part_001.fastq in2=/home/ide/bitbiome/example/out/190624A_S1_L001_R2_001.part_001.fastq out1=qc/clean1.fq out2=qc/clean2.fq qtrim=r trimq=10 minlen=40 threads=10