#!/bin/bash
# Submit this script with: sbatch <this-filename>
#SBATCH --time=24:00:00 # walltime
#SBATCH --ntasks=1 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1 # number of nodes
#SBATCH --cpus-per-task=1 # number of processors per task
#SBATCH -J "fsa1" # job name
## /SBATCH -p general # partition (queue)
#SBATCH -o fsa1-slurm.%N.%j.out # STDOUT
#SBATCH -e fsa1-slurm.%N.%j.err # STDERR
# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

python -u -c "import PyHipp as pyh; \
import DataProcessingTools as DPT; \
import time; \
lfall = DPT.objects.processDirs(dirs=None, exclude=['*array02*', '*array03*', '*array04*'], objtype=pyh.FreqSpectrum); \ lfall.save(); \
hfall = DPT.objects.processDirs(dirs=None, exclude=['*array02*', '*array03*', '*array04*'], objtype=pyh.FreqSpectrum, loadHighPass=True, pointsPerWindow=3000); \
hfall.save(); \
print(time.localtime());"

aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:244260284409:awsnotify --message "FSA1JobDone"

