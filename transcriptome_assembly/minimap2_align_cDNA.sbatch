#!/bin/bash

## Script for aligning long-read bams
##
## Example usage:
## inDir=pychopper_trimmed_reads \
## outDir=andreniformis_ONT_cDNA_bams \
## genome=final_genome/Aa1SG1_genome.fasta \
## sbatch --array 0-1 minimap2_align_cDNA.sbatch

## General settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 8
#SBATCH --time=12:00:00
#SBATCH --mem=128GB

# Job name and output
#SBATCH -J minimap2_cDNA
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%A_%a.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%A_%a.err

# Load necessary modules
module load samtools

# Set query files
queries=($(ls $inDir/*.fastq | xargs -n 1 basename))

# Ensure output directory exists
mkdir -p $outDir

# Run minimap2 with the splice preset for ONT cDNA reads
minimap2 -a -t 8 -x splice \
$genome \
$inDir/${queries[$SLURM_ARRAY_TASK_ID]} \
| samtools view -bS - \
| samtools sort - -@ 8 -o $outDir/${queries[$SLURM_ARRAY_TASK_ID]%.fastq}.bam

# Index BAM file
samtools index $outDir/${queries[$SLURM_ARRAY_TASK_ID]%.fastq}.bam

echo "Alignment completed: ${queries[$SLURM_ARRAY_TASK_ID]}"

