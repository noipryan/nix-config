# Enables qemu and spice guest agents
{ config, lib, pkgs, pkgs-unstable, ... }:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    spice-vdagent
  ];

  # Enable guest tools in KVM
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  hardware.opengl.enable = true;

}
