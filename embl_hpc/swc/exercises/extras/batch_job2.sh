#!/bin/bash
#SBATCH --output=output.txt
#SBATCH --open-mode=append

srun ./hpc_example -t $1 -m $2

