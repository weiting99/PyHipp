#!/bin/bash
# Submit this script with: sbatch fwall-slurm.sh
#SBATCH --time=1:00:00 # walltime
#SBATCH --ntasks=1 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1 # number of nodes
#SBATCH -J "fwall" # job name
## /SBATCH -p general # partition (queue)
#SBATCH -o fwall-slurm.%N.%j.out # STDOUT
#SBATCH -e fwall-slurm.%N.%j.err # STDERR
# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE


python -u -c "import PyHipp as pyh; \
import DataProcessingTools as DPT; \
import subprocess; \
a = subprocess.check_output('cat c1617.txt', shell=True); \
chdirs = a.split(); \
lfall = DPT.objects.processDirs(dirs=chdirs, objtype=pyh.FreqSpectrum); \
lfall.save(); \
hfall =DPT.objects.processDirs(dirs=chdirs, objtype=pyh.FreqSpectrum, loadHighPass=True, pointsPerWindow=3000); \
hfall.save(); \
wfall =DPT.objects.processDirs(dirs=chdirs, objtype=pyh.Waveform); \
wfall.save();"

