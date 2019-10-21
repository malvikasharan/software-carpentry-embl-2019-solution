#!/bin/bash
#SBATCH -J gromacs_mpi
#SBATCH -N 1
#SBATCH -n 24
#SBATCH -c 2
#SBATCH -t 01:00

module load GROMACS/2018.1-foss-2017b
cp /g/its/home/pecar/benchmarks/pchen_gromacs/1OVA-AB.tpr $TMPDIR
cd $TMPDIR

#mpirun takes all info from slurm
mpirun gmx_mpi mdrun -s 1OVA-AB.tpr -nsteps 5000

tail -5 md.log

