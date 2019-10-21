## Generate _ubuntu_ user SSH keys

We only need to do the is on the Master, since the home drive will be shared with the compute nodes

```
ssh-keygen -t rsa -N "" -f $HOME/.ssh/id_rsa
cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
```

## Install NFS

### Master

```
sudo apt-get update
sudo apt-get install nfs-kernel-server
sudo cat '/home	10.0.0.0/24(rw,sync,no_root_squash,no_subtree_check)' >> /etc/exports # you might need to replace with the IP address of your master node
sudo service nfs-kernel-server start
```

### Node

```
sudo apt-get update
sudo apt-get install nfs-common

## add a line to automatically mount the shared home directory
sudo cat '10.0.0.8:/home    /home   nfs auto,noatime,nolock,bg,nfsvers=4,intr,tcp,actimeo=1800 0 0' >> /etc/fstab # make sure you use the correct IP for the master

## restart the machine
sudo shutdown -r now
```


## Install SLURM

### Master

```
sudo apt-get install slurm-wlm

## enable use of cgroups for process tracking and resource management
sudo bash -c 'echo CgroupAutomount=yes >> /etc/slurm-llnl/cgroup.conf'
sudo chown slurm:slurm /etc/slurm-llnl/cgroup.conf # you might need to create a slurm user before you can do this
sudo sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/g' /etc/default/grub
sudo update-grub

## put munge key in home directory so we can share it with the nodes
sudo cp /etc/munge/munge.key $HOME/

## download slurm.conf file (may require some editing of IP addresses etc)
sudo wget https://git.embl.de/grp-bio-it/embl_hpc/raw/master/swc/cluster_setup/slurm.conf -O /etc/slurm-llnl/slurm.conf -o /dev/null
sudo chown slurm:slurm /etc/slurm-llnl/slurm.conf
```

### Node

```
## install slurm worker daemon
sudo apt-get install slurmd

## enable use of cgroups for process tracking and resource management
sudo bash -c 'echo CgroupAutomount=yes >> /etc/slurm-llnl/cgroup.conf'
sudo chown slurm:slurm /etc/slurm-llnl/cgroup.conf
sudo sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/g' /etc/default/grub
sudo update-grub

## copy the shared munge key and restart the service to start using it
sudo cp /home/ubuntu/munge.key /etc/munge/munge.key
sudo service munge restart
```
