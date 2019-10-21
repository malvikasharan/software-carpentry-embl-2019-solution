#!/bin/bash
#SBATCH --time=00-00:06:00
#SBATCH --mem=4000M
#SBATCH --nodes=1
#SBATCH --tmp=1G
#SBATCH --gres=tmp:1G
#SBATCH --output=bwa.out
#SBATCH --open-mode=append

## load required modules
module load SAMtools BWA

## record current location, copy data to /tmp and change directory to /tmp
WORKING_DIR=`pwd`
echo $WORKING_DIR
cp /g/huber/users/msmith/embl_hpc/Ecoli_genome.fa.gz /g/huber/users/msmith/embl_hpc/reads_*.fq.gz $TMPDIR 
cd $TMPDIR

## create an index
bwa index -p ecoli Ecoli_genome.fa.gz 

## perform alignment
bwa mem ecoli reads_1.fq.gz reads_2.fq.gz > aligned.sam

## create a compressed BAM file
samtools view -b aligned.sam > aligned.bam

## copy results back
cp aligned.bam $WORKING_DIR/
