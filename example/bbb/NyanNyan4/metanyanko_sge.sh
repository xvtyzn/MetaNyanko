qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan4/bbduk.sh -N qc_NyanNyan4
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan4/bbmerge.sh -hold_jid qc_NyanNyan4 -N merge_NyanNyan4
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan4/megahit.sh -hold_jid qc_NyanNyan4 -N assembly_NyanNyan4
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan4/bbmap.sh -hold_jid assembly_NyanNyan4 -N mapping_NyanNyan4
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan4/maxbin.sh -hold_jid mapping_NyanNyan4 -N binning_NyanNyan4
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan4/metabat2.sh -hold_jid mapping_NyanNyan4 -N binning_NyanNyan4
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan4/metaphlan2.sh -hold_jid merge_NyanNyan4 -N metaphlan2_NyanNyan4
qsub /Users/ide/Documents/MetaNyanko/example//bbb/NyanNyan4/checkm.sh -hold_jid binning_NyanNyan4 -N binning_NyanNyan4
echo $PWD
