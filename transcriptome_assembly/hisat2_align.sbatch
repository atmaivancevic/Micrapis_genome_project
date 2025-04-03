#!/bin/bash

## Script for running hisat2 for transcript assembly
##
## Example usage:
## inDir=../andreniformis_illumina_trimmed \
## outDir=../andreniformis_illumina_bams \
## hisatIdxDir=../../1_WGS_Assembly_For_Publication/uploaded_genomes/Apis_andreniformis/index/hisat2 \
## hisatIdx=Aa1SG1 \
## rnaStrandness=RF \
## sbatch --array 0-1 hisat2_align.sbatch

# important note: 
# for single-ended data, rnaStrandness is R (for reverse) or F (for forward)
# for paired-ended data, rnaStrandness is RF (for reverse) or FR (for forward)

## General settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --time=24:00:00
#SBATCH --mem=500GB

# Job name and output
#SBATCH -J hisat2_PE_dta
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%A_%a.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%A_%a.err

# Set constant variables
numThreads=16

# Set query files
# note: remove R1/R2 to generate a unique identifier for each pair of files
queries=($(ls $inDir/*_trimmed.fastq.gz | xargs -n 1 basename | sed 's/_R1_trimmed.fastq.gz//g' | sed 's/_R2_trimmed.fastq.gz//g' | uniq))

# Load modules
module load hisat2 samtools

# Run hisat2
pwd; hostname; date

echo "Starting HISAT2 alignment..."
echo "HISAT2 version: "$(hisat2 --version)
echo "samtools version: "$(samtools --version)
echo "Processing file: "${queries[$SLURM_ARRAY_TASK_ID]}

# Note: reference assembly needs to be indexed using hisat2
# e.g. run this if there is no existing index:
# hisat2-build -p 16 Aa1SG1_genome.fasta index/hisat2/Aa1SG1

# Ensure output directory exists
mkdir -p $outDir

# Make sure to provide the --dta option when running hisat2 for transcript assembly 
# Recommended by the BRAKER pipeline

hisat2 --dta \
--rna-strandness ${rnaStrandness} \
-p ${numThreads} \
-x ${hisatIdxDir}/${hisatIdx} \
-1 $inDir/${queries[$SLURM_ARRAY_TASK_ID]}_R1_trimmed.fastq.gz \
-2 $inDir/${queries[$SLURM_ARRAY_TASK_ID]}_R2_trimmed.fastq.gz \
| samtools view -q 10 -Sb - \
| samtools sort -@ ${numThreads} - -o $outDir/${queries[$SLURM_ARRAY_TASK_ID]}.bam

# Create a bai index file for upload to UCSC browser
samtools index $outDir/${queries[$SLURM_ARRAY_TASK_ID]}.bam

echo $(date +"[%b %d %H:%M:%S] Done!")
