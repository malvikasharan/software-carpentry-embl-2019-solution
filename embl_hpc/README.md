<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons Licence" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.

# Intro

Teaching material for cluster computing course at EMBL.

Directory structure:
- `novice/`: material for the EMBL-internal Bio-IT course, _Introduction to Cluster Computing at EMBL_
- `intermediate/`: material for the EMBL-internal Bio-IT course, _Intermediate Cluster Computing_
- `swc/`: material for the HPC session of [Software Carpentry](https://software-carpentry.org/) workshops run at EMBL

Each of the above directories has an `exercises/` subdirectory, containing files needed for exercises during the course.

# Commands (for EMBL Cluster)

Below are most of the commands used during the practical, so they can be copy/pasted, but I highly recommend typing along if you can.

## Login to the frontend node

```
ssh <username>@login.cluster.embl.de
```

## Clone this git repository
```
git clone https://git.embl.de/grp-bio-it/embl_hpc.git
```

## Identifying our computer

```
hostname
```

## Our first SLURM job

```
srun hostname
```

## Exploring our example program (don't run!)

```
cd $HOME/embl_hpc/exercises
./hpc_example -t 10 -m 100
```

## Running example program on on the cluster

```
srun ./hpc_example -t 10 -m 100
```

## Using our reserved training space
```
srun --reservation=training ./hpc_example -t 10 -m 100
```

## Running in the background

```
sbatch --reservation=training ./batch_job.sh
```

## Redirecting output

```
sbatch --output=output.txt --reservation=training ./batch_job.sh
```

## Creating a larger list
You will need to edit batch_jobs.sh to take arguments
```
sbatch --output=output.txt --reservation=training ./batch_job.sh 20 ???
```

## Displaying details of our cluster queue

```
scontrol show partition
```

## Requesting more resources

```
sbatch --mem=8200 --reservation=training ./batch_job.sh 30 8000
```

## Requesting a lot more resources

```
sbatch --mem=100G --reservation=training ./batch_job.sh 30 5000
```

## Cancel jobs
```
scancel <jobID>
scancel -u <username>
```

## Defining time limits
```
sbatch ­­--time=00 00:00:30  \
      --reservation=training \
    batch_job.sh 60 500
```

## Job efficiency statistics
```
seff <jobID>
```

## Emailing output
```
sbatch ­­--mail-user=<first.last>@embl.de \
    ­­--reservation=training \
    ./batch_job.sh 20 500
```

## Finding and using software
```
module avail
module spider samtools
module load BWA
```

## BWA example
```
nano bwa/bwa_batch.sh
sbatch --reservation=training bwa/bwa_batch.sh
```

## Running interactive jobs
```
srun --pty bash
```

## Interactive job with more memory
```
srun --mem=250 --pty bash
```

## Using `sbatch` instead

```
sbatch batch_jobs.sh
```

## Using job dependencies to build pipelines

```
jid=$(sbatch --parsable batch_job.sh)

sbatch --dependency=afterok:$jid batch_job.sh
```
