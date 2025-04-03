#!/bin/bash

## Script for polishing and trimming cDNA reads with Pychopper
##
## Example usage:
## inDir=cDNA_ONT_untrimmed_reads outDir=pychopper_trimmed_reads sbatch --array 0-3 pychopper_trim.sbatch

## General settings
#SBATCH -p long
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --time=100:00:00
#SBATCH --mem=256GB

# Job name and output
#SBATCH -J pychopper
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%A_%a.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%A_%a.err

# Activate conda base environment
source ~/miniconda3/bin/activate

# Activate pychopper-specific conda environment
conda activate pychopper_env

# Set query files
queries=($(ls $inDir/*.fastq | xargs -n 1 basename))

# Run Pychopper
pwd; hostname; date

echo "Starting Pychopper..."
echo "Processing file: "${queries[$SLURM_ARRAY_TASK_ID]}

# create the output directory if it doesn't exist
mkdir -p $outDir

# run Pychopper to trim and identify full-length cDNA reads
pychopper -t 16 \
    -k PCB111 \
    -u $outDir/${queries[$SLURM_ARRAY_TASK_ID]%.fastq}_unclassified.fastq \
    -w $outDir/${queries[$SLURM_ARRAY_TASK_ID]%.fastq}_rescued.fastq \
    -r $outDir/${queries[$SLURM_ARRAY_TASK_ID]%.fastq}_report.pdf \
    -S $outDir/${queries[$SLURM_ARRAY_TASK_ID]%.fastq}_statistics.tsv \
    $inDir/${queries[$SLURM_ARRAY_TASK_ID]} \
    $outDir/${queries[$SLURM_ARRAY_TASK_ID]%.fastq}_full_length_output.fastq

# concatenate the rescued reads with the high confidence full-length reads
cat $outDir/${queries[$SLURM_ARRAY_TASK_ID]%.fastq}_full_length_output.fastq \
    $outDir/${queries[$SLURM_ARRAY_TASK_ID]%.fastq}_rescued.fastq \
    > $outDir/${queries[$SLURM_ARRAY_TASK_ID]%.fastq}_pychopper_output.fastq

echo $(date +"[%b %d %H:%M:%S] Done!")
