#!/bin/bash
# Submit this script with: sbatch vpall-slurm.sh
#SBATCH --time=1:00:00 # walltime
#SBATCH --ntasks=1 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1 # number of nodes
#SBATCH -J "vpall" # job name
## /SBATCH -p general # partition (queue)
#SBATCH -o vpall-slurm.%N.%j.out # STDOUT
#SBATCH -e vpall-slurm.%N.%j.err # STDERR
# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

python -u -c "import PyHipp as pyh; \
import DataProcessingTools as DPT; \
import subprocess; \
a = subprocess.check_output('cat cells.txt', shell=True); \
cdirs = a.split(); \
vp1 = DPT.objects.processDirs(dirs=cdirs, objtype=pyh.VMPlaceCell); \
vp1.save(); \
vp2 = DPT.objects.processDirs(dirs=cdirs, objtype=pyh.VMPlaceCell, GridSteps=5); vp2.save();"

