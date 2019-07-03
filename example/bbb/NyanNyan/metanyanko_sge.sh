qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan/bbduk.sh -N qc_NyanNyan
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan/bbmerge.sh -hold_jid qc_NyanNyan -N merge_NyanNyan
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan/megahit.sh -hold_jid qc_NyanNyan -N assembly_NyanNyan
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan/bbmap.sh -hold_jid assembly_NyanNyan -N mapping_NyanNyan
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan/maxbin.sh -hold_jid mapping_NyanNyan -N binning_NyanNyan
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan/metabat2.sh -hold_jid mapping_NyanNyan -N binning_NyanNyan
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan/metaphlan2.sh -hold_jid merge_NyanNyan -N metaphlan2_NyanNyan
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan/checkm.sh -hold_jid binning_NyanNyan -N binning_NyanNyan
echo $PWD
