{ self, pkgs, ... }:
{
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