{ config, pkgs, ... }:
{
  # Common configuration shared by host and VM
  # Declare the user for whom the Nix environment is configured
  users.users.tiberiu = {
    name = "tiberiu";
    home = "/Users/tiberiu"; # Replace with your actual home directory
    description = "Tiberiu's user account"; # A description for the user account
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
}
