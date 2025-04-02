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
      playerctl
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

  environment.sessionVariables = rec {
    NIXOS_OZONE_WL = "1";
  };
  
   # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  }; 

}
