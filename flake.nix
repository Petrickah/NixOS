{
  description = "Nix Flake for multi-system setup: NixOS host, NixOS VM, Windows 11 VM, MacOS Darwin (nix-darwin)";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    darwin.url = "github:LnL7/nix-darwin";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, nixos-hardware, darwin, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system: {
      packages = {
        nixosHost = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/host.nix ];
        };
        nixosVM = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./vms/nixos-vm.nix ];
        };
        windows11VM = import ./vms/windows11-vm.nix;
        darwinSystem = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [ ./hosts/darwin.nix ];
        };
      };
    });
}
