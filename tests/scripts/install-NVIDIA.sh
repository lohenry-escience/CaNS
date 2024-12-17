#!/bin/sh
#
# installs NVHPC SDK
# Usage: ./install-NVIDIA.sh [YEAR=YEAR] [VERSION=VERSION]
#
export NVHPC_INSTALL_DIR=$HOME/software/nvidia/hpc_sdk
mkdir -p $NVHPC_INSTALL_DIR
# Check disk space
AVAILABLE_SPACE=$(df --output=avail -BG "$NVHPC_INSTALL_DIR" | tail -1 | tr -d 'G ')
echo "INFO: Checking available space... "${AVAILABLE_SPACE}"Gb found on "$NVHPC_INSTALL_DIR
if [ "$AVAILABLE_SPACE" -ge "20" ]; then
    echo "INFO: Should be enough for NVIDIA install"
else
    echo "ERROR: We should have at least 20Gb free for NVIDIA installation. Abort."
    #    exit 1
fi
# Read arguments
unset VERSION
unset YEAR
for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)
   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"
   export "$KEY"="$VALUE"
done
#
# Get packages
#
sudo apt-get install gfortran libopenmpi-dev libfftw3-dev
#
# Get NVHPC
#
export NVHPC_SILENT=true
export NVHPC_INSTALL_TYPE=single
NVVERSION_A=24.3 #default
NVYEAR=2024 #default
CUDA_VERSION=multi # default

if [ -n "$VERSION" ]
then
    echo "INFO: Changing the version from "${NVVERSION_A}" to "${VERSION} 
    NVVERSION_A=${VERSION}
fi
if [ -n "$YEAR" ]
then
    echo "INFO: Changing the year from "${NVYEAR}" to "${YEAR} 
    NVYEAR=${YEAR}
fi

NVVERSION_B=$(echo $NVVERSION_A | sed 's/\.//g')
NVARCH=`uname -s`_`uname -m`
wget --progress=dot:giga https://developer.download.nvidia.com/hpc-sdk/${NVVERSION_A}/nvhpc_${NVYEAR}_${NVVERSION_B}_${NVARCH}_cuda_${CUDA_VERSION}.tar.gz
tar xpzf nvhpc_${NVYEAR}_${NVVERSION_B}_${NVARCH}_cuda_${CUDA_VERSION}.tar.gz
./nvhpc_${NVYEAR}_${NVVERSION_B}_${NVARCH}_cuda_${CUDA_VERSION}/install
