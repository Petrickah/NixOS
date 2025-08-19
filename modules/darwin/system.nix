{ pkgs, username, homeDirectory, ... }:
{
  ###################################################################################
  #  MacOS's Darwin configuration
  ###################################################################################

  # Declare the user for whom the Nix environment is configured
  # This is necessary for ensuring that the Nix environment is set up correctly for the user
  # and that the user has access to the Nix environment.
  users.users.${username} = {
    name = username; # Set the username for the user account
    home = homeDirectory; # Replace with your actual home directory

    # Enable the zsh shell for the user
    # This will ensure that the user has access to the zsh shell
    # and that the user can use zsh as their default shell.
    shell = pkgs.zsh; 
  };

  # Set the Nix configuration for Darwin
  # This is important for ensuring that the Nix environment is set up correctly for Darwin.
  # Note: This is necessary for using the Nix command and flakes.
  # For more information, see: https://nixos.wiki/wiki/Nixpkgs
  # and https://nixos.wiki/wiki/Nixpkgs#Nix_configuration
  nix = {
    # Disable the Nix daemon service on Darwin
    # This is necessary for ensuring that the Nix daemon service is not enabled on Darwin.
    # If you want to enable the Nix daemon service, you can change the following line and set it to true.
    # Note: The Nix daemon service is not supported on Darwin, so it is recommended to keep it disabled.
    # For more information, see: https://nixos.wiki/wiki/Nixpkgs
    # and https://nixos.wiki/wiki/Nixpkgs#Nix_daemon
    enable = false;

    settings = {
      # Set the trusted users for Nix
      # This is necessary for ensuring that the Nix environment is set up correctly for the user
      # and that the user has access to the Nix environment.
      # For more information, see: https://nixos.wiki/wiki/Nixpkgs
      # and https://nixos.wiki/wiki/Nixpkgs#Trusted_users
      trusted-users = [ "tiberiu" ];

      # Set the Nix configuration to allow experimental features
      # This is useful for development and testing, but should be used with caution.
      # For more information, see: https://nixos.wiki/wiki/Nixpkgs
      # and https://nixos.wiki/wiki/Nixpkgs#Experimental_features
      # Note: This is necessary for using flakes and the Nix command.
      experimental-features = [ "nix-command" "flakes" ]; 
    };
  };

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
      # For more information, see: https://nixos.wiki/wiki/Nixpkgs
      # and https://nixos.wiki/wiki/Nixpkgs#Allow_unfree_packages
      # Note: This is necessary for using proprietary software like Google Chrome, Slack, etc.
      allowUnfree = true;

      # Set the Nixpkgs configuration to allow broken packages
      # This is useful for development and testing, but should be used with caution.
      # If you want to allow broken packages, you can uncomment the following line.
      # For more information, see: https://nixos.wiki/wiki/Nixpkgs
      # and https://nixos.wiki/wiki/Nixpkgs#Allow_broken_packages
      allowBroken = true; # Allow broken packages in Nixpkgs
    };
  };

  # Set the netorking configuration for Darwin
  # This is important for ensuring that the system can connect to the network.
  # If you want to use a different hostname, you can change the following line
  # and set it to the desired hostname.
  # For more information, see: https://nixos.wiki/wiki/Nixpkgs
  # and https://nixos.wiki/wiki/Nixpkgs#Networking_configuration
  networking.hostName = "Mac-mini-Tiberiu"; # Set the hostname for the system; this should match your machine's hostname

  ###################################################################################
  #  MacOS's System configuration
  ###################################################################################

  # Set the system primary user to the user for whom the Nix environment is configured
  # This is necessary for ensuring that the Nix environment is set up correctly for the user
  # and that the user has access to the Nix environment.
  # If you want to use a different user, you can change the following line
  # and set it to the desired user.
  # For example, if you want to use the user "john", you would set it to "john".
  # For more information, see: https://nixos.wiki/wiki/Nixpkgs# and https://nixos.wiki/wiki/Nixpkgs#System_primary_user
  system.primaryUser = "tiberiu"; # Set the primary user for the Nix environment

  # Set the system configuration revision for Darwin
  # This is important for ensuring that the system configuration is compatible with the latest features.
  # For more information, see: https://nixos.wiki/wiki/Nixpkgs# and https://nixos.wiki/wiki/Nixpkgs#Configuration_revisions
  system.configurationRevision = "darwin-unstable"; # Use the latest Darwin configuration revision

  # Set the Darwin system state version; this should match the version of nix-darwin you are using.
  # Valid values can be found in the nix-darwin documentation: https://daiderd.com/nix-darwin/manual/index.html#opt-system.stateVersion
  system.stateVersion = 6; # Using the latest state version for macOS 26 (Tahoe)
}