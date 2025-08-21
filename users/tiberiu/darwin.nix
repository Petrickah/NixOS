{ self, pkgs, ... }:
{
  #####################################################################################
  #  MacOS's User configuration
  #####################################################################################

  # Set the netorking configuration for Darwin
  # This is important for ensuring that the system can connect to the network.
  # If you want to use a different hostname, you can change the following line
  # and set it to the desired hostname.
  networking.hostName = "Mac-mini-Tiberiu"; # Set the hostname for the system; this should match your machine's hostname
  networking.computerName = "Mac-mini-Tiberiu"; # Set the computer name for the system; this should match your machine's hostname

  # Declare the user for whom the Nix environment is configured
  # This is necessary for ensuring that the Nix environment is set up correctly for the user
  # and that the user has access to the Nix environment.
  users.users.tiberiu = {
    name = "tiberiu"; # Set the username for the user account
    home = "/Users/tiberiu"; # Replace with your actual home directory

    # Set the default shell for the user
    # This is necessary for ensuring that the user has access to the default shell
    # and that the user can use the default shell as their default shell.
    shell = pkgs.zsh; # Set the default shell for the user

    # Add your SSH public key here to allow SSH access
    openssh.authorizedKeys.keys = [ ];
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
}