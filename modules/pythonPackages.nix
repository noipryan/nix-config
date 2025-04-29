# Enables qemu and spice guest agents
{ config, lib, pkgs, pkgs-unstable, ... }:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (python312.withPackages (
      ps: with ps; [
        netaddr
        numpy
        pandas
      ]
    ))
  ];

}
