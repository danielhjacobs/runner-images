#!/bin/bash -e
################################################################################
##  File:  install-mono.sh
##  Desc:  Install Mono
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

os_label=$(lsb_release -cs)

# There are no packages for Ubuntu 22 in the repo, but developers confirmed that packages from Ubuntu 20 should work
if is_ubuntu22; then
    os_label="focal"
fi

# Test to see if the software in question is already installed, if not install it
# wget "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF" -O out && sudo apt-key add out && rm out

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-$os_label main" | tee /etc/apt/sources.list.d/mono-official-stable.list
apt-get update
apt-get install -y --no-install-recommends apt-transport-https mono-complete nuget

rm /etc/apt/sources.list.d/mono-official-stable.list
rm -f /etc/apt/sources.list.d/mono-official-stable.list.save

echo "mono https://download.mono-project.com/repo/ubuntu stable-$os_label main" >> $HELPER_SCRIPTS/apt-sources.txt

invoke_tests "Tools" "Mono"
