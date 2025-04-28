# ZSH configuration
{ config, lib, pkgs, pkgs-unstable,... }:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
  ]);

  services.tlp.enable = true;

}
