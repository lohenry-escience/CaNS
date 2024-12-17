#!/bin/sh
#
# installs INTEL compiler
#
INSTALL_DIR=${HOME}/software/intel/oneapi
#
# Get packages
#
sudo apt-get install gfortran libopenmpi-dev libfftw3-dev
#
# base toolkit
#
TOOLKIT=Base
VERSION=2024.0.0.49564
INSTALL_SCRIPT=l_${TOOLKIT}Kit_p_${VERSION}.sh
wget --progress=dot:mega https://registrationcenter-download.intel.com/akdlm/IRC_NAS/20f4e6a1-6b0b-4752-b8c1-e5eacba10e01/${INSTALL_SCRIPT}
sh ./${INSTALL_SCRIPT} -a --silent --eula accept --install-dir ${INSTALL_DIR}
. ${HOME}/software/intel/oneapi/setvars.sh
rm ${INSTALL_SCRIPT}
rm -rf ${INSTALL_DIR}/documentation ${INSTALL_DIR}/samples
#
# HPC toolkit
#
TOOLKIT=HPC
VERSION=2024.0.0.49589
INSTALL_SCRIPT=l_${TOOLKIT}Kit_p_${VERSION}_offline.sh
wget --progress=dot:giga https://registrationcenter-download.intel.com/akdlm/IRC_NAS/1b2baedd-a757-4a79-8abb-a5bf15adae9a/${INSTALL_SCRIPT}
sh ./${INSTALL_SCRIPT} -a --silent --eula accept --install-dir ${INSTALL_DIR} --components intel.oneapi.lin.ifort-compiler:intel.oneapi.lin.mpi.devel
rm ${INSTALL_SCRIPT}
rm -rf ${INSTALL_DIR}/installercache

