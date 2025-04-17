{ config, lib, pkgs, pkgs-unstable, ... }:

{

  # enable starship prompt
  programs.starship.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
   neovim 
   zoxide
  ])

  ++

  (with pkgs-unstable; [
  ]);
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

}
