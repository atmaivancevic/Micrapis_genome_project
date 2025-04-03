#!/bin/bash

## Script for running meryl count on paired-end short reads
##
## Example usage:
## read1=andreniformis_illumina_WGS_trimmed/Aa1SG1_Illumina_R1_trimmed.fastq.gz \
## read2=andreniformis_illumina_WGS_trimmed/Aa1SG1_Illumina_R2_trimmed.fastq.gz \
## output=andreniformis_meryl/reads.meryl \
## sbatch meryl_count.sbatch

# General settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --time=24:00:00
#SBATCH --mem=500GB

# Job name and output
#SBATCH -J meryl_count
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%j.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%j.err

# Activate conda base environment
source ~/miniconda3/bin/activate

# Activate merqury-specific conda environment
conda activate merqury_env

pwd; hostname; date
echo $(date +"[%b %d %H:%M:%S] Running meryl count on short reads...")

# Run meryl count
meryl count k=21 threads=16 output $output $read1 $read2

# Explanation of parameters:
# k=21: sets the k-mer size to 21 (this is the default; change as needed)
# output: specifies the output database name
# input files: trimmed paired-end Illumina short reads

echo $(date +"[%b %d %H:%M:%S] Done!")
