#!/usr/bin/env python

import sys
import os
import pandas as pd
import argparse
import subprocess

import scripts.programs as programs

parser = argparse.ArgumentParser(prog='MetaNyanko.py', # プログラム名
            usage='MetaNyanko.py -i input_table.tsv -o output_directory', # プログラムの利用方法
            description='description', # 引数のヘルプの前に表示
            add_help=True, # -h/–help オプションの追加)
            )

parser.add_argument("-i", "--input", help="input files table (tab-separated)")
parser.add_argument("-o", "--output", help="output directory")
parser.add_argument('-v', '--version',default="v0.0",type=str,help="Verstion")

parser.add_argument("-qs" ,"--qualityscore", default=40,help="display a square of a given number", type=int)
parser.add_argument("-t" ,"--thread", default=1, help="the number of threads in one jobscripts", type=int)
parser.add_argument("-m" ,"--memory", default=4,help="the number of memory in one jobscripts", type=int)

args = parser.parse_args()

#################
# Output directoryの作成
#################

def main():
   output_root = args.output

   if os.path.exists(output_root) == False:
      os.mkdir(output_root)
   else:
      pass

   input_data = pd.read_csv(args.input)
   output_directory = input_data['sample-id']

   out_dir = output_directory.values.tolist()
   out_dir = set(out_dir)

   dir_list = ["rawdata", "qc", "log", "megahit", "metabat2", "bowtie2",
            "metaphlan2", "checkm", "dfast"]

   out2 =  list(map(lambda x: os.path.join(output_root,x), out_dir))

   for out in out2 :
      os.mkdir(out)
      for folder in dir_list:
         os.mkdir(os.path.join(out, folder))

#################
# qsub用のスクリプトの作成
#################

   programs_list = ["bbduk", "bbmap", "megahit", "bowtie2", "metaphlan2",
   "checkm", "dfast", "metabat2", "maxbin"]

   threads_option = "# -pe smp " + str(args.thread)
   memory_option = "# -l s_vmem=" + str(args.memory) +  "G -l mem_req=" + str(args.memory) + "G"

   UGE_options = ["#!/bin/sh", "#$ -S /bin/sh", "# -cwd", memory_option, threads_option,
                  "source ~/.bash_profile"]

   for program in programs_list:
      for sample in out2:
         file_path = os.path.join(sample, program + '.sh')
#         run_commnad = "\n".join(programs.program_dict[program])
         run_commnad = programs.program_dict[program]
         with open(file_path, 'w') as f:
            f.write("\n".join(UGE_options))
            f.write("\n")
            f.write(run_commnad)

#################
# qsub実行用のスクリプト作成
#################

   qc = ["qsub", "bbduk.sh"]
   merge = ["qsub", "-hold_jid", "","bbmerge.sh"]
   assembly = ["qsub", "-hold_jid", "","megahit.sh"]
   mapping = ["qsub", "-hold_jid", "", "bbmap.sh"]
   maxbin = ["qsub", "maxbin.sh"]
   metabat2 = ["qsub", "metabat2.sh"]
   metaphlan2 = ["qsub", "metaphlan2.sh"]
   checkm = ["qsub", "checkm.sh"]
   dfast = ["qsub", "dfast.sh"]
   test = ["echo", "$PWD"]

   qsub_list = [qc, merge, assembly, mapping, maxbin, metabat2, metaphlan2, checkm,
               dfast, test]

   for sample in out2:
      metanyanko_sge = os.path.join(sample, "metanyanko_sge.sh")
      with open(metanyanko_sge, 'w') as f:
         for qsub in qsub_list:
            f.write(" ".join(qsub))
            f.write("\n")

#################
# qsub
#################

   command = ["sh", "metanyanko_sge.sh"]
   res = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
   sys.stdout.buffer.write(res.stdout)


if __name__ == '__main__':
    main()
