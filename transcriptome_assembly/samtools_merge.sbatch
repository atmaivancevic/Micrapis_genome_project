#!/bin/bash

## Script for merging and indexing BAM files using samtools
##
## Example usage:
## outBam=Aandren_illumina_RNAseq_merged.bam \
## inBams="Aa1SG2_1A_S25.bam Aa1SG3_2A_S26.bam" \
## sbatch samtools_merge.sbatch

# SLURM settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --time=12:00:00
#SBATCH --mem=32GB

# Job name and output
#SBATCH -J samtools_merge
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%j.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%j.err

# Load samtools module
module load samtools

pwd; hostname; date

echo $(date +"[%b %d %H:%M:%S] Merging BAM files...")

# Step 1: Merge
samtools merge -@ 16 -o $outBam $inBams

# Step 2: Index
echo $(date +"[%b %d %H:%M:%S] Indexing merged BAM file...")
samtools index -@ 16 $outBam

echo $(date +"[%b %d %H:%M:%S] Done!")
