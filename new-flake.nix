{
  description = "NixOS systems and tools by Ryan Swain";

  inputs = {
    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    # we'll use for our configurations. Be very careful changing this because
    # it'll impact your entire system.
    nixpkgs.url = "nixpkgs/nixos-24.11";

    # We use the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    # config for MacOs Darwin
    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # I don't really use this, just here in case I need it
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, darwin, home-manager, ... }:
    let
      # Supported systems for your flake packages, shell, etc.
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = = f:
        nixpkgs.lib.genAttrs systems (system:
          f {
            pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
            pkgs-unstable = import nixpkgs-unstable { inherit system;  config.allowUnfree = true; };
            });
    in {

      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [ ./hosts/default/configuration.nix ];
        specialArgs = { inherit pkgs-unstable; };
      	};

      nixosConfigurations.bud-sys76 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/bud-sys76/configuration.nix ];
      	specialArgs = { inherit pkgs-unstable pkgs; };
      	};

      nixosConfigurations.nix-server = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/nix-server/configuration.nix ];
        specialArgs = { inherit pkgs-unstable pkgs; };
      	};

      nixosConfigurations.itc-nas-01 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/itc-nas-01/configuration.nix ];
        specialArgs = { inherit pkgs-unstable pkgs; };
      	};

      nixosConfigurations.itc-devone-01 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/itc-devone-01/configuration.nix
        ];
        specialArgs = { inherit pkgs-unstable pkgs; };
        };

      nixosConfigurations.itc-gpd-01 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/itc-gpd-01/configuration.nix
        ];
        specialArgs = { inherit pkgs-unstable pkgs; };
        };

      nixosConfigurations.sway-test = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
          ./hosts/sway-test/configuration.nix
        ];
        specialArgs = { inherit pkgs-unstable; };
        };

      nixosConfigurations.itc-x270-01 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/itc-x270-01/configuration.nix ];
        specialArgs = { inherit pkgs pkgs-unstable; };
      };

      nixosConfigurations.itcnetenglt01 = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
          ./hosts/itcnetenglt01/configuration.nix
        ];
      specialArgs = { inherit pkgs-unstable; };
      };

      nixosConfigurations.nixos-test = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
          ./hosts/nixos-test/configuration.nix
        ];
      specialArgs = { inherit pkgs-unstable; };
      };

      nixosConfigurations.itcmanage06 = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
          ./hosts/itcmanage06/configuration.nix
        ];
      specialArgs = { inherit pkgs-unstable; };
      };

      nixosConfigurations.itczenbook02 = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
          ./hosts/itczenbook02/configuration.nix
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
