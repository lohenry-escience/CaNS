INSTALL_DIR=${HOME}/software/intel/oneapi
TOOLKIT=Base
VERSION=2024.0.0.49564
INSTALL_SCRIPT=l_${TOOLKIT}Kit_p_${VERSION}.sh
wget --progress=dot:mega https://registrationcenter-download.intel.com/akdlm/IRC_NAS/20f4e6a1-6b0b-4752-b8c1-e5eacba10e01/${INSTALL_SCRIPT}

sh ./${INSTALL_SCRIPT} -a --silent --eula accept --install-dir ${INSTALL_DIR}; rm ${INSTALL_SCRIPT}
echo "LoH: After download 1"
. ${HOME}/software/intel/oneapi/setvars.sh
du -hs $INSTALL_DIR

rm -rf ${INSTALL_DIR}/documentation ${INSTALL_DIR}/samples

echo "LoH: After INTEL"
du -hs $INSTALL_DIR

TOOLKIT=HPC
VERSION=2024.0.0.49589
INSTALL_SCRIPT=l_${TOOLKIT}Kit_p_${VERSION}_offline.sh
wget --progress=dot:mega https://registrationcenter-download.intel.com/akdlm/IRC_NAS/1b2baedd-a757-4a79-8abb-a5bf15adae9a/${INSTALL_SCRIPT}
sh ./${INSTALL_SCRIPT} -a --silent --eula accept --install-dir ${INSTALL_DIR} --components intel.oneapi.lin.ifort-compiler; rm ${INSTALL_SCRIPT}

echo "LoH: After NVIDIA"
du -hs $INSTALL_DIR


NVHPC_DIR=$HOME/software/nvidia/hpc_sdk
YEAR=2024
NVARCH=$(uname -s)_$(uname -m)
COMPILER_PATH=$NVHPC_DIR/$NVARCH/$YEAR/compilers
rm -rf $COMPILER_PATH/libacc* $COMPILER_PATH/libc++* $COMPILER_PATH/libcuda* $COMPILER_PATH/nvvm

echo "LoH: After first cleanup"
du -hs $INSTALL_DIR

YEAR=2024
NVHPC_INSTALL_DIR=$HOME/software/nvidia/hpc_sdk
NVARCH=`uname -s`_`uname -m`; export NVARCH
NVCOMPILERS=$NVHPC_INSTALL_DIR; export NVCOMPILERS


rm -rf ${INSTALL_DIR}/installercache ${INSTALL_DIR}/documentation
rm -rf ${INSTALL_DIR}/documentation ${INSTALL_DIR}/samples
rm -rf ${NVHPC_DIR}/Linux_*/*/doc ${NVHPC_DIR}/Linux_*/*/examples

echo "LoH: After second cleanup"
du -hs $INSTALL_DIR

MANPATH=$MANPATH:$NVCOMPILERS/$NVARCH/$YEAR/compilers/man; export MANPATH
PATH=$NVCOMPILERS/$NVARCH/$YEAR/compilers/bin:$PATH; export PATH

export PATH=$NVCOMPILERS/$NVARCH/$YEAR/comm_libs/mpi/bin:$PATH
export MANPATH=$MANPATH:$NVCOMPILERS/$NVARCH/$YEAR/mpi:$MANPATH
export PATH=$NVCOMPILERS/$NVARCH/$YEAR/profilers/Nsight_Systems/bin:$PATH

export LD_LIBRARY_PATH=$NVHPC_INSTALL_DIR/$NVARCH/$YEAR/compilers/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$NVHPC_INSTALL_DIR/$NVARCH/$YEAR/comm_libs/mpi/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$NVHPC_INSTALL_DIR/$NVARCH/$YEAR/math_libs/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$NVHPC_INSTALL_DIR/$NVARCH/$YEAR/comm_libs/nccl/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$NVHPC_INSTALL_DIR/$NVARCH/$YEAR/comm_libs/nvshmem/lib:$LD_LIBRARY_PATH

. ${HOME}/software/intel/oneapi/setvars.sh

