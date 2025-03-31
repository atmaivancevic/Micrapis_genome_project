#!/bin/bash

## Script for assembly polishing with Medaka
##
## Example usage:
## reads=../reads/Aa1SG1_ONT.fastq \
## assembly=../andreniformis_flye/assembly.fasta \
## outDir=../andreniformis_medaka \
## model=r1041_e82_400bps_sup_v5.0.0 \
## sbatch medaka_consensus.sbatch

## General settings
#SBATCH -p nvidia-a100
#SBATCH --time=24:00:00
#SBATCH --mem=128GB
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH -J medaka_consensus
#SBATCH --output=/scratch/Users/%u/data/slurmOut/slurm-%j.out
#SBATCH --error=/scratch/Users/%u/data/slurmErr/slurm-%j.err

# Activate conda base environment
source ~/miniconda3/bin/activate

# Activate medaka-specific conda environment
conda activate medaka_env

# Important notes 

# Note 1: input reads (-i)
# the input basecalls you provide with the -i parameter should be the raw basecalled reads 
# (i.e. your dorado-SUP basecalled and demultiplexed FASTQ file)
# do NOT provide any kind of corrected reads 
# Medaka is designed to use the original, raw basecalled reads only

# Note 2: model selection (-m):
# If unsure which medaka model to pick, you can check the report.json file for your sequencing run
# E.g. in my case, report_PAO05592_20240627_1412_3dc7722d.json includes the following:
# "name":"sequencing/sequencing_PRO114_DNA_e8_2_400K"
# and I basecalled the pod5 files using dorado SUP
# so for me, r1041_e82_400bps_sup_v5.0.0 is the most suitable medaka model to use

pwd; hostname; date
echo "medaka version: "$(medaka --version)
echo $(date +"[%b %d %H:%M:%S] Running medaka_consensus...")

medaka_consensus -i $reads -d $assembly -o $outDir -t 16 -m $model

echo $(date +"[%b %d %H:%M:%S] Done!")
