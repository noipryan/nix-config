{ config, lib, pkgs, pkgs-unstable, ... }:

{
# Font configuration
  fonts.packages = 

    (with pkgs; [
    
    cantarell-fonts
    ubuntu-sans

    ])

    (with pkgs-unstable; [

    nerd-fonts.caskaydia-cove
    nerd-fonts.comic-shanns-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    nerd-fonts.roboto-mono
    nerd-fonts.sauce-code-pro
    nerd-fonts.ubuntu-mono
    nerd-fonts.victor-mono

    ]);

}