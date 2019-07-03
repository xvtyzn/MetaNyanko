qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan2/bbduk.sh -N qc_NyanNyan2
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan2/bbmerge.sh -hold_jid qc_NyanNyan2 -N merge_NyanNyan2
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan2/megahit.sh -hold_jid qc_NyanNyan2 -N assembly_NyanNyan2
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan2/bbmap.sh -hold_jid assembly_NyanNyan2 -N mapping_NyanNyan2
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan2/maxbin.sh -hold_jid mapping_NyanNyan2 -N binning_NyanNyan2
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan2/metabat2.sh -hold_jid mapping_NyanNyan2 -N binning_NyanNyan2
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan2/metaphlan2.sh -hold_jid merge_NyanNyan2 -N metaphlan2_NyanNyan2
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan2/checkm.sh -hold_jid binning_NyanNyan2 -N binning_NyanNyan2
echo $PWD
