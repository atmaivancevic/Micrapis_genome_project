#!/bin/bash

## Script for running BRAKER3, with cDNA/RNAseq BAM files and protein sequences as extrinsic evidence
##
## Example usage:
## inDir=../andreniformis_braker sbatch braker3_annotation.sbatch

## General SLURM settings
#SBATCH -p long
#SBATCH -N 1
#SBATCH -c 32
#SBATCH --time=100:00:00
#SBATCH --mem=500GB

# Job name and output
#SBATCH -J braker3
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%A_%a.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%A_%a.err

# Load modules
# module load augustus genemark prothint

# Activate conda environment
source ~/miniconda3/bin/activate
conda activate braker3_env

# Set environment variables for required dependencies
export GENEMARK_PATH=/Shares/CL_Shared/programs/GeneMark-ETP/bin
export PATH=/Shares/CL_Shared/programs/GeneMark-ETP/tools:$PATH
export PATH=/Shares/CL_Shared/programs/ProtHint-2.6.0/bin:$PATH
export AUGUSTUS_CONFIG_PATH=/Users/ativ2716/miniconda3/envs/braker3_env/config

# go to designated braker dir
cd $inDir

# Run BRAKER3 without softmasking to ensure TE-derived isoforms are detected
braker.pl \
--threads 32 \
--genome=../../1_WGS_Assembly_For_Publication/uploaded_genomes/Apis_andreniformis/Aa1SG1_genome.fasta \
--species=Aandreniformis \
--prot_seq=../Arthropoda.fa \
--bam=../andreniformis_illumina_bams/Aandren_illumina_RNAseq_merged.bam,../andreniformis_ONT_bams/Aa1SG2_combined_barcode21_pychopper_output.bam,../andreniformis_ONT_bams/Aa1SG3_combined_barcode22_pychopper_output.bam

echo $(date +"[%b %d %H:%M:%S] BRAKER3 annotation completed!")

