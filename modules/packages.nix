{ config, lib, pkgs, pkgs-unstable, ... }:

{
  # Enable ZSH
  programs.zsh.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # enable starship prompt
  programs.starship.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
    adwaita-icon-theme
    alacritty
    bat
    curl
    diffuse
    dig
    eza
    fzf
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
    neovim
    nix-ld
    nixos-artwork.wallpapers.simple-blue
    nmap
    nodejs_23
    openconnect
    openfortivpn
    papirus-icon-theme
    phinger-cursors
    python314
    qbittorrent
    rsync
    screen
    sshpass
    starship
    terminator
    themechanger
    tmux
    vim
    wezterm
    wget
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
