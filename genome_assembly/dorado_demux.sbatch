#!/bin/bash

## Script for demultiplexing with dorado
##
## Example usage:
## sbatch dorado_demux.sbatch

## General settings
#SBATCH -p nvidia-a100
#SBATCH --time=24:00:00
#SBATCH --mem=128GB
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH -J dorado_demux
#SBATCH --output=/scratch/Users/%u/data/slurmOut/slurm-%j.out
#SBATCH --error=/scratch/Users/%u/data/slurmErr/slurm-%j.err

pwd; hostname; date
echo "dorado version: "$(dorado --version)
echo $(date +"[%b %d %H:%M:%S] Running dorado demux...")

# make the output dir if it doesn't exist
mkdir -p calls_default_parameters

# run dorado
# default is to use all available GPUs (--device cuda:all)

dorado demux \
--output-dir calls_default_parameters \
--no-classify calls_default_parameters.bam \
--emit-fastq

echo $(date +"[%b %d %H:%M:%S] Done!")
