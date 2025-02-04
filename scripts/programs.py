programs_list = ["bbduk", "bbmap", "bbmerge", "megahit", "metaphlan2", "humann2",
"checkm", "metabat2", "maxbin", "virsorter", "plasflow"]

program_dict = {
"bbduk": ["bbduk.sh", "in1=A.fq", "in2=B.fq", "out1=qc/clean1.fq", "out2=qc/clean2.fq",
            "qtrim=r", "trimq=10", "minlen=40", "threads=10"],
"bbmerge": ["bbmerge.sh", "in1=qc/clean1.fq", "in2=qc/clean2.fq", "out=qc/merged.fq",
            "outu1=qc/unmerged1.fq", "outu2=qc/unmerged2.fq"],
"megahit": ["megahit", "-o", "megahit", "-t", "10", "-1", "qc/clean1.fq", "-2", "qc/clean2.fq"],
"bbmap": ["bbmap.sh", "in1=qc/clean1.fq", "in2=qc/clean2.fq", "out=mapping/mapped.sam", "threads=10",
            "ref=megahit/final.contigs.fa", "covstats=mapping/sample.stats\n",
            "samtools", "sort", "-@", "10", "mapping/mapped.sam", ">", "mapping/mapped.sort.bam"],
"checkm": ["conda", "activate", "metanyanko\n",
            "checkm", "lineage_wf", "-t", "30", "-x", "fa", "metabat2/", "checkm"],
"metabat2": ["jgi_summarize_bam_contig_depths", "mapping/mapped.sort.bam", "--outputDepth", "mapping/depth.txt\n",
            "metabat2", "-i", "megahit/final.contigs.fa", "-a", "mapping/depth.txt", "-o", "metabat2/bins", "-t", "10"],
"maxbin": ["cut", "-f", "1,2", "mapping/sample.stats", ">", "maxbin/myabund",
            "\nrun_MaxBin.pl", "-contig", "megahit/final.contigs.fa", "-abund", "maxbin/myabund",
            "-out", "maxbin/maxbin", "-thread 10"],
"metaphlan2": ["conda", "activate", "metanyanko\n",
            "metaphlan2.py", "qc/merged.fq", "-o", "metaphlan2/all.txt", "--input_type", "fastq", "--nproc 10"],
"humann2": ["conda", "activate", "metanyanko\n",
            "humann2", "--input", "qc/merged.fq", "--output", "humann2", "--threads", "10"],
"virfinder": ["conda", "activate", "virFinder\n",
            "Rscripts virFinder.R"],
"virsorter": ["wrapper_phage_contigs_sorter_iPlant.pl", "-f", "megahit/final.contigs.fa", "--diamond", "--ncpu", "10"],
"plasflow": ["conda", "activate", "plasflow\n",
            "PlasFlow.py --input megahit/final.contigs.fa --output plasflow/final.contigs.fa.tsv --threshold 0.7"]
}
