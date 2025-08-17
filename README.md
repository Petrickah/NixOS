
# Nix Flake: Multi-System Workspace

This repository provides a unified Nix Flake setup for managing multiple systems and environments, including:

- **NixOS Host**: The main NixOS machine, serving as the primary host configuration.
- **NixOS VM**: A virtual machine running NixOS, sharing much of its configuration with the host for testing and development.
- **Windows 11 VM**: A Windows 11 virtual machine, intended for interoperability, testing, or development needs.
- **MacOS Darwin**: This Mac Mini M4 Pro, managed with [nix-darwin](https://github.com/LnL7/nix-darwin), using the Nix package manager for reproducible configuration.

## Scope

This workspace aims to:

- Provide a single source of truth for system configuration across Linux (NixOS), Windows, and MacOS.
- Enable reproducible builds and environments for all systems using Nix Flakes.
- Share configuration between the NixOS host and VM, reducing duplication and easing testing.
- Document and template the setup for Windows and MacOS, making it easier to onboard new machines or migrate environments.

## Structure

- `flake.nix` / `flake.lock`: Flake entrypoints and dependency pins.
- `flake-systems/`: Common modules and system definitions shared across machines.
- `hosts/`: Host-specific configuration for NixOS and Darwin (MacOS).
- `vms/`: VM-specific configuration for NixOS and Windows.
- `.github/`: Project automation and Copilot instructions.

## Getting Started

1. **Clone this repository** to your machine.
2. **Review and customize** the configuration files in `hosts/`, `vms/`, and `flake-systems/` as needed.
3. For NixOS or VM systems, use `nixos-rebuild` or `nix build` as appropriate.
4. For MacOS, use `nix-darwin` commands to apply the configuration.
5. For Windows, follow the documentation or template in `vms/windows11-vm.nix`.

## Requirements

- [Nix](https://nixos.org/download.html) with Flakes enabled
- For MacOS: [nix-darwin](https://github.com/LnL7/nix-darwin)
- For NixOS: Standard NixOS installation
- For VMs: Appropriate virtualization software (e.g., QEMU, VirtualBox, Parallels)

## Contributing

Contributions and suggestions are welcome! Please open issues or pull requests for improvements or questions.

---
This workspace is designed to be a flexible, reproducible foundation for managing multiple operating systems with Nix.
