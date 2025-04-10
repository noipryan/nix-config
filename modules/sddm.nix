{ config, lib, pkgs, pkgs-unstable, ... }:

{

  environment.systemPackages = [(

      pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        font = "Cantarell";
        fontSize = "12";
        background = "${../Background/wallpaper.png}";
        loginBackground = true;
      }
  )];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };

}
