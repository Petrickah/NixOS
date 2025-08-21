{ self, pkgs, ... }:
{
  ###################################################################################
  #  MacOS's Darwin configuration
  ###################################################################################

  # This module configures the NixOS Darwin system for a Mac Mini M4 Pro.
  # It sets up the system configuration, user environment, and networking settings.
  # It is designed to work with the NixOS Darwin system and provides a basic setup
  # for a Mac Mini M4 Pro running macOS 26 (Tahoe).
  # For more information, see: https://nixos.wiki/wiki/Nixpkgs
  # and https://nixos.wiki/wiki/Nixpkgs#Darwin_configuration
  imports = [
    # Import the Apps configuration for Darwin (macOS)
    # This is necessary for ensuring that the Nix environment is set up correctly for the user
    # and that the user has access to the Nix environment.
    ../../../hosts/darwin/system/apps.nix
  ];

  # Set the Nixpkgs configuration for Darwin
  # This is important for ensuring that packages are built for the correct architecture.
  # For Apple Silicon Macs (M1/M2/M4), use aarch64-darwin.
  # For Intel-based Macs, use x86_64-darwin.
  # To enable Rosetta 2 (for running Intel binaries on Apple Silicon), set up the following:
  #   1. Install Rosetta 2: `softwareupdate --install-rosetta --agree-to-license`
  #   2. You can also use `nixpkgs.config.allowUnsupportedSystem = true;` for unsupported systems.
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      # Allow unsupported systems and unfree packages
      # This is useful for development and testing, but should be used with caution.
      # If you want to allow unsupported systems, you can uncomment the following line.
      # For more information, see: https://nixos.wiki/wiki/Nixpkgs
      # and https://nixos.wiki/wiki/Nixpkgs#Allow_unsupported_system
      allowUnsupportedSystem = true;

      # Allow unfree packages in Nixpkgs
      # This is useful for development and testing, but should be used with caution.
      # If you want to allow unfree packages, you can uncomment the following line.
      # Note: This is necessary for using proprietary software like Google Chrome, Slack, etc.
      allowUnfree = true;

      # Set the Nixpkgs configuration to allow broken packages
      # This is useful for development and testing, but should be used with caution.
      # If you want to allow broken packages, you can uncomment the following line.
      allowBroken = true; # Allow broken packages in Nixpkgs
    };
  };
}