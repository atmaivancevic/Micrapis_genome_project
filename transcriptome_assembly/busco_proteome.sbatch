#!/bin/bash

## Script for running BUSCO to assess the proteome
##
## Example usage:
## inFile=../florea_braker_slurm/braker/braker.aa \
## prefix=hymenoptera \
## outDir=../florea_braker_slurm/busco_output \
## lib=hymenoptera_odb10 \
## sbatch busco_proteome.sbatch

# General settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --time=24:00:00
#SBATCH --mem=248GB

# Job name and output
#SBATCH -J busco_proteome
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%j.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%j.err

# Activate conda base environment
source ~/miniconda3/bin/activate

# Activate busco-specific conda environment
conda activate busco_env

pwd; hostname; date
echo $(date +"[%b %d %H:%M:%S] Running busco...")

# Run BUSCO for gene annotation assessment
busco -i $inFile \
--out_path $outDir \
--out $prefix \
--lineage_dataset $lib \
--mode proteins \
--cpu 16

# Explanation of parameters:
# -i: input file (predicted protein sequences from BRAKER)
# --out: prefix for output file names
# --lineage_dataset: specifies the lineage dataset for BUSCO to download and use
# --mode proteins: runs BUSCO on predicted proteins to assess annotation quality
# --out_path: ensures all BUSCO output files (e.g., summaries, logs, and temporary files) are placed in the specified directory

echo $(date +"[%b %d %H:%M:%S] BUSCO analysis completed!")
