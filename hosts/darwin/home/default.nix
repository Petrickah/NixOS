{ self, lib, pkgs, username, homeDirectory, projectRoot, ... }:
{
  ###################################################################################
  #  MacOS's Darwin Home Manager configuration
  ###################################################################################

  imports = [
    # Import the Wallpaper module for Darwin (macOS)
    # This is necessary for ensuring that the Home Manager configuration is set up correctly for the user
    # and that the user has access to the Home Manager environment.
    ../../../hosts/darwin/home/wallpaper.nix
  ];

  # This module configures Home Manager for the user on macOS systems.
  # It allows you to manage user-specific configurations and packages using Home Manager.
  home.username = username; # Set the username for Home Manager
  home.homeDirectory = homeDirectory; # Set the home directory for Home Manager

  # Set the Home-Manager state version; this should match the version of nix-darwin you are using.
  # Valid values can be found in the nix-darwin documentation: https://daiderd.com/nix-darwin/manual/index.html#opt-system.stateVersion
  home.stateVersion = "25.11"; # Using the latest state version for macOS 26 (Tahoe)

  # Home Manager module for Darwin (macOS)
  # This module configures Home Manager for the user on macOS systems.
  # It allows you to manage user-specific configurations and packages using Home Manager.
  home.packages = with pkgs; [
    # Add your desired packages here, e.g. git, zsh, etc.
    hello # A simple package to demonstrate Home Manager usage
  ];

  # Enable Home Manager for the user
  # This will ensure that Home Manager is enabled for the user and that the user has access
  # to the Home Manager environment.
  programs.home-manager.enable = true; # Enable Home Manager for the user

  ###################################################################################
  #  MacOS's Wallpaper configuration
  ###################################################################################

  # Set the system wallpaper for Darwin
  # This is useful for customizing the system appearance and behavior.
  # If you want to use a different wallpaper, you can change the following line
  # and set it to the desired wallpaper path.
  programs.wallpaper = {
    enable = true; # Enable wallpaper management
    image = "${projectRoot}/wallpaper.jpg"; # Path to the wallpaper image
    display = 0; # Display index (0 = primary screen)
  };
}