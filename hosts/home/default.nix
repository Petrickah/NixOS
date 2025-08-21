{ self, lib, pkgs, username, homeDirectory, ... }:
{
  ###################################################################################
  #  Home Manager configuration
  ###################################################################################

  imports = [
    # Import the Wallpaper module for Darwin (macOS)
    # This is necessary for ensuring that the Home Manager configuration is set up correctly for the user
    # and that the user has access to the Home Manager environment.
    ../../hosts/home/wallpaper.nix
  ];

  # This module configures Home Manager for the user on macOS systems.
  # It allows you to manage user-specific configurations and packages using Home Manager.
  home.username = username; # Set the username for Home Manager
  home.homeDirectory = homeDirectory;

  # Set the Home-Manager state version; this should match the version of nix-darwin you are using.
  # Valid values can be found in the nix-darwin documentation: https://daiderd.com/nix-darwin/manual/index.html#opt-system.stateVersion
  home.stateVersion = "25.11"; # Using the state version for NixOS 25.11

  # Home Manager module for Darwin (macOS)
  # This module configures Home Manager for the user on macOS systems.
  # It allows you to manage user-specific configurations and packages using Home Manager.
  home.packages = with pkgs; [
    # Add your desired packages here, e.g. git, zsh, etc.
    hello # A simple package to demonstrate Home Manager usage
    curl # A command tool interface for transfering data from internet
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

    # Set the path to the wallpaper image
    # This is necessary for ensuring that the wallpaper is set correctly for the user
    # and that the user has access to the wallpaper image.
    # Replace with your actual wallpaper image path.
    # For example, you can use a local image file or a remote URL.
    # Note: The image path should be accessible to the user.
    imagePath = "/Users/tiberiu/Pictures/Wallpapers/jgycezrufvif1.png"; # Path to the wallpaper image

    # Set the URL to download the wallpaper image if it does not exist
    # This is useful for ensuring that the wallpaper is set correctly for the user
    # and that the user has access to the wallpaper image.
    # If the image does not exist, the script will attempt to download it from the specified URL.
    # If you want to use a default wallpaper, you can set this to a valid URL.
    # For example, you can use a public image URL or a remote image file.
    # If you leave this as null, the script will not attempt to download the image.
    imageUrl = "https://i.redd.it/jgycezrufvif1.png";

    # Set the display index for the wallpaper
    # This is necessary for ensuring that the wallpaper is set correctly for the user
    # and that the user has access to the correct display.
    # If you have multiple displays, you can change the following line
    # and set it to the desired display index.
    # The display index is zero-based, so 0 refers to the primary screen.
    display = 0; # Display index (0 = primary screen)
  };
}