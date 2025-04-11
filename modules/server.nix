# Enables qemu and spice guest agents
{ config, lib, pkgs, pkgs-unstable, ... }:

{

  environment.systemPackages = (with pkgs; [

    bat
    dig
    eza
    fzf
    git
    helix
    nmap
    rsync
    screen
    tmux
    vim
    wget

  ];

}
