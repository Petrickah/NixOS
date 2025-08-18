{ config, lib, pkgs, ... }:

{
  options = {
    system.exampleOption = lib.mkOption {
      type = lib.types.str;
      default = "defaultValue";
      description = "An example option for the system module.";
    };
  };

  config = {
    # Example configuration, customize as needed
    environment.systemPackages = with pkgs; [
      # Add system-wide packages here
    ];
  };
}