{ config, lib, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.swainrl = {
    isNormalUser = true;
    description = "Ryan Swain";
    hashedPassword = "$y$j9T$A.Qb65oGnFXMwmy85p2vL.$5CY6zYr0TXAC9/YEe.j6gLCDwrfVA.nbxBJd.4./DIC";
    extraGroups = [ "networkmanager" "wheel" "audio" "input" "libvirtd" "video" ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };
}
