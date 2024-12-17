#!/bin/bash
TESTDIR=$(pwd)
CANSDIR=$(pwd)/../..
SRCDIR=$CANSDIR/src
RUNDIR=$CANSDIR/run
UTILSDIR=$CANSDIR/utils
echo $CANSDIR
cp $TESTDIR/test.py $RUNDIR/
cp $TESTDIR/input-*.nml $RUNDIR/ && cd $RUNDIR
cp $UTILSDIR/log_processing/python/process_log.py ./
mkdir data
chmod +x cans
mkdir data-oneStep data-twoSteps
# Running 1 step
echo "INFO: Running CaNS (1-step)"
mv input-oneStep.nml input.nml
sleep 1
#mpirun -n 4 --oversubscribe ./cans 1> log_file.log 2> err_file.log || { echo "CaNS execution failed"; exit 1; }
mpirun -n 4 --oversubscribe ./cans  | tee log_file.log
python process_log.py
mv log_file.log log_oneStep.log
mv err_file.log err_oneStep.log
cp -r data/* data-oneStep/
rm -rf data/*
# Running 2 step
echo "INFO: Running CaNS (2-step, first part)"
mv input-twoSteps-1.nml input.nml
sleep 1
mpirun -n 4 --oversubscribe ./cans 1> log_file.log 2> err_file.log  || { echo "CaNS execution failed"; exit 1; }
python process_log.py
mv log_file.log log_twoSteps_1.log
mv err_file.log err_twoSteps_1.log
cp -r data/* data-twoSteps/

echo "INFO: Running CaNS (2-step, second part)"
mv input-twoSteps-2.nml input.nml
sleep 1
mpirun -n 4 --oversubscribe ./cans 1> log_file.log 2> err_file.log  || { echo "CaNS execution failed"; exit 1; }
python process_log.py
mv log_file.log log_twoSteps_2.log
mv err_file.log err_twoSteps_2.log
cp -r data/* data-twoSteps/

cp $TESTDIR/*.* data-oneStep/
cp $TESTDIR/*.* data-twoSteps/

cp $UTILSDIR/read_binary_data/python/read_single_field_binary.py $RUNDIR
echo "INFO: Running comparison to a reference"
sleep 2
pytest test.py || { echo "pytest failed"; exit 1; }
rm -rf $RUNDIR/data/*.*
