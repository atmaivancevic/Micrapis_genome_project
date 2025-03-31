#!/bin/bash

## Script for using Pilon to polish the long reads with short reads
## Example usage:
## prefix=Aa1SG1 \
## assembly=../andreniformis_medaka/consensus.fasta \
## bam=../andreniformis_illumina_bam/Aa1SG1_Illumina.sorted.bam \
## outDir=../andreniformis_pilon \
## sbatch --array 0-0 pilon_polish.sbatch

## General settings
#SBATCH -p long
#SBATCH --time=100:00:00
#SBATCH --mem=64GB
#SBATCH --cpus-per-task=16
#SBATCH -J pilon
#SBATCH --output=/scratch/Users/%u/data/slurmOut/slurm-%A_%a.out
#SBATCH --error=/scratch/Users/%u/data/slurmErr/slurm-%A_%a.err

echo $(date +"[%b %d %H:%M:%S] Running pilon...")

java -Xmx64G -jar /Shares/CL_Shared/programs/pilon-1.24/pilon-1.24.jar \
--genome $assembly \
--frags $bam \
--outdir $outDir \
--output $prefix \
--diploid \
--changes --vcf --tracks

echo $(date +"[%b %d %H:%M:%S] Done!")
