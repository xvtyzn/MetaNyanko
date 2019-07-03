qsub bbduk.sh -N qc_NyanNyan2
qsub bbmerge.sh -hold_jid qc_NyanNyan2 -N merge_NyanNyan2
qsub megahit.sh -hold_jid qc_NyanNyan2 -N assembly_NyanNyan2
qsub bbmap.sh -hold_jid assembly_NyanNyan2 -N mapping_NyanNyan2
qsub maxbin.sh -hold_jid mapping_NyanNyan2 -N binning_NyanNyan2
qsub metabat2.sh -hold_jid mapping_NyanNyan2 -N binning_NyanNyan2
qsub metaphlan2.sh -hold_jid merge_NyanNyan2 -N metaphlan2_NyanNyan2
qsub checkm.sh -hold_jid binning_NyanNyan2 -N binning_NyanNyan2
echo $PWD
