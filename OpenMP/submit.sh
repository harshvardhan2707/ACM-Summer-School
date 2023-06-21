#!/bin/bash
#SBATCH -N 1
#SBATCH --ntasks-per-node=128
#SBATCH --error=errs/job.%J.err
#SBATCH --output=outputs/job.%J.out
#SBATCH --time=00:10:00
#SBATCH --partition=cpu

module load gnu8
module load openmpi13

./matmul.o 8192 16
