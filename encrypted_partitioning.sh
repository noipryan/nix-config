#!/usr/bin/env bash

# DISK=$(lsblk -o NAME,TYPE | grep -v zram | awk '$2=="disk" {print "/dev/"$1}')

DISK=$1

MAPPER="/dev/mapper/nixos-root"

if [[ "$DISK" == *"nvme"* ]]; then

  PART="p"

else

  PART=$DISK

fi

echo "Partitoning encrypted UEFI Disk"

echo "Erasing all partitions on ${DISK}"
wipefs -a $DISK

echo "Erasing mbr with dd"
dd if=/dev/zero of=$DISK bs=1M count=1

echo "Creating GPT partition table"
parted -s $DISK -- mklabel gpt

echo "Creating ESP partition"
parted -s $DISK -- mkpart ESP fat32 1MiB 1GiB
parted -s $DISK -- set 1 boot on

sleep 1

mkfs.vfat -n boot "${PART}1"

echo "Creating Data partition"
parted -s $DISK -- mkpart nixos 1GiB 100%

sleep 1

# Create encrypted volume
echo "Creating encrypted volume"
cryptsetup -y -v luksFormat "${PART}2"
cryptsetup open "${PART}2" nixos-root

# Format encrypted volume to btrfs

echo "Formating ${MAPPER} to BTRFS"
mkfs.btrfs -f -L nixos "${MAPPER}"

sleep 2

echo "Creating btrfs subvolumes"
mount "${MAPPER}" /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@nix
btrfs subvolume create /mnt/@logs
umount /mnt

sleep 2

echo "Mounting boot and btrfs subvolumes for installation"
mount -o noatime,subvol=@ ${MAPPER} /mnt
mkdir -p /mnt/{boot,home,nix,var/log}
mount /dev/disk/by-label/boot /mnt/boot
mount -o subvol=@home ${MAPPER} /mnt/home
mount -o noatime,compress=zstd,subvol=@ ${MAPPER} /mnt/nix
mount -o noatime,compress=zstd,subvol=@ ${MAPPER} /mnt/var/log

echo "Partitioned GPT disk and mounted to /mnt for installation"
