# store owner of $GITHUB_WORKSPACE in case the action deletes it
WORKSPACE_OWNER="$(stat -c '%U:%G' "${GITHUB_WORKSPACE}")"

# ensure mount path exists before the action
sudo mkdir -p "${BUILD_MOUNT_PATH}"
sudo find "${BUILD_MOUNT_PATH}" -maxdepth 0 ! -empty -exec echo 'WARNING: directory [{}] is not empty, data loss might occur. Content:' \; -exec ls -al "{}" \;

VG_NAME=buildvg

# github runners have an active swap file in /mnt/swapfile
# we want to reuse the temp disk, so first unmount swap and clean the temp disk
echo "Unmounting and removing swap file."
sudo swapoff -a
sudo rm -f /mnt/swapfile

echo "Creating LVM Volume."
echo "  Creating LVM PV on root fs."
# create loop pv image on root fs
ROOT_RESERVE_KB=$(expr 25000 \* 1024)
ROOT_FREE_KB=$(df --block-size=1024 --output=avail / | tail -1)
ROOT_LVM_SIZE_KB=$(expr $ROOT_FREE_KB - $ROOT_RESERVE_KB)
ROOT_LVM_SIZE_BYTES=$(expr $ROOT_LVM_SIZE_KB \* 1024)
sudo touch "/pv.img" && sudo fallocate -z -l "${ROOT_LVM_SIZE_BYTES}" "/pv.img"
export ROOT_LOOP_DEV=$(sudo losetup --find --show "/pv.img")
sudo pvcreate -f "${ROOT_LOOP_DEV}"

# create pv on temp disk
echo "  Creating LVM PV on temp fs."
TMP_RESERVE_KB=$(expr 100 \* 1024)
TMP_FREE_KB=$(df --block-size=1024 --output=avail /mnt | tail -1)
TMP_LVM_SIZE_KB=$(expr $TMP_FREE_KB - $TMP_RESERVE_KB)
TMP_LVM_SIZE_BYTES=$(expr $TMP_LVM_SIZE_KB \* 1024)
sudo touch "/mnt/tmp-pv.img" && sudo fallocate -z -l "${TMP_LVM_SIZE_BYTES}" "/mnt/tmp-pv.img"
export TMP_LOOP_DEV=$(sudo losetup --find --show "/mnt/tmp-pv.img")
sudo pvcreate -f "${TMP_LOOP_DEV}"

# create volume group from these pvs
sudo vgcreate "${VG_NAME}" "${TMP_LOOP_DEV}" "${ROOT_LOOP_DEV}"

echo "Recreating swap"
# create and activate swap
sudo lvcreate -L "30000M" -n swap "${VG_NAME}"
sudo mkswap "/dev/mapper/${VG_NAME}-swap"
sudo swapon "/dev/mapper/${VG_NAME}-swap"

echo "Creating build volume"
# create and mount build volume
sudo lvcreate -l 100%FREE -n buildlv "${VG_NAME}"
if [[ false == 'true' ]]; then
    sudo mkfs.ext4 -m0 "/dev/mapper/${VG_NAME}-buildlv"
else
    sudo mkfs.ext4 -Enodiscard -m0 "/dev/mapper/${VG_NAME}-buildlv"
fi
sudo mount "/dev/mapper/${VG_NAME}-buildlv" "${BUILD_MOUNT_PATH}"
sudo chown -R "runner:runner" "${BUILD_MOUNT_PATH}"

# if build mount path is a parent of $GITHUB_WORKSPACE, and has been deleted, recreate it
if [[ ! -d "${GITHUB_WORKSPACE}" ]]; then
    sudo mkdir -p "${GITHUB_WORKSPACE}"
    sudo chown -R "${WORKSPACE_OWNER}" "${GITHUB_WORKSPACE}"
fi
