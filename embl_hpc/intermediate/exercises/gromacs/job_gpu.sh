#!/bin/bash

#SBATCH -J gromacs_gpu
#SBATCH -N 1
#SBATCH -c 4
#SBATCH -p gpu
#SBATCH --gres=gpu:1
#SBATCH -C gpu=1080Ti
#SBATCH -t 02:00

module load GROMACS/2018.1-foss-2017b-CUDA-9.1.85
cp /g/its/home/pecar/benchmarks/pchen_gromacs/1OVA-AB.tpr $TMPDIR
cd $TMPDIR
time gmx mdrun -s 1OVA-AB.tpr -nsteps 5000 -ntmpi 1 -nb gpu
tail -5 md.log

