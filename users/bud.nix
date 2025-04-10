{ config, lib, pkgs, ... }:

{
  # Enable ZSH
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bud = {
    isNormalUser = true;
    description = "Ryan Swain";
    hashedPassword = "$y$j9T$HysRHFeFKhWisSKJ5E9HT0$XL0VH8AnZ5evPUj.b5jVe9ARfit1xox6rClysGLQWUA".
    extraGroups = [ "networkmanager" "wheel" "audio" "input" "libvirtd" "video" ];
    packages = with pkgs; [
      #  thunderbird
    ];
    shell = pkgs.zsh;
  };
}
