qsub -N qc_NyanNyan4 bbduk.sh
qsub -hold_jid qc_NyanNyan4 -N merge_NyanNyan4 bbmerge.sh
qsub -hold_jid qc_NyanNyan4 -N assembly_NyanNyan4 megahit.sh
qsub -hold_jid assembly_NyanNyan4 -N mapping_NyanNyan4 bbmap.sh
qsub -hold_jid mapping_NyanNyan4 -N binning_NyanNyan4 maxbin.sh
qsub -hold_jid mapping_NyanNyan4 -N binning_NyanNyan4 metabat2.sh
qsub -hold_jid binning_NyanNyan4 -N virFinder_NyanNyan4 virFinder.sh
qsub -hold_jid binning_NyanNyan4 -N plasflow_NyanNyan4 plasflow.sh
qsub -hold_jid merge_NyanNyan4 -N metaphlan2_NyanNyan4 metaphlan2.sh
qsub -hold_jid binning_NyanNyan4 -N checkm_NyanNyan4 checkm.sh
echo $PWD
