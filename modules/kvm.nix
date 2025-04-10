# Enables qemu and spice guest agents
{ config, lib, pkgs, pkgs-unstable, ... }:

{

  # Libvirtd and virt-manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Enable TPM emulation (optional)
  virtualisation.libvirtd.qemu = {
    swtpm.enable = true;
    ovmf.packages = [ pkgs.OVMFFull ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pkgs.OVMFFull
  ];

  # Enable guest tools in KVM
  #services.spice-vdagentd.enable = true;
  #services.qemuGuest.enable = true;

}
