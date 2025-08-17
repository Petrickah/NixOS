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
  };

  outputs = inputs@{ self, nixpkgs, nixos-hardware, darwin, ... }:
    {
      # Use flake-utils to generate configurations for each system
      nixosConfigurations = {
        # NixOS host configuration
        nixosHost = nixpkgs.lib.nixosSystem{
          system = "x86_64-linux"; # Default for NixOS
          modules = [ ./hosts/nixos_host.nix ];
        };

        # NixOS VM configuration
        nixosVM = nixpkgs.lib.nixosSystem{
          system = "x86_64-linux"; # Assuming NixOS VM runs on x86_64
          modules = [ ./hosts/nixos_vm.nix ];
        };
      };

      darwinConfigurations = {
        # MacOS Darwin (nix-darwin) configuration
        Mac-mini-Tiberiu = darwin.lib.darwinSystem {
          system = "aarch64-darwin"; # For Mac Mini M4 Pro
          modules = [ ./hosts/darwin.nix ];
        };
      };
    };
}
