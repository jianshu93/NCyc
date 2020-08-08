#!/bin/bash

#SBATCH --partition=ieg_128g,ieg_lm,ieg_plus,ieg_64g       ### Partition (like a queue in PBS)
#SBATCH --job-name=Haibei_wp_megahit  ### Job Name
#SBATCH -o jarray.%j.%N.out         ### File in which to store job output/error
#SBATCH -e jarray.%N.%j.err
#SBATCH --time=02-00:00:00          ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1                   ### Node count required for the job
#SBATCH --ntasks=1                  ### Nuber of tasks to be launched per Node
#SBATCH --cpus-per-task=24          ### Number of threads per task (OMP threads)
#SBATCH --mem=20G                   ### memory for each job
#SBATCH --mail-type=FAIL            ### When to send mail
#SBATCH --mail-user=jianshuzhao@yahoo.com ### mail to send
#SBATCH --get-user-env              ### Import your user environment setup
#SBATCH --requeue                   ### On failure, requeue for another try
#SBATCH --verbose                   ### Increase informational messages
#SBATCH --array=101,104,11,111,114,121,124,131,134,14,141,144,151,154,161,164,171,174,181,184,191,194,201,204,21,211,214,221,224,231,234,24,241,244,251,254,261,264,271,274,281,284,291,294,301,304,31,311,314,321,324,331,334,34,341,344,351,354,361,364,41,44,51,54,61,64,71,74,81,84,91,94



module purge

module load ncbi_blast/2.22.2
module load hmmer/3.0
module load mafft/7.245
module load perl/5.22.1

module load use.own
module load usearch11/11.0.667
module load diamond/0.9.31.132

source ~/.bashrc
conda init bash
conda activate base


name=WP${SLURM_ARRAY_TASK_ID}"0"
wd=/nv/hmicro1/jzhao399/scratch/02.trimmed_wp
output=/nv/hmicro1/jzhao399/scratch/11.Metaxa2_wp
cd /nv/hmicro1/jzhao399/scratch/02.trimmed_wp/${name}/
cp /nv/hmicro1/jzhao399/scratch/02.trimmed_wp/${name}.CoupledReads.fasta.gz ${wd}/${name}/
cp /nv/hmicro1/jzhao399/scratch/02.trimmed_wp/NCycProfiler.PL ${wd}/${name}/
cp -r /nv/hmicro1/jzhao399/scratch/02.trimmed_wp/data ${wd}/${name}/

rm ${wd}/${name}/*.diamond
perl /nv/hmicro1/jzhao399/scratch/02.trimmed_wp/${name}/NCycProfiler.PL -d /nv/hmicro1/jzhao399/scratch/02.trimmed_wp/${name} -m diamond -f fasta.gz -s nucl -si /nv/hmicro1/jzhao399/scratch/02.trimmed_wp/${name}/sample.txt -o /nv/hmicro1/jzhao399/scratch/02.trimmed_wp/${name}/${name}_N_annotation_diamond.txt
cp /nv/hmicro1/jzhao399/scratch/02.trimmed_wp/${name}/${name}_N_annotation_diamond.txt /nv/hmicro1/jzhao399/scratch/

