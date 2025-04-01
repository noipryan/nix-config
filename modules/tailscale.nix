# Enables qemu and spice guest agents
{ config, lib, pkgs, pkgs-unstable, ... }:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pkgs.tailscale
  ];

  services.tailscale.enable = true;

  # For internet access when using an exit node
  networking.firewall.checkReversePath = "loose";

}
