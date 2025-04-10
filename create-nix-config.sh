#!/usr/bin/env bash

NIX_CONFIG="/mnt/etc/nixos/configuration.nix"
read -p "Enter hostname: " NIX_HOSTNAME
#read -p "Enter full name: " NIX_FULLNAME
#read -p "Enter username: " NIX_USER
#read -s -p "Enter Password: " NIX_PASSWORD

# Generate a new config
nixos-generate-config --force --root /mnt

echo "Updating bootloader config"
sed -i '/boot.loader.grub.device/a\  boot.loader.grub.device = "/dev/vda";'  $NIX_CONFIG

echo "Setting Hostname to $NIX_HOSTNAME"
sed -i "s/\# networking.hostName = \"nixos\"; /networking.hostName = \"$NIX_HOSTNAME\"; /" $NIX_CONFIG

echo "Adding user config for $NIX_FULLNAME -- $NIX_USER"
sed -i "/Define a user account/a\  users.users.$NIX_USER = { \n \
    isNormalUser = true; \n \
    description = \"$NIX_FULLNAME\"; \n \
    initialPassword = \"$NIX_PASSWORD\"; \n \
    extraGroups = [ \"networkmanager\" \"wheel\" \"audio\" \"input\" \"video\" ]; \n \
    packages = with pkgs; [ \n \
    \#  thunderbird \n \
    ]; \n \
    shell = pkgs.zsh; \n \
  };" $NIX_CONFIG

echo "Enabling ZSH"
sed -i '/Define a user account/i\  # Enable ZSH \n  programs.zsh.enable = true; \n' $NIX_CONFIG

echo "Enabling experimental features for flakes"
sed -i '/boot loader/i\  # Enable experimental features \n  nix.settings.experimental-features = [ "nix-command" "flakes" ]; \n ' $NIX_CONFIG

echo "Enabling SSH"
sed -i "s/\# services.openssh.enable/services.openssh.enable/" $NIX_CONFIG

echo "Going into /mnt and running nixos-install --no-root-password"
cd /mnt
nixos-install --no-root-password

sleep 5

nixos-enter --root /mnt -c "passwd -e $NIX_USER"

sleep 5

echo "Removing initial password from config file"
sed -i "/initialPassword/d" $NIX_CONFIG

echo "Nixos installation completed."
#systemctl reboot
