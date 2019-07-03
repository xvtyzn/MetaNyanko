qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan3/bbduk.sh -N qc_NyanNyan3
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan3/bbmerge.sh -hold_jid qc_NyanNyan3 -N merge_NyanNyan3
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan3/megahit.sh -hold_jid qc_NyanNyan3 -N assembly_NyanNyan3
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan3/bbmap.sh -hold_jid assembly_NyanNyan3 -N mapping_NyanNyan3
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan3/maxbin.sh -hold_jid mapping_NyanNyan3 -N binning_NyanNyan3
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan3/metabat2.sh -hold_jid mapping_NyanNyan3 -N binning_NyanNyan3
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan3/metaphlan2.sh -hold_jid merge_NyanNyan3 -N metaphlan2_NyanNyan3
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan3/checkm.sh -hold_jid binning_NyanNyan3 -N binning_NyanNyan3
echo $PWD
