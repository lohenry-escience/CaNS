#!/bin/bash

set -e # Exit immediately if any command fails

TESTDIR=$(pwd)
CANSDIR=$(pwd)/../..
SRCDIR=$CANSDIR/src
RUNDIR=$CANSDIR/run
UTILSDIR=$CANSDIR/utils
cd $RUNDIR
ls -al
chmod +x cans
mkdir -p data
sleep 2
cp $TESTDIR/input.nml $RUNDIR
echo "INFO: Running CaNS"
sleep 2
#mpirun -n 4 --oversubscribe ./cans 1> log_file.log 2> err_log.log || { echo "CaNS execution failed"; exit 1; }
mpirun -n 4 --oversubscribe ./cans || { echo "CaNS execution failed"; exit 1; }
if [[ ! -f $TESTDIR/test.py ]]; then
    echo "test.py not found in $TESTDIR"
    exit 1
fi

cp $TESTDIR/*.* ./ && cp $UTILSDIR/read_binary_data/python/read_single_field_binary.py ./ && cp $UTILSDIR/log_processing/python/process_log.py ./
python process_log.py
echo "INFO: Running comparison to a reference"
sleep 2
pytest test.py || { echo "pytest failed"; exit 1; }
rm -rf $RUNDIR/data/*.*
