#!/bin/bash

#SBATCH --mem=250
#SBATCH --output=output.txt

srun ./hpc_example.py -t 30 -l 5000
