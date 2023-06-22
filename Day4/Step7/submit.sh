#!/bin/sh
#SBATCH -N 1 
#SBATCH --ntasks-per-node=4
#SBATCH --time=72:00:00 
#SBATCH --job-name=Test.melt
#SBATCH --error=job.%J.err_4_node_4 
#SBATCH --output=job.%J.out_4_node_4 
#SBATCH --partition=standard 

module load gnu8
module load openmpi3


cd $SLURM_SUBMIT_DIR

mpirun -np $SLURM_NTASKS ./lmp_mpi -in ./in.melt -log ./melt4.log
