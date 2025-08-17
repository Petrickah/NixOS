{ config, pkgs, ... }:
{
  imports = [
    ../flake-systems/common.nix
    ../hosts/host.nix
  ];
  # VM-specific options here
}
