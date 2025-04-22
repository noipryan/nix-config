# Enables qemu and spice guest agents
{ config, lib, pkgs, pkgs-unstable, ... }:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    open-vm-tools-headless
    open-vm-tools
    xorg.xf86videovmware
  ];

  # Enable VMware guest modules
  virtualization.vmware.guest.enable = true;

  #hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "vmware" ];
}
