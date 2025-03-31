#!/bin/bash

## Script for running QUAST to assess genome assembly quality
##
## Example usage:
## inputFasta=../andreniformis_pilon/Aa1SG1_minLength3kb.fasta \
## outDir=../andreniformis_quast \
## sbatch quast_report.sbatch

# SLURM settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --time=04:00:00
#SBATCH --mem=16GB

# Job name and output
#SBATCH -J quast
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%j.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%j.err

# Activate conda base environment
source ~/miniconda3/bin/activate

# Activate quast-specific conda environment
conda activate quast_env

pwd; hostname; date

echo $(date +"[%b %d %H:%M:%S] Running QUAST...")

quast $inputFasta -o $outDir

echo $(date +"[%b %d %H:%M:%S] Done!")
