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
  environment.systemPackages = with pkgs; [
    pkgs.alacritty
    pkgs-unstable.ansible
    pkgs-unstable.ansible-lint
    pkgs.bat
    pkgs-unstable.vscode
    pkgs.curl
    pkgs.diffuse
    pkgs.eza
    pkgs-unstable.freerdp3
    pkgs.fzf
    pkgs.geany
    pkgs.git
    pkgs.google-chrome
    pkgs.helix
    pkgs.kdePackages.qtstyleplugin-kvantum
    pkgs.kdePackages.qt6ct
    pkgs.kdePackages.okular
    pkgs.kitty
    pkgs.krb5
    pkgs.libsForQt5.qt5ct
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.lxqt.lximage-qt
    pkgs.lxappearance
    pkgs.materia-theme
    pkgs.materia-kde-theme
    pkgs.neovim
    pkgs.nix-ld
    pkgs.nixos-artwork.wallpapers.simple-blue
    pkgs.nmap
    pkgs.nodejs_23
    pkgs.openconnect
    pkgs.openfortivpn
    pkgs.papirus-icon-theme
    pkgs-unstable.remmina
    pkgs.rsync
    pkgs.screen
    pkgs.spice
    pkgs.spice-vdagent
    pkgs.sshpass
    pkgs.starship
    pkgs.terminator
    pkgs.themechanger
    pkgs.tmux
    pkgs.vim
    pkgs.wezterm
    pkgs.wget
    pkgs.yad
    pkgs.yamllint
    pkgs-unstable.zed-editor
    pkgs.zoxide
    pkgs.zsh
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Font configuration
  fonts.packages = with pkgs; [
    cantarell-fonts
    ubuntu-sans
    pkgs-unstable.nerd-fonts.caskaydia-cove
    pkgs-unstable.nerd-fonts.comic-shanns-mono
    pkgs-unstable.nerd-fonts.fira-code
    pkgs-unstable.nerd-fonts.fira-mono
    pkgs-unstable.nerd-fonts.iosevka
    pkgs-unstable.nerd-fonts.jetbrains-mono
    pkgs-unstable.nerd-fonts.roboto-mono
    pkgs-unstable.nerd-fonts.sauce-code-pro
    pkgs-unstable.nerd-fonts.ubuntu-mono
    pkgs-unstable.nerd-fonts.victor-mono
  ];
}
