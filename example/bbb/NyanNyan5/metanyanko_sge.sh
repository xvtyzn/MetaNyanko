qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan5/bbduk.sh -N qc_NyanNyan5
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan5/bbmerge.sh -hold_jid qc_NyanNyan5 -N merge_NyanNyan5
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan5/megahit.sh -hold_jid qc_NyanNyan5 -N assembly_NyanNyan5
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan5/bbmap.sh -hold_jid assembly_NyanNyan5 -N mapping_NyanNyan5
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan5/maxbin.sh -hold_jid mapping_NyanNyan5 -N binning_NyanNyan5
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan5/metabat2.sh -hold_jid mapping_NyanNyan5 -N binning_NyanNyan5
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan5/metaphlan2.sh -hold_jid merge_NyanNyan5 -N metaphlan2_NyanNyan5
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan5/checkm.sh -hold_jid binning_NyanNyan5 -N binning_NyanNyan5
echo $PWD
