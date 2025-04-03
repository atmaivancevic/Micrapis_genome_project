#!/bin/bash

## Script for running Merqury to compare kmers between short reads and final assembly
##
## Example usage:
## shortReadKmers=andreniformis_meryl/reads.meryl \
## assemblyFasta=andreniformis_pilon/Aa1SG1_minLength3kb.fasta \
## prefix=merqury_output \
## sbatch merqury_kmers.sbatch

# General settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 8
#SBATCH --time=8:00:00
#SBATCH --mem=128GB

# Job name and output
#SBATCH -J merqury
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%j.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%j.err

# Activate conda base environment
source ~/miniconda3/bin/activate

# Activate merqury-specific conda environment
conda activate merqury_env_with_java

# Load required modules
module load bedtools
module load samtools

pwd; hostname; date
echo $(date +"[%b %d %H:%M:%S] Running merqury to compare kmers...")

# Note: make sure your genome file has been indexed
# If it hasn't, run the following:
# samtools faidx genome.fasta

# Run merqury
$MERQURY/merqury.sh $shortReadKmers $assemblyFasta $prefix

echo $(date +"[%b %d %H:%M:%S] Done!")
