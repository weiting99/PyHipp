#!/bin/bash
# Submit this script with: sbatch rplhpsfw-slurm.sh
#SBATCH --time=24:00:00 # walltime
#SBATCH --ntasks=1 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1 # number of nodes
#SBATCH -J "rplhpsfw" # job name
## /SBATCH -p general # partition (queue)
#SBATCH -o rplhpsfw-slurm.%N.%j.out # STDOUT
#SBATCH -e rplhpsfw-slurm.%N.%j.err # STDERR
# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

/data/miniconda3/bin/conda init
source ~/.bashrc
envarg=`/data/src/PyHipp/envlist.py`
conda activate $envarg
python -u -c "import PyHipp as pyh; import DataProcessingTools as DPT; import
time; pyh.RPLHighPass(saveLevel = 1); from PyHipp import mountain_batch;
mountain_batch.mountain_batch(); from PyHipp import export_mountain_cells;

export_mountain_cells.export_mountain_cells();
pyh.FreqSpectrum(loadHighPass=True, pointsPerWindow=3000, saveLevel=1);
pyh.Waveform(saveLevel=1); DPT.objects.processDirs(dirs=None,
objtype=pyh.VMPlaceCell, saveLevel=1); DPT.objects.processDirs(dirs=None,
objtype=pyh.VMPlaceCell, GridSteps=5, saveLevel=1); print(time.localtime());"
conda deactivate
/data/src/PyHipp/envlist.py $envarg
