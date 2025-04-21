# ZSH configuration
{ config, lib, pkgs, pkgs-unstable,... }:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
    zsh
  ]);

  # Set ZSH to be the default shell on the system
  users.defaultUserShell=pkgs.zsh;

  # Enable zsh
  programs.zsh = {
      enable = true;
  };

  # enable starship prompt
  programs.starship.enable = true;

}
