{ self, pkgs, ... }:
{
  # Add system packages that you want to have available in the Nix environment
  # This is necessary for ensuring that the Nix environment is set up correctly for the user
  # and that the user has access to the Nix environment.
  # For more information, see: https://nixos.wiki/wiki/Nixpkgs
  # and https://nixos.wiki/wiki/Nixpkgs#System_packages
  environment.systemPackages = with pkgs; [
    git
    vim
    zsh
  ];

  # Enable Homebrew on Darwin
  # This will allow you to use Homebrew packages alongside Nix packages.
  # For more information, see: https://nixos.wiki/wiki/Homebrew
  homebrew = {
    # If you want to use Homebrew, you can enable it here and add any Homebrew packages you want to use.
    # This will allow you to use Homebrew packages alongside Nix packages.
    # Note: Homebrew is not officially supported on NixOS, but it can be used on Darwin systems
    # to provide additional packages that may not be available in Nixpkgs.
    # For more information, see: https://nixos.wiki/wiki/Homebrew#Using_Homebrew_on_Darwin
    # and https://nixos.wiki/wiki/Homebrew#Homebrew_on_Darwin
    enable = true; # Enable Homebrew on Darwin

    masApps = {
      # Specify the Mac App Store applications you want to install
      # This is necessary for ensuring that the Mac App Store applications are available in the Nix environment
      # and that the user has access to the Mac App Store applications.
      Xcode = 497799835; # Xcode is a common development tool for macOS
      Amphetamine = 937984704; # Amphetamine is a popular app to prevent sleep on macOS
    };

    # Specify the Homebrew packages you want to use
    # This is necessary for ensuring that the Homebrew packages are available in the Nix environment
    # and that the user has access to the Homebrew packages.
    brews = [
      # Add any Homebrew packages you want to use
      "mas" # Mac App Store command-line interface
      "wget" # Command-line utility for downloading files from the web
      "curl" # Command-line tool for transferring data with URLs
      "neofetch" # Command-line utility to display system information
	    "direnv"
    ];

    # You can also use Homebrew to install casks (macOS applications) and other
    # Homebrew packages that are not available in Nixpkgs.
    # For more information, see: https://nixos.wiki/wiki/Homebrew#Homebrew_casks
    # and https://nixos.wiki/wiki/Homebrew#Homebrew_packages
    casks = [
      # Add any Homebrew casks you want to use
      "google-chrome"
      "visual-studio-code"
      "discord"
      "github"
    ];
  };
}