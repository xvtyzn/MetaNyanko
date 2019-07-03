

qsub "${INS_DIR}"/src/checkm.sh
qsub -hold_jid annot_pipe "${INS_DIR}"/src/AliTV.sh
qsub -hold_jid annot_pipe "${INS_DIR}"/src/alignment_16S.sh
qsub -hold_jid annot_pipe "${INS_DIR}"/src/orthofinder.sh
qsub -hold_jid Orthofinder "${INS_DIR}"/src/phylogeny.sh
qsub -hold_jid Orthofinder "${INS_DIR}"/src/interproscan.sh
