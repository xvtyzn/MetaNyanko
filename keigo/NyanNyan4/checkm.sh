#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=4G -l mem_req=4G
#$ -pe def_slot 1
#$ -e log/
#$ -o log/
source ~/.bash_profile
conda activate metanyanko
 checkm lineage_wf -t 30 -x fa metabat2/ checkm