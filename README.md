MetaNyanko: Shotgun metagenomic analysis pipeline for SGE (In paticular, Shirokane supercomputer)
====

## Description
研究室およびbitbiome向けのショットガメタゲノムパイプラインです。基本的な機能は以下の通りです。

1. Quality Control (BBtools)
2. de novo assembly (megahit)
3. Compositional analysis (metaphlan2)
4. Binning (maxbin, metabat2, BBtools)
5. Quality check (checkm)

## Requirement
### python package dependency
このパイプラインは以下のソフトウェアに依存しています。

1. sys
2. os
3. pandas
4. argparse
5. subprocess

### Software dependency
1. BBtools (version > 38.22)
2. megahit (v1.1.3)
3. metaphlan2 (version 2.9.12)
4. maxbin (version 2.2.6)
5. metabat2 (version 2.12.1)
6. checkm ()

checkmとmetaphlan2についてはpython2.7依存のため、仮想環境を構築することを前提としました。
もし仮想環境を構築しないのであれば`scripts/programs.py`から`conda activate metanyanko`を消去してください。

## Usage

```
[MetaNyanko]python MetaNyanko.py -h                                                                                    11:06:03  ☁ master ☂⚡✭
usage: MetaNyanko.py -i input_table.tsv -o output_directory

description

optional arguments:

  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        input files table (tab-separated)
  -o OUTPUT, --output OUTPUT
                        output directory
  -v VERSION, --version VERSION
                        Verstion
  -t THREAD, --thread THREAD
                        the number of threads in one jobscripts
  -m MEMORY, --memory MEMORY
                        the number of memory in one jobscripts
```

inputフォーマットはqiime2のinput形式と同様です。以下の形式に従ってください。

|sample-id|absolute-path|direction|description|
|:--:|:---:|:---:|:---:|

## Install

```
git clone https://github.com/xvtyzn/MetaNyanko.git
conda install -c bioconda metabat2 maxbin bbtools
conda create -n metanyanko python=2.7
conda activate metanyanko
conda install -c bioconda checkm-genome metaphlan2
conda deactivate
```

## Contribution

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[Keigo IDE](https://github.com/xvtyzn)
