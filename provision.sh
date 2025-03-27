#!/usr/bin/env bash

echo "Erasing disk with dd"
dd if=/dev/zero of=/dev/vda bs=1M count=1

echo "Creating msdos partition table"
parted -s /dev/vda -- mklabel msdos
sleep 2

echo "Creating primary partition"
parted -s /dev/vda -- mkpart primary 1MiB 100%
sleep 2
parted -s /dev/vda -- set 1 boot on
sleep 2
mkfs.xfs -f -L nixos /dev/vda1

#boot_id=$(blkid -o value -s UUID /dev/vda1)
#fs_id=$(blkid -o value -s UUID /dev/vda2)

#echo "boot device: $boot_id"
#echo "root device: $fs_id"

mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot

echo "Partitioned msdos disk and mounted to /mnt."

echo "Generating Nix Configuration"
nixos-generate-config --force --root /mnt
