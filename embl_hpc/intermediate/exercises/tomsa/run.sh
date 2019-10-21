#!/bin/bash
#SBATCH -J tomsa_mpi
#also try -N with --ntasks-per-node
#SBATCH -n 24
#SBATCH -C "net10G|net25G"
#SBATCH --switches=1
#SBATCH --mem-per-cpu=20
#SBATCH --time=00:05:00 

module load foss/2017b

cd $SCRATCHDIR
tar zxf /g/its/home/pecar/benchmarks/turonova_tomsa/data.tgz

START=$SECONDS
mpirun tomsa -param params.txt -folder ./results
echo took $((SECONDS-START)) seconds witn $SLURM_NTASKS tasks across $SLURM_NNODES nodes

#cp results/* $SLURM_SUBMIT_DIR/
