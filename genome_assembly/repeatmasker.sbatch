#!/bin/bash

## Script for running RepeatMasker
##
## Example usage:
## species=Eukaryota \
## outDir=andreniformis_repeats \
## genome=andreniformis_pilon/Aa1SG1_minLength3kb.fasta \
## sbatch repeatmasker.sbatch

# General settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 8
#SBATCH --time=24:00:00
#SBATCH --mem=248GB

# Job name and output
#SBATCH -J repeatmasker
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%j.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%j.err

pwd; hostname; date
echo $(date +"[%b %d %H:%M:%S] Running repeatmasker...")

# Note: make sure your genome file has been indexed
# If it hasn't, run the following:
# samtools faidx genome.fasta

# Run repeatmasker
RepeatMasker -pa 8 -species $species -noisy -xsmall -dir $outDir $genome

echo $(date +"[%b %d %H:%M:%S] Done!")
