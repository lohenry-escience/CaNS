INSTALL_DIR=${HOME}/software/nvidia
mkdir -p ${INSTALL_DIR}
cd ${INSTALL_DIR}

wget --progress=dot:mega  https://developer.download.nvidia.com/hpc-sdk/nvhpc_24.11_Linux_x86_64.tar.gz
echo "LoH: After download 1"
du -hs .
tar -xzf nvhpc_24.11_Linux_x86_64.tar.gz
echo "LoH: After unpacking"
du -hs .
rm nvhpc_24.11_Linux_x86_64.tar.gz
echo "LoH: After removal"
du -hs .
cd nvhpc_24.11_Linux_x86_64
./install --silent --accept-license --components=nvc,nvfortran
