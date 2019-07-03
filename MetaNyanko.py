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
# qsub 実行のための関数
#################
# directory_list: 各directoryの情報が入ったリスト
# 出力: bash上でのqsub実行ファイルの実行

def qsub_run(sample_list):
   for sample in sample_list:
      pwd_dir = os.getcwd()
      os.chdir(sample)

      command = ["sh", "metanyanko_sge.sh"]
      res = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
      sys.stdout.buffer.write(res.stdout)

      os.chdir(pwd_dir)
   return None

#################
# Output directoryの作成
#################

def make_outputdir(output_dir, input_table, dir_list):
   output_root = output_dir

   assert os.path.exists(output_root) == False, '出力ディレクトリを変更してください'
   if os.path.exists(output_root) == False:
      os.mkdir(output_root)
   else:
      pass

   input_data = pd.read_csv(input_table)
   output_directory = input_data['sample-id']
   out_dir = set(output_directory.values.tolist())

   #assert "defaultsample" in out_dir, 'sample-idを変更してください。defaultsampleは許されません'

   dir_list = ["rawdata", "qc", "log", "metabat2", "mapping",
               "metaphlan2", "checkm", "dfast", "maxbin"] #megahitは出力時に作成するため意図的に除いています

   out2 =  list(map(lambda x: os.path.join(output_root,x), out_dir))

   for out in out2 :
      os.mkdir(out)
      for folder in dir_list:
         os.mkdir(os.path.join(out, folder))

   return out2, input_data

#################
# qsub用のスクリプトの作成
#################

def make_jobscripts(programs_list, programs_dict, threads, memory, dir_list,
                     data_table):
   plist = programs_list  #scripts/progtrams.py

   threads_option = "#$ -pe smp " + str(threads)
   memory_option = "#$ -l s_vmem=" + str(memory) +  "G -l mem_req=" + str(memory) + "G"
   UGE_options = ["#!/bin/sh", "#$ -S /bin/sh", "#$ -cwd", memory_option, threads_option]

   for program in plist:
      for sample in dir_list:
         file_path = os.path.join(sample, program + '.sh')
         samplename = os.path.basename(sample)

         elog_option = "#$ -e log/"
         slog_option = "#$ -o log/"

         job_name = [program, samplename]
         run_commnad = programs_dict[program] #scripts/progtrams.py
         run_commnad_str = " ".join(run_commnad)
         if program == "bbduk":
            sample_mat = data_table[data_table['sample-id'] == samplename]
            sample_mat = sample_mat['absolute-path'].values.tolist()
            run_commnad_str = run_commnad_str.replace('A.fq', sample_mat[0])
            run_commnad_str = run_commnad_str.replace('B.fq', sample_mat[1])
            
            program_all = "\n".join(UGE_options) + "\n" + elog_option + "\n" +
                        slog_option + "\n" + "source ~/.bash_profile" + "\n" +
                        run_commnad_str

         with open(file_path, 'w') as f:
            f.write(program_all)
   return None

#################
# qsub実行用のスクリプト作成
#################

def make_shellscripts(run_list, dir_list):
   qsub_list = run_list   #scripts/shell_qsub.py

   for sample in dir_list:
      metanyanko_sge = os.path.join(sample, "metanyanko_sge.sh")
      samplename = os.path.basename(sample)
      with open(metanyanko_sge, 'w') as f:
         for qsub in qsub_list:
            str_qsub = " ".join(qsub)
            str_qsub2 = str_qsub.replace('defaultsample', samplename)
            str_qsub3 = str_qsub2.replace('shellpath/', "")
            print(str_qsub3)
            f.write(str_qsub3)
            f.write("\n")
   return None

def main():
   dir_list = ["rawdata", "qc", "log", "metabat2", "mapping",
               "metaphlan2", "checkm", "dfast", "maxbin"] #megahitは出力時に作成するため意図的に除いています

   out1 = make_outputdir(args.output, args.input, dir_list)
   out2 = out1[0]
   input_data = out1[1]

   make_jobscripts(programs.programs_list, programs.program_dict, args.thread,
                  args.memory, out2, input_data)
   make_shellscripts(sqsub.qsub_list, out2)
   qsub_run(out2) #qsubのスクリプト実行

if __name__ == '__main__':
    main()
