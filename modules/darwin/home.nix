{ config, pkgs, ... }:
{
  # Home Manager module for Darwin (macOS)
  home.packages = with pkgs; [
    # Add your desired packages here, e.g. git, zsh, etc.
  ];

  # Set the Home-Manager state version; this should match the version of nix-darwin you are using.
  # Valid values can be found in the nix-darwin documentation: https://daiderd.com/nix-darwin/manual/index.html#opt-system.stateVersion
  home.stateVersion = "25.11"; # Using the latest state version for macOS 26 (Tahoe)
}