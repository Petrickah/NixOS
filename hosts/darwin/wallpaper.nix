{ config, lib, pkgs, ... }:

let
  cfg = config.programs.wallpaper;
in {
  options.programs.wallpaper = {
    enable = lib.mkEnableOption "Set wallpaper using desktoppr";

    image = lib.mkOption {
      type = lib.types.path;
      description = "Path to the wallpaper image";
    };

    display = lib.mkOption {
      type = lib.types.int;
      default = 0;
      description = "Display index (0 = primary screen)";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add activation script
    home.activation.wallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      echo "Setting wallpaper for display ${toString cfg.display}"
      ${pkgs.writeShellScriptBin "set-wallpaper" ''
        exec ${pkgs.coreutils}/bin/env desktoppr ${toString cfg.display} ${cfg.image}
      ''}/bin/set-wallpaper
    '';
  };
}
