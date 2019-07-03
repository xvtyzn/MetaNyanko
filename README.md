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

### Software dependency
1. BBtools
2. megahit
3. metaphlan2
4. maxbin
5. metabat2
6. checkm
7. dfast

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
  -qs QUALITYSCORE, --qualityscore QUALITYSCORE
                        display a square of a given number
  -t THREAD, --thread THREAD
                        the number of threads in one jobscripts
  -m MEMORY, --memory MEMORY
                        the number of memory in one jobscripts
```

## Install

```

```

## Contribution

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[Keigo IDE](https://github.com/xvtyzn)
