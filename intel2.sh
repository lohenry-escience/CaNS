INSTALL_DIR=${HOME}/software/intel/oneapi
TOOLKIT=Base
VERSION=2024.0.0.49564
INSTALL_SCRIPT=l_${TOOLKIT}Kit_p_${VERSION}.sh
wget --progress=dot:mega https://registrationcenter-download.intel.com/akdlm/IRC_NAS/20f4e6a1-6b0b-4752-b8c1-e5eacba10e01/${INSTALL_SCRIPT}

sh ./${INSTALL_SCRIPT} -a --silent --eula accept --install-dir ${INSTALL_DIR}; rm ${INSTALL_SCRIPT}
echo "LoH: After download 1"
echo "===================="
cat ${HOME}/software/intel/oneapi/setvars.sh
echo "===================="
. ${HOME}/software/intel/oneapi/setvars.sh
du -hs $INSTALL_DIR

rm -rf ${INSTALL_DIR}/documentation ${INSTALL_DIR}/samples

echo "LoH: After INTEL"
du -hs $INSTALL_DIR

TOOLKIT=HPC
VERSION=2024.0.0.49589
INSTALL_SCRIPT=l_${TOOLKIT}Kit_p_${VERSION}_offline.sh
wget --progress=dot:mega https://registrationcenter-download.intel.com/akdlm/IRC_NAS/1b2baedd-a757-4a79-8abb-a5bf15adae9a/${INSTALL_SCRIPT}
sh ./${INSTALL_SCRIPT} -a --silent --eula accept --install-dir ${INSTALL_DIR} --components intel.oneapi.lin.ifort-compiler intel.oneapi.lin.mpi; rm ${INSTALL_SCRIPT}
#sh ./${INSTALL_SCRIPT} -a --silent --eula accept --install-dir ${INSTALL_DIR}; rm ${INSTALL_SCRIPT}
ls $HOME/software/nvidia/hpc_sdk

rm -rf ${INSTALL_DIR}/installercache ${INSTALL_DIR}/documentation
rm -rf ${INSTALL_DIR}/documentation ${INSTALL_DIR}/samples

echo "LoH: After second cleanup"
ls /home/runner/
ls /home/runner/work/CaNS
ls /home/runner/work/CaNS/CaNS

du -hs /home/runner
du -hs /home/runner/*

ifx --version
ls ${INSTALL_DIR}
ls ${INSTALL_DIR}/mpi/latest
unset NVCOMPILERS
unset MANPATH
unset PATH
unset LD_LIBRARY_PATH
. ${HOME}/software/intel/oneapi/setvars.sh

mpiifort --version
