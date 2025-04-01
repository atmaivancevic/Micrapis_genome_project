#!/bin/bash

## Script for running FCS-adaptor to screen and clean genome of adapter/vector contamination
##
## Example usage:
## inFasta=../andreniformis_pilon/Aa1SG1_minLength3kb.fasta \
## outDir=../andreniformis_FCS \
## cleanFasta=clean1.fasta \
## sbatch fcs_adaptor.sbatch

# SLURM settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --time=08:00:00
#SBATCH --mem=16GB

# Job name and output
#SBATCH -J fcs_adaptor
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%j.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%j.err

# Load modules
module load singularity
module load python/3.9.15

# Set FCS path and image
FCS_DIR=/Shares/CL_Shared/programs/NCBI_Foreign_Contamination_Screen/FCS-adaptor
export FCS_DEFAULT_IMAGE=$FCS_DIR/fcs-gx.sif

pwd; hostname; date

echo $(date +"[%b %d %H:%M:%S] Running FCS-adaptor screen...")

# Step 1: Screen genome for adapter/vector contamination
$FCS_DIR/run_fcsadaptor.sh \
  --fasta-input $inFasta \
  --output-dir $outDir \
  --euk \
  --container-engine singularity \
  --image $FCS_DIR/fcs-adaptor.sif

echo $(date +"[%b %d %H:%M:%S] Cleaning genome...")

# Step 2: Clean genome using contamination report
cat $inputFasta | python3 $FCS_DIR/fcs.py clean genome \
  --action-report $outDir/fcs_adaptor_report.txt \
  --output $cleanFasta \
  --contam-fasta-out vector_contam.fasta

echo $(date +"[%b %d %H:%M:%S] Done!")
