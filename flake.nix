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
      pkgs = import nixpkgs commonArgs;
      pkgs-unstable = import nixpkgs-unstable commonArgs;
    in {

      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [ ./hosts/default/configuration.nix ];
        specialArgs = { inherit pkgs-unstable; };
        };
      nixosConfigurations.itc-devone-01 = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
          ./hosts/itc-devone-01/configuration.nix
          ./modules/env.nix
          ./modules/packages.nix
          ./modules/sway.nix
          ./modules/sddm.nix
          ./modules/localization.nix
        ];
        specialArgs = { inherit pkgs-unstable; };
        };
      nixosConfigurations.sway-test = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
          ./hosts/sway-test/configuration.nix
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
            ./modules/env.nix
            ./modules/packages.nix
            ./modules/sddm.nix
            ./modules/sway.nix
          ];
        specialArgs = { inherit pkgs-unstable; };
        };
        nixosConfigurations.nixos-bios = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          modules = [
            ./hosts/nixos-bios/configuration.nix
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
