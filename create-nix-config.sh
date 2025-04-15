#!/usr/bin/env bash

# Stop script on error
set -e

# Generate separator
SEP=$(printf "%0.s#" {1..80})

echo $SEP
read -p "Enter hostname: " NIX_HOSTNAME
#read -p "Enter full name: " NIX_FULLNAME
read -p "Enter username: " NIX_USER
#read -s -p "Enter Password: " NIX_PASSWORD
echo $SEP

NIX_CONFIG="/mnt/etc/nixos/configuration.nix"
NIX_HARDWARE="/mnt/etc/nixos/hardware-configuration.nix"
NIX_CONFIG_DIR="/root/nix-config/hosts/${NIX_HOSTNAME}"

# Generate a new config
nixos-generate-config --force --root /mnt

#echo "Updating bootloader config"
#sed -i '/boot.loader.grub.device/a\  boot.loader.grub.device = "/dev/vda";'  $NIX_CONFIG
echo $SEP
echo "Setting Hostname to $NIX_HOSTNAME"
sed -i "s/\# networking.hostName = \"nixos\"; /networking.hostName = \"$NIX_HOSTNAME\"; /" $NIX_CONFIG

#echo "Adding user config for $NIX_FULLNAME -- $NIX_USER"
#sed -i "/Define a user account/a\  users.users.$NIX_USER = { \n \
#    isNormalUser = true; \n \
#    description = \"$NIX_FULLNAME\"; \n \
#    initialPassword = \"$NIX_PASSWORD\"; \n \
#    extraGroups = [ \"networkmanager\" \"wheel\" \"audio\" \"input\" \"video\" ]; \n \
#    packages = with pkgs; [ \n \
#    \#  thunderbird \n \
#    ]; \n \
#    shell = pkgs.zsh; \n \
#  };" $NIX_CONFIG

#echo "Enabling ZSH"
#sed -i '/Define a user account/i\  # Enable ZSH \n  programs.zsh.enable = true; \n' $NIX_CONFIG

echo "Enabling experimental features for flakes"
sed -i '/boot loader/i\  # Enable experimental features \n  nix.settings.experimental-features = [ "nix-command" "flakes" ]; \n ' $NIX_CONFIG

echo "Enabling SSH"
sed -i "s/\# services.openssh.enable/services.openssh.enable/" $NIX_CONFIG

echo "Cleaning up default config"
sed -i '/Pick only one of/,/Enable the OpenSSH daemon/d' $NIX_CONFIG

sleep 2
echo $SEP

if [ -d "${NIX_CONFIG_DIR}" ]; then
  echo "Current configuration exists for ${NIX_HOSTNAME}."
  echo "Copying hardware-configuration.nix to ${NIX_CONFIG_DIR}"
  cp ${NIX_HARDWARE} ${NIX_CONFIG_DIR}/hardware-configuration.nix
else
  echo "No configuration exists for ${NIX_HOSTNAME}. Creating folder structure in nix-config repo"
  mkdir ${NIX_CONFIG_DIR}
  echo "Copying configuration.nix & hardware-configuration.nix to ${NIX_CONFIG_DIR}"
  cp ${NIX_CONFIG} ${NIX_CONFIG_DIR}/configuration.nix
  cp ${NIX_HARDWARE} ${NIX_CONFIG_DIR}/hardware-configuration.nix
fi
echo $SEP
#echo "Going into /mnt and running nixos-install --no-root-password"
#cd /mnt
#nixos-install --no-root-password
#
#sleep 5
#
#nixos-enter --root /mnt -c "passwd -e $NIX_USER"
#
#sleep 5
#
#echo "Removing initial password from config file"
#sed -i "/initialPassword/d" $NIX_CONFIG
echo $SEP
echo "Exporting vars for install script"

export NIX_HOSTNAME=${NIX_HOSTNAME}
export NIX_USER=${NIX_USER}

echo $SEP

echo "The hostname is: ${NIX_HOSTNAME}"
echo "The user is: ${NIX_USER}"

echo $SEP

echo "Initial configuration completed."
echo "Please update the ${NIX_CONFIG_DIR}/configuration.nix with any changes and add the system to flake.nix"
echo "Run the install-nix.sh script in the nix-config folder to install the os"

echo $SEP
