# NixOS Configuration

A modular NixOS system configuration with security hardening, NVIDIA GPU support, and a customized desktop environment.

## Overview

This configuration uses a modular approach, separating concerns into `modules/`:
- `boot.nix` - Bootloader, kernel params, sysctl hardening, module blacklisting
- `desktop.nix` - X server, GNOME, audio, printing, security features
- `hardware.nix` - GPU drivers (NVIDIA + AMD), Bluetooth
- `networking.nix` - Hostname, NetworkManager, timezone, locale
- `packages.nix` - System-wide package selection
- `users.nix` - User account and Docker

---

## Module Details

### `configuration.nix` (Main Entry)

- Imports hardware-generated config + all modules
- Enables **flakes** experimental feature for declarative Nix
- Allows **unfree packages** (needed for Discord, Steam, etc.)
- State version: **23.11**

### `modules/boot.nix` - Boot & Security Hardening

**Differs from default:**
- Uses **systemd-boot** (default is GRUB) with EFI variables
- Disabled boot editor (security)
- **Kernel params**: `nvidia-drm.modeset=1` for NVIDIA DRM
- **Kernel hardening sysctls**: kptr_restrict, TCP syncookies, reverse path filtering, martian logging, disabled redirects, ptrace_scope=2
- **Disabled**: BPF JIT, ftrace (attack surface reduction)
- **Blacklisted modules**: Uncommon network protocols (ax25, netrom, rose), legacy filesystems (adfs, hfs, hpfs, jfs, etc.), vivid

### `modules/desktop.nix` - Desktop Environment

**Differs from default:**
- Uses **GNOME** (not KDE/other)
- **GDM** as display manager
- **physlock** screen locker (default: none)
- **PipeWire** audio (default: PulseAudio)
- Printing enabled
- **Security features**: rtkit, kernel image protection, page table isolation
- US keyboard layout only

### `modules/hardware.nix` - GPU & Peripherals

**Differs from default:**
- **NVIDIA** driver with modesetting + power management enabled
- **AMD** GPU also configured (dual GPU/AMD dGPU present)
- **PRIME sync** enabled (not offload) - uses NVIDIA by default for max performance
- Explicit **PCI bus IDs** for Prime (NVIDIA: PCI:1:0:0, AMD: PCI:5:0:0)
- **Bluetooth** enabled at boot

### `modules/networking.nix` - Network & Locale

**Differs from default:**
- **Hostname**: `berzilinux` (default: unset)
- **NetworkManager** enabled (default: may use wpa_supplicant)
- **Timezone**: Asia/Kolkata (India)
- **Locale**: en_IN (Indian English) with full locale settings for all LC_* categories

### `modules/packages.nix` - Installed Software

**Differs from default (more than 40 packages added):**
- **Terminal/UI**: oh-my-posh (shell prompt), kitty (terminal), vim, nitch (system info)
- **Media**: vlc, mpv, ffmpeg, flameshot (screenshot)
- **Communication**: discord, spotify
- **Development**: git, gcc, go, rust/cargo, helix, build tools (make, autoconf, automake)
- **CLI utilities**: fzf (fuzzy finder), zoxide (cd alternative), htop, eza (ls replacement), stow, curl, wget
- **System**: lshw, python3, gawk, zip/unix

### `modules/users.nix` - User Management

**Differs from default:**
- User: `berzi` with description "ayush"
- **Docker** enabled and user added to docker group (default: disabled)
- Extra groups: networkmanager, wheel, docker
- User gets **firefox** package (not system-wide)

---

## Usage

```bash
# Rebuild system
sudo nixos-rebuild switch --flake .#nixos

# Or for testing first
sudo nixos-rebuild test --flake .#nixos
```

## Key Customizations Summary

| Feature | This Config | Default |
|---------|-------------|---------|
| Bootloader | systemd-boot | GRUB |
| Desktop | GNOME + GDM | None |
| Audio | PipeWire | PulseAudio |
| GPU | NVIDIA + AMD PRIME | Auto |
| Screen locker | physlock | None |
| Docker | Enabled | Disabled |
| Security hardening | Yes (sysctls, module blacklist) | Minimal |
| flakes | Enabled | Disabled |