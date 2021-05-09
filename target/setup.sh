#!/bin/bash -eu

arch > /mimic-cross/arch
HOST_ARCH=$(cat /host/mimic-cross/arch)

ln -s $(realpath /host/usr/lib/$HOST_ARCH-linux-gnu /usr/lib/)
if [[ $(realpath /lib) != /usr/lib ]]; then
    ln -s /host/lib/$HOST_ARCH-linux-gnu/ /lib/
fi

mkdir -p /lib64
ln -s /host/lib64/ld-linux-x86-64.* /lib64/
ln -s /host/usr/aarch64-linux-gnu /usr

mkdir -p /var/log/mimic-cross
mkdir -p /mimic-cross/deploy/host
mkdir -p /mimic-cross/deploy/target

cp /mimic-cross/bin/apt-get /usr/local/bin/
cp /mimic-cross/bin/mimic-deploy /usr/local/bin/

. /mimic-cross/hostize_installed_packages.sh
