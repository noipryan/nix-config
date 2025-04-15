{
  description = "NixOS systems and tools by Ryan Swain";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
      commonArgs = { inherit system; config.allowUnfree = true; };
      #pkgs = import nixpkgs commonArgs;
      #pkgs-unstable = import nixpkgs-unstable commonArgs;
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      pkgs-unstable = import nixpkgs-unstable { inherit system;  config.allowUnfree = true; };
    in {

      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [ ./hosts/default/configuration.nix ];
        specialArgs = { inherit pkgs-unstable; };
        };
        nixosConfigurations.bud-sys76 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/bud-sys76/configuration.nix
          ];
          specialArgs = { inherit pkgs-unstable pkgs; };
          };
        nixosConfigurations.nix-server = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/nix-server/configuration.nix
          ];
          specialArgs = { inherit pkgs-unstable pkgs; };
          };
      nixosConfigurations.itc-devone-01 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/itc-devone-01/configuration.nix
          ./modules/env.nix
          ./modules/fonts.nix
          ./modules/packages.nix
          ./modules/sway.nix
          ./modules/sddm.nix
          ./modules/localization.nix
          ./modules/tailscale.nix
          ./modules/kvm.nix
        ];
        specialArgs = { inherit pkgs-unstable pkgs; };
        };
      nixosConfigurations.sway-test = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
          ./hosts/sway-test/configuration.nix
          ./modules/fonts.nix
          ./modules/env.nix
          ./modules/packages.nix
          ./modules/kvm-guest.nix
          ./modules/sway.nix
        ];
        specialArgs = { inherit pkgs-unstable; };
        };
      nixosConfigurations.itc-x270-01 = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
          ./hosts/itc-x270-01/configuration.nix
          ./modules/fonts.nix
          ./modules/env.nix
          ./modules/packages.nix
          ./modules/sddm.nix
          ./modules/sway.nix
        ];
      specialArgs = { inherit pkgs-unstable; };
      };
      nixosConfigurations.itcnetenglt01 = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
          ./hosts/itcnetenglt01/configuration.nix
          ./modules/fonts.nix
          ./modules/env.nix
          ./modules/packages.nix
          ./modules/localization.nix
          ./modules/sddm.nix
          ./modules/sway.nix
          ./modules/tailscale.nix
          ./modules/kvm.nix
        ];
      specialArgs = { inherit pkgs-unstable; };
      };
      nixosConfigurations.nixos-bios = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
          ./hosts/nixos-bios/configuration.nix
          ./modules/fonts.nix
          ./modules/env.nix
          ./modules/localization.nix
          ./modules/kvm-guest.nix
          ./modules/packages.nix
          ./modules/sddm.nix
          ./modules/cinnamon.nix
        ];
      specialArgs = { inherit pkgs-unstable; };
      };
      homeConfigurations = {
        name = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          extraSpecialArgs = { inherit pkgs-unstable; };
        };
      };
    };
}
