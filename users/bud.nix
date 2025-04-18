{ config, lib, pkgs, ... }:

{

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bud = {
    isNormalUser = true;
    description = "Ryan Swain";
    hashedPassword = "$y$j9T$Ac5mXTfcqljUVP7sdEfdW/$8wXnl72czUwJad1HveR0VzzI/7A2cXZa7ocjfHhCoBA";
    extraGroups = [ "networkmanager" "wheel" "audio" "input" "libvirtd" "video" ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };
}
