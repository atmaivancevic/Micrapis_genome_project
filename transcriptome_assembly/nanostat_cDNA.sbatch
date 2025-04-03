#!/bin/bash

## Script for running NanoStat on pychopper output
##
## Example usage:
## inDir=pychopper_trimmed_reads outDir=cDNA_nanostats sbatch --array 0-3 nanostat_cDNA.sbatch

## General settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 32
#SBATCH --time=24:00:00
#SBATCH --mem=128GB

# Job name and output
#SBATCH -J nanoStat
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%A_%a.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%A_%a.err

# Activate virtual environment that contains NanoStat
source ~/jhub_venv_3.10.8/bin/activate

# Set query files
queries=($(ls $inDir/*_pychopper_output.fastq | xargs -n 1 basename))

# Run hisat2
pwd; hostname; date

echo "Starting NanoStat..."
echo "Processing file: "${queries[$SLURM_ARRAY_TASK_ID]}

NanoStat --fastq $inDir/${queries[$SLURM_ARRAY_TASK_ID]} \
--name ${queries[$SLURM_ARRAY_TASK_ID]%.fastq}_stats.txt \
--outdir $outDir \
--threads 32

echo $(date +"[%b %d %H:%M:%S] Done!")
