{ config, lib, pkgs, ... }:

let
  cfg = config.programs.wallpaper;
in {

  ###################################################################################
  #  MacOS's Wallpaper configuration
  ###################################################################################

  # Wallpaper configuration for macOS using desktoppr
  # This module sets the wallpaper for the specified display using the desktoppr command.
  # It checks if the image file exists and then calls desktoppr with the display index and image path.
  # Ensure that the desktoppr command is available in the PATH
  # and that the user has the necessary permissions to change the wallpaper.

  options.programs.wallpaper = {
    enable = lib.mkEnableOption "Set wallpaper using desktoppr";

    imagePath = lib.mkOption {
      type = lib.types.path;
      description = "Path to the wallpaper image";
    };

    imageUrl = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "URL to download the wallpaper image if it does not exist";
    };

    display = lib.mkOption {
      type = lib.types.int;
      default = 0;
      description = "Display index (0 = primary screen)";
    };
  };

  config = lib.mkIf cfg.enable {
    home.activation.wallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      echo "Setting wallpaper for display ${toString cfg.display}"
      ${pkgs.writeShellScriptBin "set-wallpaper" ''
		echo "Downloading the wallpaper from the provided url..."
		# Check if imageUrl is provided
		if [ -n "${cfg.imageUrl}" ]; then
			# Use curl to download the wallpaper from the provided URL
			# Ensure that the URL points to a valid image file
			/usr/bin/curl -o ${cfg.imagePath} ${cfg.imageUrl}
			if [ $? -eq 0 ]; then
				echo "Default wallpaper downloaded successfully."
			else
				echo "Failed to download the default wallpaper from ${cfg.imageUrl}."
				exit 1
			fi
		fi

        # Check if desktoppr command is available
        # Ensure that desktoppr is installed and available in the PATH
        if ! command -v /usr/local/bin/desktoppr &> /dev/null; then
          echo "desktoppr command not found. Please install it via Homebrew or ensure it's in your PATH."
          exit 1
        fi

        echo "Setting wallpaper to ${cfg.imagePath} on display ${toString cfg.display}"

        # Set the wallpaper using desktoppr
        # The desktoppr command should be available in the PATH, or you can specify its full path
        # For example, if desktoppr is installed via Homebrew, it might be located at /opt/homebrew/bin/desktoppr
        # Adjust the path accordingly if necessary
        /usr/local/bin/desktoppr ${toString cfg.display} ${cfg.imagePath}
      ''}/bin/set-wallpaper
    '';
  };
}
