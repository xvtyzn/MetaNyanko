#!/usr/bin/env python

import sys
import os
import pandas as pd
import argparse
import subprocess

import scripts.programs as programs
import scripts.shell_qsub as sqsub

parser = argparse.ArgumentParser(prog='MetaNyanko.py',
            usage='MetaNyanko.py -i input_table.tsv -o output_directory',
            description='description',
            add_help=True)

parser.add_argument("-i", "--input", help="input files table (tab-separated)")
parser.add_argument("-o", "--output", help="output directory")
parser.add_argument('-v', '--version',default="v0.0",type=str,help="Verstion")
parser.add_argument("-qs" ,"--qualityscore", default=40,help="display a square of a given number", type=int)
parser.add_argument("-t" ,"--thread", default=1, help="the number of threads in one jobscripts", type=int)
parser.add_argument("-m" ,"--memory", default=4,help="the number of memory in one jobscripts", type=int)

args = parser.parse_args()

#################
# Program listとinput, threadsを引数に実行コマンドを返す関数
#################

"""
def command_str(prolist, input_sample, threads, sample_dataset):

   sample_info = sample_dataset[sample_dataset.sample-id == input_sample]
   if sample_info  &&:
      a
   else :
      b

   prostr = " ".join()

   return prostr
"""
#################
# Output directoryの作成
#################

def main():
   output_root = args.output

   assert os.path.exists(output_root) == False, '出力ディレクトリを変更してください'
   if os.path.exists(output_root) == False:
      os.mkdir(output_root)
   else:
      pass

   input_data = pd.read_csv(args.input)
   output_directory = input_data['sample-id']
   out_dir = set(output_directory.values.tolist())

   #assert "defaultsample" in out_dir, 'sample-idを変更してください。defaultsampleは許されません'

   dir_list = ["rawdata", "qc", "log", "metabat2", "mapping",
            "metaphlan2", "checkm", "dfast"] #megahitは出力時に作成するため意図的に除いています

   out2 =  list(map(lambda x: os.path.join(output_root,x), out_dir))

   for out in out2 :
      os.mkdir(out)
      for folder in dir_list:
         os.mkdir(os.path.join(out, folder))

#################
# qsub用のスクリプトの作成
#################

   programs_list = programs.programs_list  #scripts/progtrams.py

   threads_option = "#$ -pe smp " + str(args.thread)
   memory_option = "#$ -l s_vmem=" + str(args.memory) +  "G -l mem_req=" + str(args.memory) + "G"
   UGE_options = ["#!/bin/sh", "#$ -S /bin/sh", "#$ -cwd", memory_option, threads_option]

   for program in programs_list:
      for sample in out2:
         file_path = os.path.join(sample, program + '.sh')
         samplename = os.path.basename(sample)

#         elog_option = "#$ -e " + sample + "/log/"
#         slog_option = "#$ -o " + sample + "/log/"
         elog_option = "#$ -e log/"
         slog_option = "#$ -o log/"

         job_name = [program, samplename]
         run_commnad = programs.program_dict[program] #scripts/progtrams.py
         run_commnad_str = " ".join(run_commnad)
         if program == "bbduk":
            sample_mat = input_data[input_data['sample-id'] == samplename]
            sample_mat = sample_mat['absolute-path'].values.tolist()
            run_commnad_str = run_commnad_str.replace('A.fq', sample_mat[0])
            run_commnad_str = run_commnad_str.replace('B.fq', sample_mat[1])
         with open(file_path, 'w') as f:
            f.write("\n".join(UGE_options))
            f.write("\n")
            f.write(elog_option)
            f.write("\n")
            f.write(slog_option)
            #f.write("# -N " + "_".join(job_name))
            f.write("\n")
            f.write("source ~/.bash_profile")
            f.write("\n")
            f.write(run_commnad_str)

#################
# qsub実行用のスクリプト作成
#################

   qsub_list = sqsub.qsub_list   #scripts/shell_qsub.py

   for sample in out2:
      metanyanko_sge = os.path.join(sample, "metanyanko_sge.sh")
      samplename = os.path.basename(sample)
      with open(metanyanko_sge, 'w') as f:
         for qsub in qsub_list:
            str_qsub = " ".join(qsub)
            str_qsub2 = str_qsub.replace('defaultsample', samplename)
#            str_qsub3 = str_qsub2.replace('shellpath', sample)
            str_qsub3 = str_qsub2.replace('shellpath/', "")
            print(str_qsub3)
            f.write(str_qsub3)
            f.write("\n")

#################
# qsub
#################
   for sample in out2:
      pwd_dir = os.getcwd()
      os.chdir(sample)
#      metanyanko_sge = os.path.join(sample, "metanyanko_sge.sh")
      metanyanko_sge = "metanyanko_sge.sh"
      command = ["sh", metanyanko_sge]
      res = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
      sys.stdout.buffer.write(res.stdout)
      os.chdir(pwd_dir)


if __name__ == '__main__':
    main()
