qsub -N qc_NyanNyan3 bbduk.sh
qsub -hold_jid qc_NyanNyan3 -N merge_NyanNyan3 bbmerge.sh
qsub -hold_jid qc_NyanNyan3 -N assembly_NyanNyan3 megahit.sh
qsub -hold_jid assembly_NyanNyan3 -N mapping_NyanNyan3 bbmap.sh
qsub -hold_jid mapping_NyanNyan3 -N binning_NyanNyan3 maxbin.sh
qsub -hold_jid mapping_NyanNyan3 -N binning_NyanNyan3 metabat2.sh
qsub -hold_jid binning_NyanNyan3 -N virFinder_NyanNyan3 virFinder.sh
qsub -hold_jid binning_NyanNyan3 -N plasflow_NyanNyan3 plasflow.sh
qsub -hold_jid merge_NyanNyan3 -N metaphlan2_NyanNyan3 metaphlan2.sh
qsub -hold_jid binning_NyanNyan3 -N checkm_NyanNyan3 checkm.sh
echo $PWD
