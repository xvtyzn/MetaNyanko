qsub -N qc_NyanNyan5 bbduk.sh
qsub -hold_jid qc_NyanNyan5 -N merge_NyanNyan5 bbmerge.sh
qsub -hold_jid qc_NyanNyan5 -N assembly_NyanNyan5 megahit.sh
qsub -hold_jid assembly_NyanNyan5 -N mapping_NyanNyan5 bbmap.sh
qsub -hold_jid mapping_NyanNyan5 -N binning_NyanNyan5 maxbin.sh
qsub -hold_jid mapping_NyanNyan5 -N binning_NyanNyan5 metabat2.sh
qsub -hold_jid merge_NyanNyan5 -N metaphlan2_NyanNyan5 metaphlan2.sh
qsub -hold_jid binning_NyanNyan5 -N checkm_NyanNyan5 checkm.sh
echo $PWD
