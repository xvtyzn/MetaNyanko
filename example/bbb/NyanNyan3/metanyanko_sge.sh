qsub bbduk.sh -N qc_NyanNyan3
qsub bbmerge.sh -hold_jid qc_NyanNyan3 -N merge_NyanNyan3
qsub megahit.sh -hold_jid qc_NyanNyan3 -N assembly_NyanNyan3
qsub bbmap.sh -hold_jid assembly_NyanNyan3 -N mapping_NyanNyan3
qsub maxbin.sh -hold_jid mapping_NyanNyan3 -N binning_NyanNyan3
qsub metabat2.sh -hold_jid mapping_NyanNyan3 -N binning_NyanNyan3
qsub metaphlan2.sh -hold_jid merge_NyanNyan3 -N metaphlan2_NyanNyan3
qsub checkm.sh -hold_jid binning_NyanNyan3 -N binning_NyanNyan3
echo $PWD
