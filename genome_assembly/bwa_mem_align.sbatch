#!/bin/bash

## Script for aligning Illumina short reads with BWA-MEM
## Example usage:
## assembly=andreniformis_medaka/consensus.fasta \
## inDir=andreniformis_illumina_trimmed \
## outDir=andreniformis_illumina_bam \
## sbatch --array 0-3 bwa_mem_align.sbatch

## General settings
#SBATCH -p short
#SBATCH --time=24:00:00
#SBATCH --mem=64GB
#SBATCH --cpus-per-task=16
#SBATCH -J bwa_mem
#SBATCH --output=/scratch/Users/%u/data/slurmOut/slurm-%A_%a.out
#SBATCH --error=/scratch/Users/%u/data/slurmErr/slurm-%A_%a.err

# Define query files
queries=($(ls ${inDir}/*fastq.gz | xargs -n 1 basename | sed 's/_R1_trimmed.fastq.gz//g' | sed 's/_R2_trimmed.fastq.gz//g' | uniq))

# Load modules
module load bwa/0.7.15
module load samtools

# Print time and date
pwd; hostname; date

# Print program versions
echo "bwa version: "$(bwa 2>&1 | grep -m1 -oP 'Version: \K[\d\.]+')
echo "samtools version: "$(samtools --version)
echo "Processing file: "${queries[$SLURM_ARRAY_TASK_ID]}

# Index the reference assembly using bwa
echo $(date +"[%b %d %H:%M:%S] Indexing the assembly...")

bwa index $assembly

echo $(date +"[%b %d %H:%M:%S] Finished indexing.")

# Run bwa to align reads and then filter with samtools, saving output bam
echo $(date +"[%b %d %H:%M:%S] Starting bwa alignment...")

bwa mem -t 16 \
$assembly \
${inDir}/${queries[$SLURM_ARRAY_TASK_ID]}_R1_trimmed.fastq.gz \
${inDir}/${queries[$SLURM_ARRAY_TASK_ID]}_R2_trimmed.fastq.gz \
| samtools view -Sb -q 10 -F 4 - \
| samtools sort -@ 16 - \
> ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]%.fastq.gz}.sorted.bam

# Note that this will filter out low quality reads (-q 10), unmapped reads (-F 4), then sort the bam.

# Create a bai index file
samtools index ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]%.fastq.gz}.sorted.bam

echo $(date +"[%b %d %H:%M:%S] Done!")
