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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixos-hardware, darwin, home-manager, ... }:
    {
      # Use flake-utils to generate configurations for each system
      nixosConfigurations = {
        # NixOS host configuration
        nixosHost = nixpkgs.lib.nixosSystem{
          system = "x86_64-linux"; # Default for NixOS
          modules = [ ./hosts/host.nix ];
        };

        # NixOS VM configuration
        nixosVM = nixpkgs.lib.nixosSystem{
          system = "x86_64-linux"; # Assuming NixOS VM runs on x86_64
          modules = [ ./hosts/nixos-vm.nix ];
        };
      };

      darwinConfigurations = {
        # MacOS Darwin (nix-darwin) configuration
        Mac-mini-Tiberiu = darwin.lib.darwinSystem {
          system = "aarch64-darwin"; # For Mac Mini M4 Pro
          modules = [
            # Import the Common configuration
            # This is necessary for ensuring that the Nix environment is set up correctly for the user
            # and that the user has access to the Nix environment.
            ./modules/common.nix # Common configuration shared by host and VM

            # Import the Apps configuration
            # This is necessary for ensuring that the Nix environment is set up correctly for the user
            # and that the user has access to the Nix environment.
            # This will ensure that the user has access to the Nix environment when using zsh
            # and that the Nix environment is set up correctly for the user.
            ./modules/darwin/apps.nix # Darwin apps configuration

            # Import the Darwin system configuration
            # This is necessary for ensuring that the Nix environment is set up correctly for Darwin.
            # This will ensure that the user has access to the Nix environment when using zsh
            # and that the Nix environment is set up correctly for the user.
            ./modules/darwin/system.nix # Darwin system configuration

            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true; # Use global packages
              home-manager.useUserPackages = true; # Use user-specific packages
              home-manager.users.tiberiu = {
                imports = [
                  # Import the Home Manager module for Darwin
                  # This is necessary for ensuring that the Nix environment is set up correctly for the user
                  # and that the user has access to the Nix environment.
                  ./modules/darwin/home.nix # Darwin home configuration
                ];
              };
              home-manager.extraSpecialArgs = { 
                inherit inputs; 
                system = "aarch64-darwin"; # Specify the system architecture
                pkgs = nixpkgs.legacyPackages.aarch64-darwin; # Use aarch64-darwin packages
              }; # Pass inputs to home-manager
            }
          ];
        };
      };
    };
}
