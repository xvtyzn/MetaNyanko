qsub -N qc_NyanNyan2 bbduk.sh
qsub -hold_jid qc_NyanNyan2 -N merge_NyanNyan2 bbmerge.sh
qsub -hold_jid qc_NyanNyan2 -N assembly_NyanNyan2 megahit.sh
qsub -hold_jid assembly_NyanNyan2 -N mapping_NyanNyan2 bbmap.sh
qsub -hold_jid mapping_NyanNyan2 -N binning_NyanNyan2 maxbin.sh
qsub -hold_jid mapping_NyanNyan2 -N binning_NyanNyan2 metabat2.sh
qsub -hold_jid merge_NyanNyan2 -N metaphlan2_NyanNyan2 metaphlan2.sh
qsub -hold_jid binning_NyanNyan2 -N checkm_NyanNyan2 checkm.sh
echo $PWD
