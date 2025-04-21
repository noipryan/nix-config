{ config, lib, pkgs, pkgs-unstable, ... }:

{

  virtualisation.docker.enable = true;

  # If you use the btrfs file system, you might need to set the storageDriver option:
  virtualisation.docker.storageDriver = "btrfs";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    docker-compose
  ];

}
