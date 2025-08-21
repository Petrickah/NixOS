{
  # This flake provides a multi-system setup with:
  # - NixOS host configuration
  # - NixOS VM configuration
  # - Windows 11 VM configuration
  # - MacOS Darwin (nix-darwin) configuration
  # This allows for a flexible and extensible NixOS environment that can be used across different systems,
  # including virtual machines and physical hosts, while also supporting the latest features of NixOS and Nixpkgs.
  description = "Nix Flake for multi-system setup: NixOS host, NixOS VM, Windows 11 VM, MacOS Darwin (nix-darwin)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = { self, nixpkgs, nixos-hardware, nix-darwin, home-manager, vscode-server, ... }@inputs: 
  {
    nixosConfigurations = {
      # NixOS host configuration
      nixosHost = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # Default for NixOS
        modules = [ 
          ./hosts/nixos

          vscode-server.nixosModules.default {
            services.vscode-server.enable = true;
          }
        ];
      };

      # NixOS VM configuration
      nixosVM = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # Assuming NixOS VM runs on x86_64
        modules = [ 
          ./hosts/nixos-vm.nix

          vscode-server.nixosModules.default {
            services.vscode-server.enable = true;
          }
        ];
      };
    };

    darwinConfigurations = {
      # MacOS Darwin (nix-darwin) configuration
      Mac-mini-Tiberiu = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin"; # For Mac Mini M4 Pro
        modules = [
          # Import the Darwin system configuration
          # This is necessary for ensuring that the Nix environment is set up correctly for Darwin.
          # This will ensure that the user has access to the Nix environment when using zsh
          # and that the Nix environment is set up correctly for the user.
          ./hosts/darwin
        ];
      };
    };

    homeConfigurations = {
      "tiberiu@Mac-mini-Tiberiu" = home-manager.lib.homeManagerConfiguration {
        # Use the system architecture for Mac Mini M4 Pro
        # This is important for ensuring that the Home Manager configuration is built for the correct architecture.
        # For Apple Silicon Macs (M1/M2/M4), use aarch64-darwin.
        # For Intel-based Macs, use x86_64-darwin.
        # To enable Rosetta 2 (for running Intel binaries on Apple Silicon), set up the following:
        #   1. Install Rosetta 2: `softwareupdate --install-rosetta --agree-to-license`
        #   2. You can also use `nixpkgs.config.allowUnsupportedSystem = true;` for unsupported systems.
        # For more information, see: https://nixos.wiki/wiki/Nixpkgs#System_architecture
        pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin; # Use the aarch64-darwin packages for Mac Mini M4 Pro

        modules = [
          # Import the Home Manager configuration for the user
          # This will ensure that the user has access to the Home Manager environment
          # and that the Home Manager configuration is set up correctly for the user.
          ./hosts/home
        ];

        extraSpecialArgs = {
          username = "tiberiu";
          homeDirectory = "/Users/tiberiu";
        };
      };

      "tiberiu@nixos"= home-manager.lib.homeManagerConfiguration {
        # Use the system architecture for Intel Core i7-14700K
        # This is important for ensuring that the Home Manager configuration is built for the correct architecture.
        # For more information, see: https://nixos.wiki/wiki/Nixpkgs#System_architecture
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux; # Use the x86_64-linux packages for Intel Core i7-14700K

        modules = [
          # Import the Home Manager configuration for the user
          # This will ensure that the user has access to the Home Manager environment
          # and that the Home Manager configuration is set up correctly for the user.
          ./hosts/home
        ];

        extraSpecialArgs = {
          username = "tiberiu";
          homeDirectory = "/home/tiberiu";
        };
      };
    };
  };
}
