#!/usr/bin/env python

import sys
import os
import pandas as pd
import argparse
import subprocess

import scripts.programs as programs
import scripts.shell_qsub as sqsub
#import scripts.version as version

parser = argparse.ArgumentParser(prog='MetaNyanko.py',
            usage='MetaNyanko.py -i input_table.tsv -o output_directory',
            description='description',
            add_help=True)

parser.add_argument('-i', '--input', help='input files table (tab-separated like qiime2 input table)')
parser.add_argument('-o', '--output', help='output directory path')
parser.add_argument("-v", '--version',default="v0.0",type=str,help="show this software verstion")
parser.add_argument("-t" ,"--thread", default=1, help="the number of threads in one jobscripts (default = 1)", type=int)
parser.add_argument("-m" ,"--memory", default=4,help="the number of memory in one jobscripts (default = 4) ", type=int)
parser.add_argument("-ct" ,"--clustertype", default="UGE",help="supercomputer type (UGE or SGE)", choices = ["UGE", "SGE"])
parser.add_argument("-j" ,"--justcreate", default=0, help="(default = TRUE)", type=bool)   #TRUE or FLASEの指定にした方が良い
#option指定でプログラムファイルを与えるとその中のプログラムを実行してくれるような形になっているとなおよし。

args = parser.parse_args()

#pythonはシングルクォートがデフォルト


#################
# qsub 実行のための関数
#################
# directory_list: 各directoryの情報が入ったリスト
# 出力: bash上でのqsub実行ファイルの実行

def qsub_run(sample_list):
   for sample in sample_list:
      pwd_dir = os.getcwd()
      os.chdir(sample)

      create_qsubshell = ["sh", "metanyanko_sge.sh"]
      std_cqs = subprocess.run(create_qsubshell, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
      sys.stdout.buffer.write(std_cqs.stdout)

      os.chdir(pwd_dir)
   return None

#################
# Output directoryの作成
#################
# output_dir: outputで指定したdirectory
# input_table: inputで指定したcsvのpath
# dir_list: output directory下に作成するdirectoryリスト
# 出力: output_dirに各directoryを付与したpath, input_tableのpandas object

def make_outputdir(output_dir, input_table, dir_list):
   output_root = output_dir

   assert os.path.exists(output_root) == False, '出力ディレクトリを変更してください'
   if !os.path.exists(output_root):
      os.mkdir(output_root)

   input_data = pd.read_csv(input_table)
   output_directory = input_data["sample-id"]
   out_dir = set(output_directory.values.tolist())

   #assert "defaultsample" in out_dir, 'sample-idを変更してください。defaultsampleは許されません'

   abpath_out =  list(map(lambda x: os.path.join(output_root,x), out_dir))

   for out in abpath_out  :
      os.mkdir(out)
      for folder in dir_list:
         os.mkdir(os.path.join(out, folder))

   return abpath_out, input_data

#################
# qsub用のスクリプトの作成
#################

def make_jobscripts(programs_list, programs_dict, threads, memory, dir_list, data_table, st):
   plist = programs_list  #scripts/progtrams.py

   memory_str = str(memory)
   threads_str = str(threads)

   if st == "UGE":
      threads_option = "#$ -pe def_slot {}".format(threads_str)
   elif st == "SGE":
      threads_option = "#$ -pe smp {}".format(threads_str)


# format関数
   memory_option = "#$ -l s_vmem={1}G -l mem_req={2}G".format(memory_str ,memory_str)
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

            run_commnad_str = run_commnad_str.replace('A.fq', sample_mat[0])  #R1デフォルトがA.fq
            run_commnad_str = run_commnad_str.replace('B.fq', sample_mat[1])  #R2デフォルトがB.fq

            program_all = "\n".join(UGE_options) + "\n" + elog_option + "\n" + \
                        slog_option + "\n" + "source ~/.bash_profile" + "\n" + \
                        run_commnad_str
         else:
            program_all = "\n".join(UGE_options) + "\n" + elog_option + "\n" + \
                        slog_option + "\n" + "source ~/.bash_profile" + "\n" + \
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
   #megahitは出力時に作成するため意図的に除いています
   dir_list = ["rawdata", "qc", "log", "metabat2", "mapping",
               "metaphlan2", "checkm", "dfast", "maxbin"]

   #シンボリックシンクを貼ってしまうというのが良いのかもしれない

   out1 = make_outputdir(args.output, args.input, dir_list)
   output_path = out1[0]
   sampledata_table = out1[1]

   make_jobscripts(programs.programs_list, programs.program_dict, args.thread,
                  args.memory, output_path, sampledata_table, args.clustertype)
   make_shellscripts(sqsub.qsub_list, output_path)

   if args.justcreate == 0:
      qsub_run(output_path) #qsubのスクリプト実行
   elif args.justcreate == 1:
      pass

if __name__ == '__main__':
    main()
