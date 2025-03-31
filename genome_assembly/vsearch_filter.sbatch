#!/bin/bash

## Script for running vsearch to sort by length and filter short contigs
##
## Example usage:
## inFasta=../andreniformis_pilon/Af1SG1.fasta \
## outFasta=../andreniformis_pilon/Af1SG1_minLength3kb.fasta \
## sbatch vsearch_filter.sbatch

# SLURM settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --time=04:00:00
#SBATCH --mem=24GB

# Job name and output
#SBATCH -J vsearch
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%j.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%j.err

pwd; hostname; date

echo $(date +"[%b %d %H:%M:%S] Running vsearch...")

vsearch --sortbylength $inFasta \
--minseqlength 3000 \
--maxseqlength 1000000000 \
--output $outFasta

echo $(date +"[%b %d %H:%M:%S] Done!")

