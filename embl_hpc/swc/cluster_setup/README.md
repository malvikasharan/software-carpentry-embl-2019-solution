# Intro

This folder contains instructions and files for setting up the example cluster used during the course.  It's included here mostly for my benefit next time I want to redo the setup, but it might be useful to others.

# Cluster infrastructure

The cluster we're using is running on the Heidelberg installation of the [de.NBI cloud](https://www.denbi.de/cloud-overview/cloud-hd).  The current design is to create a 4 node cluster (1 controller, 3 compute nodes), with varying hardware specifications for each node so we can demonstrate resource managment.

Job scheduling is doing using [SLURM](https://slurm.schedmd.com/) since it is (a) free and (b) mirrors the infrastructure we're currently using at EMBL.
