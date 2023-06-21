#!/bin/bash
#SBATCH --job-name=mpi_job
#SBATCH --account=cdac
#SBATCH --time=00:10:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4
#SBATCH --mem-per-cpu=1GB
#SBATCH --partition=standard
#SBATCH --error=errs/mpi_job.%J.err
#SBATCH --output=outputs/mpi_job.%J.out

module load gnu8
module load openmpi3


mpirun -np $1 ./$2
