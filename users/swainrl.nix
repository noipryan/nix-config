{ config, lib, pkgs, ... }:

{
  # Enable ZSH
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.swainrl = {
    isNormalUser = true;
    description = "Ryan Swain";
    hashedPassword = "$y$j9T$/dW7iTZhxhNFgWAxtGhmz0$mRYC7yyfReOqB1cH5nw8rYAab71r1Pu7O7APui/6qKD";
    extraGroups = [ "networkmanager" "wheel" "audio" "input" "libvirtd" "video" ];
    packages = with pkgs; [
      #  thunderbird
    ];
    shell = pkgs.zsh;
  };
}
