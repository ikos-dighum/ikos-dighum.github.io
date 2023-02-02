---
title: A quick guide for High Performance Computing (HPC) and Slurm
author: Erik Skare
date: February 2, 2023
toc: true
format:
  html:
    embed-resources: true
execute:
  eval: false
  echo: true
---

# Using High Performance Computing (HPC)

High Performance Computing (HPC) is becoming increasingly important as we process, analyze, and perform complex calculations of increasing amounts of data. HPC uses clusters of powerful processors that work in parallel at extremely high speeds. Instead of spending days processing data with a regular computer, HPC systems typically perform at speeds more than one million times faster than the fastest commodity desktop, laptop, or server systems. 

The University of Oslo has its own powerful HPC-cluster, which is available to all users of the Educloud Research infrastructure called FOX. You can apply for access [HERE](https://www.uio.no/english/services/it/research/platforms/edu-research/help/getting-started-with-educloud.html) if you are affiliated with the university. Once you have created an account set up Educloud with the University of Oslo's [VMWare Horizon Client](https://www.uio.no/english/services/it/research/sensitive-data/help/VMware-Win-Mac-Linux.html). 

Remember (for God's sake, remember!), do not log into the Windows desktop. Log into the Linux Fedora desktop as the Command Prompt automatically works with the Fedora version of Educloud when you log into Fox (Fox will not find the files you try to process if you put them in your Educloud Windows desktop). Let's just say I learned the hard way.

In order to log into Fox, open your Command Prompt (the cmd.exe) and type ssh followed by your Educloud username. For example, ```ssh ec-abcde@fox.educloud.no```. You will then be prompted to fill in a One-Time Password (in an authentication app set when you created the app such as *Authy*) and then your personal password. This is where the fun (pain) begins.

## SLURM



###### This is *one* example of how a SLURM script can look

``` 
#!/bin/bash -l

#SBATCH --account=ec0001
#SBATCH --job-name="hpc_job"
#SBATCH --time=02:00:00
#SBATCH --ntasks=1
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --gpus-per-task=2 
#SBATCH --output=C:\Users\Desktop\%j.out
#SBATCH --output=C:\Users\Desktop\%j.err
#SBATCH --partition=accel
#SBATCH --mail-user=eriskar@uio.no
#SBATCH --mail-type=ALL

module load Python/3.9.6-GCCcore-11.2.0
srun python C:\Users\Desktop\python_file.py
```

There is a bit to unpack here:

1. First, "SBATCH" simply means "Submit batch". So the fourth and fifth line, for example, ```#SBATCH --account=ec0001``` and ```... job-name="hpc_job``` inform SLURM whose account is running the script and what you have chosen to call the job you have submitted. You can call the job whatever you want (for example "tromso_is_the_best"). In that case, you'll just submit the following batch: ```#SBATCH --job-name="tromso_is_the_best```). 

2. ```#SBATCH time=02:00:00``` sets a limit on the total run time of the job allocation. When the time limit is reached, each task in each job step will be terminated without processing your job. Remember, don't set the time limit for several days to be safe:  If the requested time limit exceeds the partition's time limit, the job will be left in a PENDING state (possibly indefinitely).

3. The three next lines tells SLURM how many tasks you want to run (in this case 1 task), how much memory you require (in this case 64GB RAM), how many CPUs you require per task (in this case 16 CPUs), and how many GPUs you require per task (in this case 2 GPUs). The more complicated your task is, the more CPUs, GPUs, and memory you will need. Remember, the more you require from the HPC, the longer you will have to wait in line for other jobs by other users to be processed.

4. By default both standard output and standard error are directed to a file where the "%j" in the name is replaced with the job allocation number (for example 017982). In this case, the ```#SBATCH --output=C:\Users\Desktop\%j.out``` will save a standard output file in your Desktop called 017982.out. The ```#SBATCH --output=C:\Users\Desktop\%j.err```, on the other hand, will produce a standard error file should your job fail for some reason.

5. If you provide a ```#SBATCH --mail-user= ...``` and ```#SBATCH --mail-type=ALL```, it means that you will receive an email if your job is completed, if an error has occurred etc. The mailtypes you can receive are: INVALID_DEPEND, BEGIN, END, FAIL, REQUEUE, and STAGE_OUT.

6. The two last lines loads the version of Python you want (if you want to load R, for example, then you will have to run ```module load R/4.0.2``` instead) while srun indicates where to find the python file (.py) to be executed.

## Useful SLURM commands

* *Log into FOX Supercomputer in command prompt:* ssh [Educloud username]@fox.educloud.no. **For example:** ```ssh ec-abcde@fox.educloud.no```

* *How write/modify your slurm script in FOX:* nano [name of slurm script]. **For example:** ```nano slurm_script.slrm```

* *Running your slurm script in FOX:* sbatch [name of your slurm script]. **For example:** ```sbatch slurm_script.slrm```

* *Checking job status after submitting:* scontrol show job [JOB ID]. **For example:** ```scontrol show job 170293```

* *Check status of all of your submitted jobs:* squeue --user=[username]. **For example:** ```squeue --user=ec-abcde```

* *Check current queue of submitted jobs by all users:* ```squeue```

* *Check the history of all your submitted jobs:* ```sacct```

* *Cancel your current job:* ```scancel```


## References

* IBM. [What is high-performance computing (HPC)?](https://www.ibm.com/topics/hpc)
* NetApp. [What is high performance computing?](https://www.netapp.com/data-storage/high-performance-computing/what-is-hpc/)
* SchedMD. [Slurm Documentation](https://slurm.schedmd.com/quickstart.html)
* University of Oslo. [Educloud Research](https://www.uio.no/english/services/it/research/platforms/edu-research/)
* University of Oslo. [Fox - High Performance Computing cluster for Educloud Research users](https://www.uio.no/english/services/it/research/hpc/fox/index.html)