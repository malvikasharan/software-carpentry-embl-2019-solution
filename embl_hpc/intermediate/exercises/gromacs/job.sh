#!/bin/bash

#SBATCH -J gromacs
#SBATCH -N 1
#SBATCH -c 8
#SBATCH --hint=nomultithread
#SBATCH -C avx
#SBATCH -t 04:00

module load GROMACS/2018.1-foss-2017b
cp /g/its/home/pecar/benchmarks/pchen_gromacs/1OVA-AB.tpr $TMPDIR
cd $TMPDIR

gmx mdrun -s 1OVA-AB.tpr -nsteps 5000 -ntmpi 1
tail -5 md.log

