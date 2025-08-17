

# Nix Flake: Multi-System Workspace

This repository provides a unified Nix Flake setup for managing multiple systems and environments, including:

- **NixOS Host**: The main NixOS machine, serving as the primary host configuration.
- **NixOS VM**: A virtual machine running NixOS, sharing much of its configuration with the host for testing and development.
- **MacOS Darwin**: This Mac Mini M4 Pro, managed with [nix-darwin](https://github.com/LnL7/nix-darwin), using the Nix package manager for reproducible configuration.

## Scope

This workspace aims to:

- Provide a single source of truth for system configuration across Linux (NixOS) and MacOS.
- Enable reproducible builds and environments for all systems using Nix Flakes.
- Share configuration between the NixOS host and VM, reducing duplication and easing testing.
- Document and template the setup for MacOS, making it easier to onboard new machines or migrate environments.

## Structure

- `flake.nix` / `flake.lock`: Flake entrypoints and dependency pins.
- `hosts/`: Host-specific configuration for NixOS and Darwin (MacOS).
- `modules/`: Common modules shared across the systems.
- `.github/`: Project automation and Copilot instructions.

## Getting Started

### 1. Clone the repository
Clone this repository to your machine:

```sh
git clone https://github.com/your-username/your-repo.git
cd your-repo
```


### 2. (Apple Silicon only) Install and enable Rosetta 2 (for Intel compatibility)
If you are using an Apple Silicon Mac (M1/M2/M4) and want to run Intel (x86_64) binaries or Nix packages, you need to install Rosetta 2:

```sh
sudo softwareupdate --install-rosetta --agree-to-license
```

To allow Nix to build and run x86_64-darwin packages, you can add the following to your `hosts/darwin.nix`:

```nix
nixpkgs.config.allowUnsupportedSystem = true;
```

---

### 3. Install the Nix package manager

#### On NixOS
Nix is preinstalled. No action needed.

#### On macOS
Run the following command in your terminal:

```sh
sh <(curl -L https://nixos.org/nix/install)
```

After installation, restart your terminal or source your profile as instructed by the installer.

### 4. (macOS only) Install Homebrew (optional, but recommended)
If you want to use Homebrew-managed packages with nix-darwin, install Homebrew **before** applying your flake:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

This ensures nix-darwin can manage Homebrew packages as part of your system configuration.

### 5. Deploy the flake

#### On NixOS
To build and switch to your configuration:

```sh
sudo nixos-rebuild switch --flake .#nixosHost
```
Replace `nixosHost` with the appropriate hostname if needed (see `hosts/nixos_host.nix`).

#### On macOS (nix-darwin)
To build and switch to your configuration:

```sh
darwin-rebuild switch --flake .#Mac-mini-Tiberiu
```
Replace `Mac-mini-Tiberiu` with your actual hostname if different (see `hosts/darwin.nix`).

## Requirements

- [Nix](https://nixos.org/download.html) with Flakes enabled
- For MacOS: [nix-darwin](https://github.com/LnL7/nix-darwin)
- For NixOS: Standard NixOS installation
- For VMs: You may add your own configuration and modules as needed.
- For Homebrew integration on macOS: [Homebrew](https://brew.sh/) (install before using the flake)

## Contributing

Contributions and suggestions are welcome! Please open issues or pull requests for improvements or questions.

---
This workspace is designed to be a flexible, reproducible foundation for managing multiple operating systems with Nix.
