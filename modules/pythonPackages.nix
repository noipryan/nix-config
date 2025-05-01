# Enables qemu and spice guest agents
{ config, lib, pkgs, pkgs-unstable, ... }:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (python312.withPackages (
      ps: with ps; [

        netaddr
        numpy
        pandas
        python-lsp-server
        python-lsp-jsonrpc
        python-lsp-black
        python-lsp-ruff
        pyls-flake8
        pyls-isort
        flake8
        isort
        black
      ]
    ))
  ];

}
