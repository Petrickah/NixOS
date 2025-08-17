{ config, pkgs, ... }:
{
  imports = [
    ../modules/common.nix
    ../hosts/host.nix
  ];
  # VM-specific options here
}
