{ config, lib, pkgs, pkgs-unstable, ... }:

{
  # Plymouth on boot
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Enable the MATE Desktop Environment.
  services.xserver.desktopManager.mate.enable = true;

    environment.systemPackages = [
      pkgs.mate.mate-menus
    ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
}
