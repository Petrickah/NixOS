{ self, lib, pkgs, username, homeDirectory, hostname, ... }:
{
  ###################################################################################
  #  NixOS's System configuration
  ###################################################################################

  # This module configures the NixOS system for a standard NixOS host.
  # It sets up the system configuration, user environment, and networking settings.
  # It is designed to work with the NixOS system and provides a basic setup
  # for a standard NixOS host.
  imports = [
    # Import the Basic Configuration for NixOS
    # This is necessary for ensuring that the Nix environment is set up correctly for the user
    # and that the user has access to the Nix environment.
    ../../../hosts/nixos-host/system/configuration.nix

    # Import the Hardware Configuration for NixOS
    # This is important for ensuring that the system is configured correctly for NixOS.
    ../../../hosts/nixos-host/system/hardware-configuration.nix
  ];

  networking = {
    # Enable networking
    networkmanager.enable = true;

    # Set the networking configuration for Darwin
    hostName = hostname; # Set the hostname for the system
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  }

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tiberiu = {
    isNormalUser = true; # Set the user as a normal user account
    name = username; # Set the username for the user account
    home = homeDirectory; # Replace with your actual home directory
    shell = pkgs.zsh; # Set the default shell for the user

    # Set the description for the user account
    # This is useful for identifying the user account in the system.
    # It can be used to provide additional information about the user account.
    # For example, you can set the description to "Tiberiu" to
    # identify the user account as belonging to Tiberiu.
    description = "Tiberiu"; # Set the description for the user account

    # Set the extra groups for the user account
    # This is useful for granting the user account additional permissions
    # or access to specific resources in the system.
    # For example, you can add the user to the "networkmanager" group
    # to allow the user to manage network connections.
    # You can also add the user to the "wheel" group to allow the user to
    # execute commands with elevated privileges using `sudo`.
    # You can add any additional groups that you need for the user account.
    extraGroups = [ "networkmanager" "wheel" ];

    # Set the packages for the user account
    # This is useful for installing additional software packages
    # that the user account needs to use.
    # For example, you can install the "kate" text editor and "zsh"
    # shell for the user account.
    # You can add any additional packages that you need for the user account.
    packages = with pkgs; [
      kdePackages.kate
      zsh
    ];
  };

  # Set the Nix configuration for Darwin
  nix = {
    enable = true; # Disable the Nix daemon service on Darwin
    settings = {
      trusted-users = [ "tiberiu" ]; # Set trusted users for Nix
      experimental-features = [ "nix-command" "flakes" ]; # Enable experimental features
    };
  };


  # Set the system configuration for NixOS
  # This is important for ensuring that the system is configured correctly for NixOS.
  # Note: This is necessary for using the Nix command and flakes.
  ###################################################################################
  # Set the system locale and timezone
  ###################################################################################

  # Set your time zone.
  time.timeZone = "Europe/Bucharest"; # Set the timezone to East European Time (Romania)

  # Select internationalisation properties.
  i18n.defaultLocale = "ro_RO.UTF-8";
}