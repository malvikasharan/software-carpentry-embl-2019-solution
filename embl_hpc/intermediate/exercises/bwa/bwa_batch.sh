#!/bin/bash
#SBATCH -J bwa
#SBATCH --time=00-00:06:00
#SBATCH --mem=4000M
#SBATCH --nodes=1
#SBATCH --tmp=1G
#SBATCH --gres=tmp:1G
#SBATCH --output=bwa.out
#SBATCH --open-mode=append

## load required modules
module load SAMtools BWA

## copy data to /tmp and change directory to /tmp
cp /g/its/home/pecar/benchmarks/msmith_bwa/Ecoli_genome.fa.gz $TMPDIR
cp /g/its/home/pecar/benchmarks/msmith_bwa/reads_*.fq.gz $TMPDIR 
cd $TMPDIR

## create an index
bwa index -p ecoli Ecoli_genome.fa.gz 

## perform alignment
bwa mem -t $SLURM_CPUS_PER_TASK ecoli reads_1.fq.gz reads_2.fq.gz > aligned.sam

## create a compressed BAM file
samtools view -b aligned.sam > aligned.bam

## copy results back to where job was submitted from
cp aligned.bam $SLURM_SUBMIT_DIR/
