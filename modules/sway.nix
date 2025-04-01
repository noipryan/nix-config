{ config, lib, pkgs, pkgs-unstable, ... }:

{

  environment.systemPackages = (with pkgs; [
      
      brightnessctl
      glib
      gnome-keyring
      grim
      iwgtk
      networkmanagerapplet
      nwg-look
      pavucontrol
      rofi
      slurp
      sway
      swaybg
      sway-contrib.grimshot
      swayidle
      swaylock
      swaynotificationcenter
      wayland
      waybar
      wdisplays
      wf-recorder
      wl-clipboard
      xdg-utils
      wpa_supplicant_gui

  ]);

  xdg.portal ={
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gnome
      ];
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
    '';
  };

  services.gnome.gnome-keyring.enable = true;

  services.dbus.enable = true;

  services.xserver.enable = true;
  #services.displayManager.sddm.enable = true;
  services.libinput.enable = true;
}
