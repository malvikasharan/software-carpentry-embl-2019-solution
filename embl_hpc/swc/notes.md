# EMBL SWC HPC

## Introduction

- What is a cluster? What about a cloud? Jargon: cluster; HPC; node; job; scheduler
- When is a compute cluster useful?
  - When you realise that your standard computer is too slow/too small for what you want to do
- "Servers" - one large machine
- "Cluster" - many machines, often different specs, managed centrally
- Users typically interact with a head or master node
- "Job scheduler" software takes care of queuing tasks and allocating them to appropriate compute nodes, monitoring progress, etc
  - many options for this: Torque, LSF, Condor, **Slurm**
- We will connect to our cluster with the `ssh` command
- Our example cluster consists of:
  - embl-swc-master:
    - our master node, from which we will send jobs to be run on the other nodes
    - accessible at the IP address on the whiteboard
  - embl-swc-node0:
    - 2 cores; 4 GB RAM
  - embl-swc-node1:
    - 4 cores; 8 GB RAM
  - embl-swc-node2:
    - 8 cores; 16 GB RAM
- `scontrol show nodes`
- 14 cores in total, so *we will all need to share the resources!*
- now we need to download the material for the rest of this session
  - `git clone https://git.embl.de/grp-bio-it/embl_hpc.git`

## First Steps with Slurm

- `hostname`
- `srun hostname`
- `cd embl_hpc/swc/exercises/`
- `less hpc_example.py`
- `chmod +x hpc_example.py`
- `./hpc_example.py -h`
- `pip install psutil`
- `./hpc_example.py -h`
- `./hpc_example.py -t 10 -l 100` (don't choose a >4M for `-l` here)
- `srun ./hpc_example.py -t 10 -l 100`

## Introducing `sbatch`

- `srun` is kinda helpful (it allows us to run jobs on available compute hardware), but all the waiting around is inconvenient
- `sbatch ./hpc_example.py -t 120 -l 100`
- `squeue` to list current jobs
- `squeue -u <username>`
- `less slurm-xxx.out`
- `sbatch --output=output.txt ./hpc_example.py -t 20 -l 100`

## Requesting Resources

- `srun --output=output.txt ./hpc_example.py -t 10 -l 6000000`
- the job was killed because it started using more memory than we had told Slurm we would need
- but we didn't tell Slurm anything, right?!
- defaults!
  - `scontrol show partition`
  - default memory per CPU is 100 MB
  - default no. CPUs is 1
- `sbatch --mem=250 --output=output.txt ./hpc_example.py -t 10 -l 6000000`
- did all your jobs succeed?
- look at the output file - how much memory did your job use?
- now let's try asking for (reserving) a REALLY large amount of memory
- `sbatch --mem=8000 --output=output.txt ./hpc_example.py -t 10 -l 6000000`
- `squeue`
- not all jobs can run because only one of the nodes has enough memory to fulfill this request
- this is bad for you if you are one of the ones waiting!
- we don't have time to be exhaustive here but same principle applies to CPU and time too
- understanding the compute requirements of your job is key to effective use of a shared compute environment like this one
  - ask for too much and risk waiting an unnecessarily long time for your job to run (and also make yourself unpopular with other users and the administrator of the environment)
  - ask for too little and your job will (probably) be killed before it has teh chance to finish successfully and make yourself unpopular because you slow everything down for everyone else
- it can be difficult to get a good estimate
- run a subset and try to calculate what the real thing will need
- be conservative to begin with and then adjust for future, similar runs
- RTFM - some programs let you specify resource usage

## Interactive Jobs

- `srun --pty bash` (or whatever shell you want to use...)
- `srun --mem=250 --pty bash`

## Batch Scripts

- `less batch_job.sh`
- `sbatch batch_job.sh`
- add `#SBATCH --mem=5000` to header
- try adding another line to the script to run program twice with two different sets of parameters

## Where to find out more

- links in the etherpad

https://slurm.schedmd.com/tutorials.html
the other slide decks in this git repository
https://hpc-carpentry.github.io/
