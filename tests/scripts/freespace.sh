echo "INFO: Heaviest packages left are:"
dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n | tail -n 30

echo 'INFO: Removing some packages we do not need'

df -h

packages=(
    '^apache.*'
    '^aspnetcore.*'
    '^azure.*'
    '^containerd.*'
    '^docker.*'
    '^dotnet.*'
    '^firebird.*'
    '^firefox.*'
    '^google.*'
    '^kubectl.*'
    '^libllvm.*'
    '^linux-azure.*'
    '^llvm.*'
    '^microsoft.*'
    '^mongodb.*'
    '^mono-.*'
    '^monodoc-.*'
    '^mysql.*'
    '^openjdk.*'
    '^php.*'
    '^powershell.*'
    '^snapd.*'
    '^temurin.*'
)

# Loop through each package pattern and remove it
for pkg in ${packages[@]}; do
    echo "INFO: Removing ${pkg}"
    sudo apt-get purge -y $pkg > /dev/null 2>&1
done
sudo apt-get autoremove -y  > /dev/null 2>&1
echo "INFO: Heaviest packages left are now:"
dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n | tail -n 30
echo "INFO: Space on device is now:"
df -h
free -h
swapon --summary
swapon --show

#sudo fallocate -l 5G /swapfile2
#sudo chmod 600 /swapfile2
#sudo mkswap /swapfile2
#sudo swapon /swapfile2
#sudo sysctl vm.swappiness=10
#sudo swapoff /swapfile
#sudo rm /swapfile
