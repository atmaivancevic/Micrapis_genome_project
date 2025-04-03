#!/bin/bash

## Script for running BUSCO
##
## Example usage:
## prefix=hymenoptera \
## lib=hymenoptera_odb10 \
## inFile=andreniformis_pilon/Aa1SG1_minLength3kb.fasta \
## outDir=andreniformis_busco \
## sbatch busco_genome.sbatch

# General settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --time=24:00:00
#SBATCH --mem=248GB

# Job name and output
#SBATCH -J busco
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%j.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%j.err

# Activate conda base environment
source ~/miniconda3/bin/activate

# Activate busco-specific conda environment
conda activate busco_env

pwd; hostname; date
echo $(date +"[%b %d %H:%M:%S] Running busco...")

busco -i $inFile \
--out_path $outDir \
--out $prefix \
--lineage_dataset $lib \
--mode genome \
--cpu 16

# Explanation of parameters:
# -i: input genome assembly
# --out: prefix for output file names
# --lineage_dataset: specifies the lineage dataset for BUSCO to download and use
# --mode: specifies that you're running BUSCO on a genome assembly
# --out_path: ensures all BUSCO output files (e.g., summaries, logs, and temporary files) are placed in the specified directory

echo $(date +"[%b %d %H:%M:%S] Done!")
