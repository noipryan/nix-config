#!/usr/bin/env bash

# Stop on error
set -e

DISK=$1

#echo "Erasing disk with dd"
#dd if=/dev/zero of=$DISK bs=1M count=1

echo "Creating msdos partition table"
parted -s $DISK -- mklabel msdos
sleep 2

echo "Creating primary partition"
parted -s $DISK -- mkpart primary 1MiB 100%
sleep 2
parted -s $DISK -- set 1 boot on
sleep 2
mkfs.xfs -f -L nixos $DISK1

#boot_id=$(blkid -o value -s UUID $DISK1)
#fs_id=$(blkid -o value -s UUID $DISK2)

#echo "boot device: $boot_id"
#echo "root device: $fs_id"

mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot

echo "Partitioned msdos disk and mounted to /mnt."
