{ config, lib, pkgs, pkgs-unstable, ... }:

{
  
  # Install firefox.
  programs.firefox.enable = true;

  # enable starship prompt
  programs.starship.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
    adwaita-icon-theme
    alacritty
    ark
    bat
    brave
    curl
    diffuse
    dig
    eza
    fzf
    gcc
    geany
    git
    google-chrome
    helix
    kdePackages.qtstyleplugin-kvantum
    kdePackages.qt6ct
    kdePackages.okular
    kitty
    krb5
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    lxqt.lximage-qt
    lxappearance
    materia-theme
    materia-kde-theme
    microsoft-edge
    nemo
    neovim
    nix-ld
    nixos-artwork.wallpapers.simple-blue
    nmap
    nodejs_23
    openconnect
    openfortivpn
    papirus-icon-theme
    phinger-cursors
    python312
    qbittorrent
    rsync
    screen
    sshpass
    starship
    terminator
    themechanger
    tmux
    traceroute
    vim
    wezterm
    wget
    wireshark
    yad
    yamllint
    zoxide
    zsh
  ])

  ++

  (with pkgs-unstable; [
    ansible
    ansible-lint
    freerdp3
    remmina
    slack
    zed-editor
    vscode

  ]);
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

}
