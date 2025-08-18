{ self, config, pkgs, ... }:
{
  # Darwin (MacOS) configuration for this Mac Mini M4 Pro
  # Use nix-darwin modules here

  imports = [
    # Common configuration shared by host and VM
    ../modules/common.nix
  ];

  # Disable the Nix package manager on Darwin
  # This is necessary for ensuring that the Nix package manager is enabled on Darwin.
  # If you want to enable the Nix daemon service, you can change the following line 
  # and set it to true.
  nix.enable = false; # Disable the Nix daemon service on Darwin

  # Necessary for using flakes and other Nix features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  # Set the system architecture for Nixpkgs
  # This is important for ensuring that packages are built for the correct architecture.
  # For Apple Silicon Macs (M1/M2/M4), use aarch64-darwin.
  # For Intel-based Macs, use x86_64-darwin.
  # To enable Rosetta 2 (for running Intel binaries on Apple Silicon), set up the following:
  #   1. Install Rosetta 2: `softwareupdate --install-rosetta --agree-to-license`
  #   2. You can also use `nixpkgs.config.allowUnsupportedSystem = true;` for unsupported systems.
  # Example for Apple Silicon:
  nixpkgs.hostPlatform = "aarch64-darwin";
  # Example for Intel Mac (uncomment if needed):
  # nixpkgs.hostPlatform = "x86_64-darwin";
  # Example to allow Rosetta 2 (uncomment if needed):
  nixpkgs.config.allowUnsupportedSystem = true;

  # Set the Nixpkgs configuration to allow broken packages
  # This is useful for development and testing, but should be used with caution.
  # If you want to allow broken packages, you can uncomment the following line.
  # For more information, see: https://nixos.wiki/wiki/Nixpkgs
  # and https://nixos.wiki/wiki/Nixpkgs#Allow_broken_packages
  nixpkgs.config.allowBroken = true; # Allow broken packages in Nixpkgs

  # Declare the user for whom the Nix environment is configured
  users.users.tiberiu = {
    name = "tiberiu";
    home = "/Users/tiberiu"; # Replace with your actual home directory
    description = "Tiberiu's user account"; # A description for the user account
  };

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

  # Enable the zsh shell for the user
  # This is necessary for ensuring that the user can use zsh as their shell.
  users.users.tiberiu.shell = pkgs.zsh; # Set zsh as the user's shell
  # This will ensure that the user has access to the Nix environment when using zsh.
  # If you want to use a different shell, you can replace pkgs.zsh with the desired shell package.
  # For example, if you want to use bash, you would use pkgs.bash instead.
  # For more information, see: https://nixos.wiki/wiki/Nixpkgs
  # and https://nixos.wiki/wiki/Nixpkgs#Shells
  # and https://nixos.wiki/wiki/Nixpkgs#Shell_configuration

  environment.systemPackages = with pkgs; [
    # Add common packages that you want to have available in the Nix environment
    git
    vim
    wget
    curl
    htop
    zsh
    # Add any other packages you want to have available in the Nix environment
    neofetch
  ];

  # Enable Homebrew on Darwin
  # This will allow you to use Homebrew packages alongside Nix packages.
  # For more information, see: https://nixos.wiki/wiki/Homebrew
  # Note: Homebrew is not officially supported on NixOS, but it can be used on Darwin systems
  # to provide additional packages that may not be available in Nixpkgs.
  # If you want to use Homebrew, you can enable it here and add any Homebrew packages you want to use.
  # For more information, see: https://nixos.wiki/wiki/Homebrew#Using_Homebrew_on_Darwin
  # and https://nixos.wiki/wiki/Homebrew#Homebrew_on_Darwin
  homebrew = {
    enable = true; # Enable Homebrew on Darwin
    # This will allow you to use Homebrew packages alongside Nix packages.
    # For more information, see: https://nixos.wiki/wiki/Homebrew

    taps = [];
    brews = [
      # Add any Homebrew packages you want to use
      "cowsay"
	  "direnv"
    ];
    casks = [
      # Add any Homebrew casks you want to use
      "google-chrome"
      "visual-studio-code"
      "discord"
    ];
  };
}
