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

    # Import the user configuration for Darwin (macOS)
    # This is necessary for ensuring that the Nix environment is set up correctly for the user
    # and that the user has access to the Nix environment.
    ../../../users/tiberiu/darwin.nix
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

  ###################################################################################
  #  MacOS's System configuration
  ###################################################################################

  system = {
    # Set the system primary user to the user for whom the Nix environment is configured
    # This is necessary for ensuring that the Nix environment is set up correctly for the user
    # and that the user has access to the Nix environment.
    # If you want to use a different user, you can change the following line
    # and set it to the desired user.
    primaryUser = "tiberiu"; # Set the primary user for the Nix environment

    # Set the system configuration revision for Darwin
    # This is important for ensuring that the system configuration is compatible with the latest features.
    configurationRevision = "darwin-unstable"; # Use the latest Darwin configuration revision

    # Set the Darwin system state version; this should match the version of nix-darwin you are using.
    # Valid values can be found in the nix-darwin documentation: https://daiderd.com/nix-darwin/manual/index.html#opt-system.stateVersion
    stateVersion = 6; # Using the latest state version for macOS 26 (Tahoe)

    defaults = {
      # Customize the system's Dock and Dock preferences
      # This is useful for customizing the Dock appearance and behavior.
      # If you want to customize the Dock, you can change the following lines
      # and set them to the desired Dock preferences.
      dock = {
        autohide = false; # Disable Dock autohide
        autohide-delay = 0.0; # Set Dock autohide delay
        autohide-time-modifier = 0.15; # Set Dock autohide time modifier
        static-only = false; # Disable Dock static-only mode
        orientation = "bottom"; # Set Dock orientation
        tilesize = 45; # Set Dock size
        show-recents = false; # Enable Dock show recent applications
        mineffect = "genie"; # Set Dock minimize effect to scale
        minimize-to-application = true; # Enable Dock minimize to application
        magnification = false; # Enable Dock magnification
        persistent-apps = [
          # Add your desired persistent applications to the Dock
          "/Applications/Google Chrome.app" # Google Chrome
          "/Applications/Discord.app" # Discord
          "/Applications/Visual Studio Code.app" # Visual Studio Code
          "/Applications/GitHub Desktop.app" # GitHub Desktop
          "/System/Applications/Utilities/Terminal.app" # Terminal
          "/System/Applications/Calendar.app" # Calendar
          "/System/Applications/System Settings.app" # System Settings
        ];
        persistent-others = [
          # Add your desired persistent others to the Dock
          "/System/Applications/Apps.app" # Apps
          "/Users/tiberiu/Downloads" # Downloads folder
        ];
      };
    };
  };
}