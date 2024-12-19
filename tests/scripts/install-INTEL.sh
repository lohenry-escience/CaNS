#!/bin/sh
#
# installs INTEL compiler
# Usage: ./install-INTEL.sh [INTEL_VERSION=intel_version] [HPC_VERSION=hpc_version]
#
INSTALL_DIR=${HOME}/software/intel/oneapi
#
# Get packages
#
sudo apt-get install gfortran libopenmpi-dev libfftw3-dev pax-utils
# Read arguments
unset INTEL_VERSION
unset HPC_VERSION
for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)
   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"
   export "$KEY"="$VALUE"
done
#
# base toolkit
#
TOOLKIT=Base
VERSION=2024.0.0.49564 #Default
if [ -n "$INTEL_VERSION" ]
then
    echo "INFO: Changing the version from "${VERSION}" to "${INTEL_VERSION} 
    VERSION=${INTEL_VERSION}
fi
INSTALL_SCRIPT=l_${TOOLKIT}Kit_p_${VERSION}.sh
# TODO: get more resilient URL
wget --progress=dot:mega https://registrationcenter-download.intel.com/akdlm/IRC_NAS/20f4e6a1-6b0b-4752-b8c1-e5eacba10e01/${INSTALL_SCRIPT}
sh ./${INSTALL_SCRIPT} -a --silent --eula accept --install-dir ${INSTALL_DIR}
. ${HOME}/software/intel/oneapi/setvars.sh
rm ${INSTALL_SCRIPT}
rm -rf ${INSTALL_DIR}/documentation ${INSTALL_DIR}/samples
#
# HPC toolkit
#
TOOLKIT=HPC
HPC_VERSION=2024.0.0.49589 #Default
if [ -n "$HPC_VERSION" ]
then
    echo "INFO: Changing the version from "${VERSION}" to "${HPC_VERSION} 
    VERSION=${HPC_VERSION}
fi

INSTALL_SCRIPT=l_${TOOLKIT}Kit_p_${VERSION}_offline.sh
# TODO: get more resilient URL
wget --progress=dot:giga https://registrationcenter-download.intel.com/akdlm/IRC_NAS/1b2baedd-a757-4a79-8abb-a5bf15adae9a/${INSTALL_SCRIPT}
sh ./${INSTALL_SCRIPT} -a --silent --eula accept --install-dir ${INSTALL_DIR} --components intel.oneapi.lin.ifort-compiler:intel.oneapi.lin.mpi.devel
rm ${INSTALL_SCRIPT}
rm -rf ${INSTALL_DIR}/installercache

