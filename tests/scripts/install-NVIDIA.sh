#!/bin/sh
#
# installs NVHPC SDK
#
export NVHPC_SILENT=true
export NVHPC_INSTALL_TYPE=single
export NVHPC_INSTALL_DIR=$HOME/software/nvidia/hpc_sdk
mkdir -p ${NVHPC_INSTALL_DIR}
cd ${NVHPC_INSTALL_DIR}
NVVERSION_A=24.3
NVVERSION_B=$(echo $NVVERSION_A | sed 's/\.//g')
CUDA_VERSION=multi
YEAR=2024
NVARCH=`uname -s`_`uname -m`
wget --no-verbose https://developer.download.nvidia.com/hpc-sdk/${NVVERSION_A}/nvhpc_${YEAR}_${NVVERSION_B}_${NVARCH}_cuda_${CUDA_VERSION}.tar.gz
echo "LoH: After download 1"
echo ${HOME}
ls /home/runner/
ls /home/runner/work/CaNS
ls /home/runner/work/CaNS/CaNS

du -hs /home/runner
du -hs /home/runner/*


gzip -d nvhpc_${YEAR}_${NVVERSION_B}_${NVARCH}_cuda_${CUDA_VERSION}.tar.gz | tar -xvf
echo "LoH: After unpacking"
du -hs .
rm nvhpc_${YEAR}_${NVVERSION_B}_${NVARCH}_cuda_${CUDA_VERSION}.tar.gz
echo "LoH: After removal"
du -hs .
./nvhpc_${YEAR}_${NVVERSION_B}_${NVARCH}_cuda_${CUDA_VERSION}/install --silent --accept-license --components=nvc,nvfortran
