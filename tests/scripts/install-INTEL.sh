#!/bin/sh
#
# installs INTEL compiler
# Usage: ./install-INTEL.sh [INTEL_VERSION=intel_version] [HPC_VERSION=hpc_version]
#
INSTALL_DIR=${HOME}/software/intel/oneapi
#
# Get packages
#
sudo apt-get install gfortran libopenmpi-dev libfftw3-dev

# download the key to system keyring
wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
| gpg --dearmor | sudo tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null

# add signed entry to apt sources and configure the APT client to use Intel repository:
echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list

sudo apt update
sudo apt install intel-oneapi-hpc-toolkit

sudo apt install intel-oneapi-base-toolkit
#sudo apt install Intel-fortran-essentials

echo "Done"
source /opt/intel/oneapi/setvars.sh
