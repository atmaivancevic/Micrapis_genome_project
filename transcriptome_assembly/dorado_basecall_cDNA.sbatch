#!/bin/bash

## Script for basecalling with dorado SUP and no trimming (for cDNA reads)
##
## Example usage:
## sbatch dorado_basecall_cDNA.sbatch

## General settings
#SBATCH -p nvidia-a100
#SBATCH --time=4-00:00:00
#SBATCH --mem=500GB
#SBATCH --cpus-per-task=64
#SBATCH --gres=gpu:4
#SBATCH -J dorado_sup_cDNA
#SBATCH --output=/scratch/Users/%u/data/slurmOut/slurm-%j.out
#SBATCH --error=/scratch/Users/%u/data/slurmErr/slurm-%j.err

# to test on a node first:
# srun --partition=nvidia-a100-40GB --gres=gpu:1 -c 16 --mem=40GB --pty bash

# to check which nodes are available:
# sinfo

pwd; hostname; date
echo "dorado version: "$(dorado --version)
echo $(date +"[%b %d %H:%M:%S] Running dorado basecaller...")

# run dorado
# default is to use all available GPUs (--device cuda:all)
dorado basecaller sup pod5/ --kit-name SQK-PCB111-24 --no-trim > calls_no_trim.bam

echo $(date +"[%b %d %H:%M:%S] Done!")
