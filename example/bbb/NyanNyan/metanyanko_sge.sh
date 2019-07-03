qsub -N qc_NyanNyan bbduk.sh
qsub -hold_jid qc_NyanNyan -N merge_NyanNyan bbmerge.sh
qsub -hold_jid qc_NyanNyan -N assembly_NyanNyan megahit.sh
qsub -hold_jid assembly_NyanNyan -N mapping_NyanNyan bbmap.sh
qsub -hold_jid mapping_NyanNyan -N binning_NyanNyan maxbin.sh
qsub -hold_jid mapping_NyanNyan -N binning_NyanNyan metabat2.sh
qsub -hold_jid merge_NyanNyan -N metaphlan2_NyanNyan metaphlan2.sh
qsub -hold_jid binning_NyanNyan -N checkm_NyanNyan checkm.sh
echo $PWD
