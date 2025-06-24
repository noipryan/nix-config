{
  description = "MacBook Air nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, lib, ... }: {
      
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget

      environment.systemPackages =
        [ 
          pkgs.alacritty
          pkgs.bat
          pkgs.curl
	        pkgs.eza
          pkgs.fzf
          pkgs.freerdp3
          pkgs.google-chrome
          pkgs.nodejs_22
	        pkgs.mkalias
	        pkgs.neovim
          pkgs.nmap
          pkgs.obsidian
          pkgs.openfortivpn
          pkgs.openconnect
          pkgs.pyright
          pkgs.slack
          pkgs.sshpass
          pkgs.tmux
          pkgs.utm
	        pkgs.vscode
	        pkgs.wezterm
          pkgs.zellij
          pkgs.zoxide
	      ];

      homebrew = {
        enable = true;
        brews = [
          "mas"
        ];
        casks = [
          "firefox"
          "raycast"
          "royal-tsx"
          "the-unarchiver"
          "syncthing"
        ];
        masApps = {
          "MSFT RDP" = 1295203466;
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };  

      fonts.packages = [
      	(pkgs.nerdfonts.override { fonts = [
	        "JetBrainsMono"
	        "FiraCode"
	        "FiraMono"
	        "CascadiaCode"
	        "UbuntuMono"
	        "RobotoMono"
	        "VictorMono"
	        "ComicShannsMono"
	        ];
	      })  
      ];

      
    # Import this module in your nix-darin config to have applications copied
  	# to /Applications/Nix Apps instead of being symlinked. GUI apps must be
  	# added to environment packages, not home-manager for this to work.
  	system.activationScripts.applications.text = lib.mkForce ''
    	echo "Setting up /Applications/Nix Apps" >&2
    	appsSrc="${config.system.build.applications}/Applications/"
    	baseDir="/Applications/Nix Apps"
    	#rsyncArgs="--archive --checksum --copy-unsafe-links --delete"
    	mkdir -p "$baseDir"
    	${pkgs.rsync}/bin/rsync --archive --checksum --copy-unsafe-links --delete --chown=root:wheel --chmod=Du=rwx "$appsSrc" "$baseDir"
  	'';
      	


      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;
      programs.zsh.enable = true; # default shell on OSX	

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."air" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
          
            # Install Homebrew under the default prefix
            enable = true;
            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;
            # User owning the Homebrew prefix
            user = "swainrl";
          };  
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."air".pkgs;
  };
}
