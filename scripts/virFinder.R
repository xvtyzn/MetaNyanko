#!/usr/bin/env Rscript

## (1) set the input fasta file name.
library(VirFinder)
inFaFile <- system.file("data", "megahit/final.contigs.fa", package="VirFinder")

## (2) prediction
predResult <- VF.pred(inFaFile)
predResult

#### (2.1) sort sequences by p-value in ascending order
predResult[order(predResult$pvalue),]

#### (2.2) estimate q-values (false discovery rates) based on p-values
predResult$qvalue <- VF.qvalue(predResult$pvalue)

#### (2.3) sort sequences by q-value in ascending order
predResult[order(predResult$qvalue),]

write.table(predResult, "virFinder/virFinder_results.txt", sep = ",", quote = FALSE, header = TRUE, row.names = FALSE)
