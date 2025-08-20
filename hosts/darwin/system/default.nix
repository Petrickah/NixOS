{ pkgs, username, homeDirectory, hostname, ... }:
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
    ../../hosts/darwin/apps.nix
  ];

  # This function generates a plist file for the system configuration
  # It is used to store system preferences and configurations on macOS.
  # The plist file is used to store system preferences and configurations on macOS.
  # For more information, see: https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/PropertyLists/Introduction/Introduction.html
  # and https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/PropertyLists/Introduction/Introduction.html#//apple_ref/doc/uid/10000057i-CH1-SW1
  # This is necessary for ensuring that the plist file is generated correctly.
  pkgs.lib.generators.toPlist = {
      inherit pkgs;

      # Set the name for the plist file; this should match your machine's hostname
      # If you want to use a different name, you can change the following line
      # and set it to the desired name.
      # Note: This is necessary for ensuring that the plist file is generated correctly.
      # If you want to use a different name, you can change the following line
      # and set it to the desired name.
      # For more information, see: https://nixos.wiki/wiki/Nixpkgs
      # and https://nixos.wiki/wiki/Nixpkgs#Configuration
      name = "darwin-system";

      # This is a brief description of the configuration; it can be used to provide more information
      # about the configuration and its purpose.
      # For more information, see: https://nixos.wiki/wiki/Nixpkgs
      # and https://nixos.wiki/wiki/Nixpkgs#Configuration
      # and https://nixos.wiki/wiki/Nixpkgs#Configuration#Description
      # Note: This is necessary for ensuring that the plist file is generated correctly.
      # If you want to use a different description, you can change the following line
      # and set it to the desired description.
      description = "NixOS Darwin system configuration for Mac Mini M4 Pro";

      # Set the version of the configuration; this should match the version of nix-darwin you are using.
      # Valid values can be found in the nix-darwin documentation: https://daiderd.com/nix-darwin/manual/index.html#opt-system.stateVersion
      # Note: This is necessary for ensuring that the plist file is generated correctly.
      # If you want to use a different version, you can change the following line
      # and set it to the desired version.
      version = 6;

      # Set the author of the configuration; this should match your name or the name of the person who created the configuration
      # If you want to use a different author, you can change the following line
      # and set it to the desired author.
      # Note: This is necessary for ensuring that the plist file is generated correctly.
      author = "Tiberiu";

      # Set the license for the configuration; this should match the license you want to use for the configuration
      # If you want to use a different license, you can change the following line
      # and set it to the desired license.
      # Note: This is necessary for ensuring that the plist file is generated correctly.
      # If you want to use a different license, you can change the following line
      # and set it to the desired license.
      license = "MIT"; # License for the configuration

      # Set the output file path for the plist file
      # This is necessary for ensuring that the plist file is generated in the correct location.
      # If you want to use a different output file path, you can change the following line
      # and set it to the desired output file path.
      output = "${homeDirectory}/Library/Preferences/com.tiberiu.darwin.plist";

      # Set the output format for the plist file
      # This is necessary for ensuring that the plist file is generated in the correct format.
      # If you want to use a different format, you can change the following line
      # and set it to the desired format.
      format = "plist"; # Set the output format to plist

      # Set the escape option for the plist file
      # This is necessary for ensuring that special characters in the plist file are escaped correctly.
      # If you want to disable escaping, you can change the following line and set it to false.
      escape = true; # Escape special characters in the plist file
  };

  # Set the netorking configuration for Darwin
  # This is important for ensuring that the system can connect to the network.
  # If you want to use a different hostname, you can change the following line
  # and set it to the desired hostname.
  networking.hostName = hostname; # Set the hostname for the system; this should match your machine's hostname
  networking.computerName = hostname; # Set the computer name for the system; this should match your machine's hostname

  # Declare the user for whom the Nix environment is configured
  # This is necessary for ensuring that the Nix environment is set up correctly for the user
  # and that the user has access to the Nix environment.
  users.users.${username} = {
    name = username; # Set the username for the user account
    home = homeDirectory; # Replace with your actual home directory

    # Set the default shell for the user
    # This is necessary for ensuring that the user has access to the default shell
    # and that the user can use the default shell as their default shell.
    shell = pkgs.zsh; # Set the default shell for the user
  };

  # Set the Nix configuration for Darwin
  # This is important for ensuring that the Nix environment is set up correctly for Darwin.
  # Note: This is necessary for using the Nix command and flakes.
  nix = {
    # Disable the Nix daemon service on Darwin
    # This is necessary for ensuring that the Nix daemon service is not enabled on Darwin.
    # If you want to enable the Nix daemon service, you can change the following line and set it to true.
    # Note: The Nix daemon service is not supported on Darwin, so it is recommended to keep it disabled.
    enable = false;

    settings = {
      # Set the trusted users for Nix
      # This is necessary for ensuring that the Nix environment is set up correctly for the user
      # and that the user has access to the Nix environment.
      trusted-users = [ "tiberiu" ];

      # Set the Nix configuration to allow experimental features
      # This is useful for development and testing, but should be used with caution.
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
      # Set the NetBIOS name for the system; this should match your machine's hostname
      # This is important for ensuring that the system can be identified on the network.
      # If you want to use a different NetBIOS name, you can change the following line
      # and set it to the desired NetBIOS name.
      # Note: This is necessary for using SMB and other network protocols.
      smb.NetBIOSName = hostname; 

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
          "/System/Applications/Apps.app" # Apps
          "/System/Applications/System Settings.app" # System Settings
        ];
        persistent-others = [
          # Add your desired persistent others to the Dock
          "${homeDirectory}/Downloads" # Downloads folder
        ];
      };
    };
  };
}