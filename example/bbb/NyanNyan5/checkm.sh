#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe def_slot 10
#$ -e log/
#$ -o log/
source ~/.bash_profile
source activate metanyanko
 checkm lineage_wf -t 30 -x fa metabat2/ checkm