#!/bin/sh

## CPU Usage
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=8G
#SBATCH -p silent_q
#SBATCH --time=0:15:00

## Output and Stderr
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.error

source /mnt/common/SILENT/Act3/conda/miniconda3/etc/profile.d/conda.sh
Nextflow=/mnt/common/Precision/NextFlow/nextflow
module load singularity
$Nextflow run test_subset_population_SNV.nf -resume
