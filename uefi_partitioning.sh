#!/usr/bin/env bash

# Stop on error
set -e

DISK=$1

if [[ "$DISK" == *"nvme"* ]]; then

  PART="${DISK}p"

else

  PART=${DISK}

fi

echo "Partitoning UEFI Disk"

echo "Erasing all partitions on ${DISK}"
wipefs -a ${DISK}

#echo "Erasing mbr with dd"
#dd if=/dev/zero of=$DISK bs=1M count=1

echo "Creating GPT partition table"
parted -s ${DISK} -- mklabel gpt

echo "Creating ESP partition"
parted -s ${DISK} -- mkpart ESP fat32 1MiB 1GiB
parted -s ${DISK} -- set 1 boot on
sleep 1
mkfs.vfat -n boot "${PART}1"

echo "Creating Data partition"
parted -s ${DISK} -- mkpart nixos 1GiB 100%
sleep 1
mkfs.btrfs -f -L nixos "${PART}2"

sleep 2
# Placeholder for encryption settings
#

echo "Create btrfs subvolumes"
mount "${PART}2" /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@nix
btrfs subvolume create /mnt/@logs
umount /mnt

sleep 2

echo "Mount boot and btrfs subvolumes for installation"
mount -o noatime,subvol=@ /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/{boot,home,nix,var/log}
mount /dev/disk/by-label/boot /mnt/boot
mount -o subvol=@home /dev/disk/by-label/nixos /mnt/home
mount -o noatime,compress=zstd,subvol=@ /dev/disk/by-label/nixos /mnt/nix
mount -o noatime,compress=zstd,subvol=@ /dev/disk/by-label/nixos /mnt/var/log

echo "Partitioned GPT disk and mounted to /mnt"
