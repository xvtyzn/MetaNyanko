program_dict = {
"bbduk": ["bbduk.sh in1=reads.fq in2=reads.fq out1=clean.fq in2=reads.fq qtrim=r trimq=10 minlen=100"],
"bbmerge": [],
"bbmap": ["bbmap.sh in=reads.fq out=clean.fq qtrim=r trimq=10 minlen=100"],
"megahit": "megahit -o output -t 60 -1 190624A_S1_L001_R1_001_clean.fq -2 190624A_S1_L001_R2_001_clean.fq",
"metaphlan2": "metaphlan2.py 190624A_S1_L001_merged.fq -o all.txt --input_type fastq --nproc 60",
"checkm": "checkm lineage_wf -t 30 -x fasta output/ checkm_output",
"dfast":"",
"metabat2":"",
"bowtie2":"",
"maxbin": "run_MaxBin.pl -contig final.contigs.fa -abund myabund -out output -thread 30"
}
