#!/bin/bash
# Submit this script with: sbatch rpllfpf-slurm.sh
#SBATCH --time=1:00:00 # walltime
#SBATCH --ntasks=1 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1 # number of nodes
#SBATCH -J "rpllfpf" # job name
## /SBATCH -p general # partition (queue)
#SBATCH -o rpllfpf-slurm.%N.%j.out # STDOUT
#SBATCH -e rpllfpf-slurm.%N.%j.err # STDERR
# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

python -u -c "import PyHipp as pyh; import time; pyh.RPLLFP(saveLevel = 1);
pyh.FreqSpectrum(saveLevel=1); print(time.localtime());"
