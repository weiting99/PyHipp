#!/bin/bash
python -u -c "import PyHipp as pyh; \
import DataProcessingTools as DPT; \
import time; \
pyh.RPLLFP(saveLevel=1); \
lfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*', '*mountains*'], objtype=pyh.FreqSpectrum, saveLevel=1); \
lfall.save(); \
hfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*', '*mountains*'], objtype=pyh.FreqSpectrum, loadHighPass=True, pointsPerWindow=3000, saveLevel=1); \
hfall.save(); \
print(time.localtime());"

aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:244260284409:awsnotify --message "FSJobDone"


