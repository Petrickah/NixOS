{ config, pkgs, ... }:
{
  # Home Manager module for Darwin (macOS)
  home.packages = with pkgs; [
    # Add your desired packages here, e.g. git, zsh, etc.
  ];

  # Set the Home-Manager state version; this should match the version of nix-darwin you are using.
  # Valid values can be found in the nix-darwin documentation: https://daiderd.com/nix-darwin/manual/index.html#opt-system.stateVersion
  home.stateVersion = "25.11"; # Using the latest state version for macOS 26 (Tahoe)

  # Create the /etc/zshrc that loads the Nix environment
  # This is necessary for ensuring that the zsh configuration is set up correctly.
  # If you want to use a different shell, you can replace pkgs.zsh with the desired shell package.
  # For example, if you want to use bash, you would use
  # pkgs.bash instead.
  # For more information, see: https://nixos.wiki/wiki/Nixpkgs
  programs.zsh = {
    enable = true; # Enable zsh as the default shell
    # Set the zsh configuration file to load the Nix environment
    shellInit = ''
      # Load the Nix environment for zsh
      if [ -e /etc/profile ]; then
        . /etc/profile
      fi
      # Load the Nix environment for the user
      if [ -e /Users/tiberiu/.nix-profile/etc/profile.d/nix.sh ]; then
        . /Users/tiberiu/.nix-profile/etc/profile.d/nix.sh
      fi
    '';
  };
}