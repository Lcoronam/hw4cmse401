#!/bin/bash
#SBATCH --job-name=benchmark
#SBATCH --output=revGOL_benchmark.out
#SBATCH --time=6:00:00
#SBATCH --mem=4G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

module load OpenMPI

chmod +x timecheck.sh

./timecheck.sh

