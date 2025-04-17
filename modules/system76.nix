# Enables qemu and spice guest agents
{ config, lib, pkgs, pkgs-unstable, ... }:

{

  # Enable System76 hardware drivers
  hardware.system76.enableAll = true;

  # Disable default power management daemon
  services.power-profiles-daemon.enable = false;

}
