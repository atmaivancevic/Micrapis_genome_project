#!/bin/bash

## Script for demultiplexing with dorado with no trimming (for cDNA reads)
##
## Example usage:
## sbatch dorado_demux_cDNA.sbatch

## General settings
#SBATCH -p nvidia-a100
#SBATCH --time=24:00:00
#SBATCH --mem=128GB
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH -J dorado_demux_cDNA
#SBATCH --output=/scratch/Users/%u/data/slurmOut/slurm-%j.out
#SBATCH --error=/scratch/Users/%u/data/slurmErr/slurm-%j.err

# to test on a node first:
# srun --partition=nvidia-a100 --gres=gpu:1 -c 16 --mem=40GB --pty bash

pwd; hostname; date
echo "dorado version: "$(dorado --version)
echo $(date +"[%b %d %H:%M:%S] Running dorado demux...")

# run dorado
# default is to use all available GPUs (--device cuda:all)
dorado demux --output-dir cDNA_ONT_untrimmed_reads --no-classify cDNA_ONT_reads.bam --emit-fastq --no-trim

echo $(date +"[%b %d %H:%M:%S] Done!")
