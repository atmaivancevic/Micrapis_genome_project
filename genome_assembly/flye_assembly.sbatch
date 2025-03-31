#!/bin/bash

## Script for running flye
##
## Example usage:
## inDir=dorado_corrected outDir=flye_assembly genomeSize=1.5g sbatch --array 0-0 flye.sbatch

# General settings
#SBATCH -p long
#SBATCH -N 1
#SBATCH -c 32
#SBATCH --time=100:00:00
#SBATCH --mem=120GB

# Job name and output
#SBATCH -J flye_nanohq
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%j.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%j.err

# Activate conda base environment
source ~/miniconda3/bin/activate

# Activate flye-specific conda environment
conda activate flye_env

pwd; hostname; date

echo $(date +"[%b %d %H:%M:%S] Running flye...")

flye --nano-hq $reads \
--out-dir $outDir \
--genome-size $genomeSize \
--threads 32

echo $(date +"[%b %d %H:%M:%S] Done!")
