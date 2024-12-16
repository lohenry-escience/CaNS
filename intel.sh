#!/bin/sh
#
# installs Intel oneAPI
#
INSTALL_DIR=${HOME}/software/intel/oneapi
#
# base toolkit
#
TOOLKIT=Base
VERSION=2024.0.0.49564
INSTALL_SCRIPT=l_${TOOLKIT}Kit_p_${VERSION}.sh
wget https://registrationcenter-download.intel.com/akdlm/IRC_NAS/20f4e6a1-6b0b-4752-b8c1-e5eacba10e01/${INSTALL_SCRIPT}
sh ./${INSTALL_SCRIPT} -a --silent --eula accept --install-dir ${INSTALL_DIR}; rm ${INSTALL_SCRIPT}
#
# HPC toolkit
#
TOOLKIT=HPC
VERSION=2024.0.0.49589
INSTALL_SCRIPT=l_${TOOLKIT}Kit_p_${VERSION}_offline.sh
wget https://registrationcenter-download.intel.com/akdlm/IRC_NAS/1b2baedd-a757-4a79-8abb-a5bf15adae9a/${INSTALL_SCRIPT}
sh ./${INSTALL_SCRIPT} -a --silent --eula accept --install-dir ${INSTALL_DIR}; rm ${INSTALL_SCRIPT}

#!/bin/bash
YEAR=2024
NVHPC_INSTALL_DIR=$HOME/software/nvidia/hpc_sdk
NVARCH=`uname -s`_`uname -m`; export NVARCH
NVCOMPILERS=$NVHPC_INSTALL_DIR; export NVCOMPILERS
MANPATH=$MANPATH:$NVCOMPILERS/$NVARCH/$YEAR/compilers/man; export MANPATH
PATH=$NVCOMPILERS/$NVARCH/$YEAR/compilers/bin:$PATH; export PATH

export PATH=$NVCOMPILERS/$NVARCH/$YEAR/comm_libs/mpi/bin:$PATH
export MANPATH=$MANPATH:$NVCOMPILERS/$NVARCH/$YEAR/mpi:$MANPATH
export PATH=$NVCOMPILERS/$NVARCH/$YEAR/profilers/Nsight_Systems/bin:$PATH
#
# communication libraries
#
export LD_LIBRARY_PATH=$NVHPC_INSTALL_DIR/$NVARCH/$YEAR/compilers/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$NVHPC_INSTALL_DIR/$NVARCH/$YEAR/comm_libs/mpi/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$NVHPC_INSTALL_DIR/$NVARCH/$YEAR/math_libs/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$NVHPC_INSTALL_DIR/$NVARCH/$YEAR/comm_libs/nccl/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$NVHPC_INSTALL_DIR/$NVARCH/$YEAR/comm_libs/nvshmem/lib:$LD_LIBRARY_PATH
