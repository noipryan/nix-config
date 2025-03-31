{ config, lib, pkgs, pkgs-unstable, ... }:

{

  environment.systemPackages = [

      pkgs.sway
      pkgs.swaylock
      pkgs.swayidle
      pkgs.swaybg
      pkgs.waybar
      pkgs.wl-clipboard
      pkgs.wayland
      pkgs.xdg-utils
      pkgs.glib
      pkgs.wf-recorder
      pkgs.swaynotificationcenter
      pkgs.grim
      pkgs.sway-contrib.grimshot
      pkgs.slurp
      pkgs.rofi
      pkgs.pavucontrol
      pkgs.networkmanagerapplet
      pkgs.brightnessctl
      pkgs.gnome-keyring
      pkgs.wpa_supplicant_gui
      pkgs.iwgtk
      pkgs.nwg-look
      pkgs.wdisplays
      pkgs.adwaita-icon-theme
      pkgs.materia-kde-theme
      pkgs.materia-theme


  ];

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
