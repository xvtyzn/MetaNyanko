qsub bbduk.sh -N qc_NyanNyan
qsub bbmerge.sh -hold_jid qc_NyanNyan -N merge_NyanNyan
qsub megahit.sh -hold_jid qc_NyanNyan -N assembly_NyanNyan
qsub bbmap.sh -hold_jid assembly_NyanNyan -N mapping_NyanNyan
qsub maxbin.sh -hold_jid mapping_NyanNyan -N binning_NyanNyan
qsub metabat2.sh -hold_jid mapping_NyanNyan -N binning_NyanNyan
qsub metaphlan2.sh -hold_jid merge_NyanNyan -N metaphlan2_NyanNyan
qsub checkm.sh -hold_jid binning_NyanNyan -N binning_NyanNyan
echo $PWD
