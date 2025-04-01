#!/bin/bash

## Script for running FCS-GX to screen and clean genome of foreign contaminants
##
## Example usage:
## inFasta=../andreniformis_pilon/Aa1SG1_minLength3kb.fasta \
## outDir=../andreniformis_FCS \
## taxID=7464 \
## reportFile=../andreniformis_FCS/Aa1SG1_minLength3kb.7464.fcs_gx_report.txt \
## cleanFasta=../andreniformis_FCS/clean2.fasta \
## contamFasta=../andreniformis_FCS/contam.fasta \
## sbatch fcs_gx.sbatch

# SLURM settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --time=08:00:00
#SBATCH --mem=16GB

# Job name and output
#SBATCH -J fcs_gx
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%j.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%j.err

# Load required modules
module load python/3.9.15

# Set default FCS image location (if needed)
export FCS_DEFAULT_IMAGE=fcs-gx.sif

# Set FCS-GX directory (adjust as needed)
FCS_DIR=/Shares/CL_Shared/programs/NCBI_Foreign_Contamination_Screen/FCS-gx

pwd; hostname; date

echo $(date +"[%b %d %H:%M:%S] Running FCS-GX screen...")

# Step 1: Screen for contamination using taxon-specific GX database
python3 $FCS_DIR/fcs.py screen genome \
  --fasta $inFasta \
  --out-dir $outDir \
  --gx-db $FCS_DIR/gxdb/ \
  --tax-id $taxID

echo $(date +"[%b %d %H:%M:%S] Cleaning genome...")

# Step 2: Clean based on action report
cat $inFasta | python3 $FCS_DIR/fcs.py clean genome \
  --action-report $reportFile \
  --output $cleanFasta \
  --contam-fasta-out $contamFasta

echo $(date +"[%b %d %H:%M:%S] Done!")
