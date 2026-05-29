# nixos-maxxing

A heavily modularized, declarative NixOS configuration managing two hosts — a laptop and a desktop — with Nix Flakes, Home Manager, Stylix theming, and a curated selection of tools for development, gaming, and media.

<img width="1920" height="1076" alt="image" src="https://github.com/user-attachments/assets/bb937333-41ef-46cb-85a0-05c533db7d39" />

## Index

- [Screenshots](#screenshots)
- [Overview](#overview)
- [Hosts](#hosts)
  - [berzilinux (laptop)](#berzilinux-laptop)
  - [terra (desktop)](#terra-desktop)
- [Architecture](#architecture)
  - [Flake Structure](#flake-structure)
  - [Module System](#module-system)
  - [Secrets Management](#secrets-management)
  - [Theming](#theming)
- [Directory Structure](#directory-structure)
- [Window Managers](#window-managers)
  - [Niri](#niri)
  - [Hyprland](#hyprland)
  - [Noctalia Shell](#noctalia-shell)
- [Programs](#programs)
  - [Browsers](#browsers)
  - [Editors](#editors)
  - [Terminal & Shell](#terminal--shell)
  - [Gaming](#gaming)
  - [Media & Streaming](#media--streaming)
  - [Communication](#communication)
  - [Development](#development)
  - [System Tools](#system-tools)
  - [Virtualization](#virtualization)
- [Custom Packages](#custom-packages)
- [Scripts](#scripts)
- [Disk Layout (terra)](#disk-layout-terra)
- [Getting Started](#getting-started)
- [See Also](#see-also)

---



---

## Overview

This repo declaratively manages two complete NixOS systems plus a standalone Home Manager configuration. Every package, service, keybind, and theme is defined in Nix — reproducible across rebuilds.

Key technologies: **Nix Flakes**, **Home Manager**, **Stylix**, **Disko**, **SOPS/Agenix**, and **Niri/Hyprland** window managers.

---

## Hosts

### berzilinux (laptop)

| Property | Value |
|----------|-------|
| **User** | `berzi` |
| **GPU** | AMD + NVIDIA hybrid (PRIME sync) |
| **CPU** | AMD |
| **Root FS** | ext4 |
| **WM** | Hyprland |
| **Shell** | Zsh + oh-my-zsh + nitch |
| **Timezone** | Asia/Kolkata |
| **Home Manager** | Standalone (`home-manager switch --flake`) |

### terra (desktop)

| Property | Value |
|----------|-------|
| **User** | `chris` |
| **GPU** | AMD |
| **CPU** | AMD |
| **Root FS** | btrfs + LUKS (via Disko) |
| **WM** | Niri |
| **Shell** | Nushell + Starship + Carapace + Atuin |
| **Timezone** | America/New_York |
| **Home Manager** | NixOS module (inline) |

terra includes additional services not present on berzilinux: full media server stack (*arr + Jellyfin), Steam/Gamescope, Minecraft servers, Podman/Docker, SearXNG, Invidious, and Star Citizen.

---

## Architecture

### Flake Structure

```
flake.nix
├── nixosConfigurations.berzilinux   ── Host-specific NixOS + system modules
│   └── homeConfigurations.berzi     ── Standalone Home Manager
├── nixosConfigurations.terra        ── Host-specific NixOS + system modules + HM as module
└── (shared) system/ & home/         ── Common modules imported by both hosts
```

Both hosts import from the shared `system/` and `home/` directories but selectively include only the modules they need.

### Module System

Modules are organized by concern:

- `system/` — NixOS-level config (packages, services, programs, shell, greeter)
- `home/` — User-level config (window managers, programs, editors, browsers)
- `hosts/` — Host-specific overrides (hardware, host-specific packages)

Each subdirectory typically has a `default.nix` entry point that imports its children.

### Secrets Management

Two systems in use:

- **SOPS** (`sops-nix`): YAML-based encrypted secrets for service credentials (API keys, passwords for Jellyfin, *arr stack, qBittorrent, Mullvad, etc.)
- **Agenix**: age-encrypted individual secrets (e.g., Kagi API key)

### Theming

- **Stylix** for system-wide theming with a Catppuccin Mocha base16 scheme
- Custom theme alternatives in `assets/themes/base-16/` (noktis, oxocarbon, oled-lavender, oled-red)
- Consistent dark theme across all configured applications

---

## Directory Structure

```
nixos-maxxing/
├── assets/              Icons, wallpapers, and base16 color schemes
├── hosts/               Host-specific NixOS and Home Manager configs
│   ├── berzilinux/      Laptop config (AMD+NVIDIA, Hyprland)
│   └── terra/           Desktop config (AMD, Niri, btrfs+LUKS, Disko)
├── home/                Shared Home Manager modules
│   ├── hyprland/        Hyprland WM config (keybinds, rules, autostart, scripts)
│   ├── niri/            Niri WM config (keybinds, rules, autostart, scripts)
│   └── programs/        Browser, editor, terminal, game, and utility configs
├── pkgs/                Custom package definitions (AppImage/deb wrappers)
├── scripts/             Standalone shell scripts
├── secrets/             SOPS and Agenix encrypted secrets
├── system/              Shared NixOS modules
│   ├── environment.nix  Env vars, doas, polkit
│   ├── packages.nix     System-wide packages
│   ├── xdg.nix          XDG portal config
│   ├── greeter/         Greetd + tuigreet login manager
│   ├── programs/        System programs (Steam, Stylix, OBS, nix-ld, etc.)
│   ├── services/        System services (SSH, Flatpak, *arr, virtualization, etc.)
│   └── shell/           Zsh config
└── flake.nix            Flake entry point
```

---

## Window Managers

### Niri

Used on **terra**. A scrollable tiling Wayland compositor.

- Dual monitor: DP-2 (3840x1600@144Hz VRR) + HDMI-A-1 (1920x1080@60Hz)
- Named workspaces, configurable gaps/struts
- DDC/CI brightness control script
- Config: `home/niri/`

### Hyprland

Used on **berzilinux**. A dynamic tiling Wayland compositor.

- Same dual monitor layout
- Dindle layout, blur, shadows, animations
- DDC/CI brightness control script
- Config: `home/hyprland/`

### Noctalia Shell

Both WMs use [Noctalia Shell](https://github.com/noctalia-dev/noctalia-shell) (built on Quickshell) for the desktop shell. Widgets include: Launcher, Clock, SystemMonitor, VPN status, ActiveWindow, Workspace indicators, MediaMini, AudioVisualizer, Tray, NotificationHistory, Volume, and ControlCenter.

Config is in `home/{niri,hyprland}/noctaliashell.nix`.

---

## Programs

### Browsers

| Browser | Host | Notes |
|---------|------|-------|
| Firefox | berzilinux | Extensions: DarkReader, SponsorBlock, uBlock, 1Password, Kagi. Privacy-hardened. |
| Zen Browser | terra | Custom workspaces, containers, search engines (Kagi, NixOS Wiki). |
| Chromium | both | Extensions managed declaratively. |
| LibreWolf | both | Privacy-hardened Firefox fork. |
| Vivaldi | both | |
| Helium | both | Custom package (`pkgs/helium.nix`). |

Config: `home/programs/browsers/`

### Editors

| Editor | Notes |
|--------|-------|
| Helix | Primary editor |
| Zed | Extensive settings configured |
| VSCodium | Large extension set, LSPs, themes |
| JetBrains | IntelliJ IDEA + RustRover + Toolbox |
| NixVim | Neovim config via NixVim (currently disabled) |

Config: `home/programs/editors/`

### Terminal & Shell

| Component | berzilinux | terra |
|-----------|------------|-------|
| Terminal | Ghostty | Ghostty |
| Shell | Zsh + oh-my-zsh + nitch | Nushell + Starship + Carapace + Atuin |
| Smart cd | Zoxide | Zoxide |

Config: `home/programs/ghostty.nix`, `home/programs/terminal/`

### Gaming

- **Steam** with Gamescope session, Gamemode, ProtonTricks, Wine/Winetricks
- **Minecraft**: PrismLauncher, Lunar Client, multiple Java versions
- **Minecraft server**: PaperMC, Vanilla, Purpur via nix-minecraft
- **Minecraft speedrunning**: Waywall overlay with thin/wide/tall modes, NinjaBrain bot
- **Star Citizen** via nix-citizen
- **BakkesMod** for Rocket League
- **MangoHud** + MangoJuice (Catppuccin themed)
- Additional: Beyond All Reason, Starsector, iw4x (CoD), CLI games

Config: `system/programs/steam.nix`, `system/programs/minecraft.nix`, `system/programs/mcsr/`

### Media & Streaming

Full self-hosted media stack (primarily on terra):

| Service | Purpose |
|---------|---------|
| Jellyfin | Media server |
| Plex | Media server |
| Sonarr | TV + Anime management |
| Radarr | Movie management |
| Lidarr | Music management |
| Prowlarr | Indexer management |
| Bazarr | Subtitle management |
| Tautulli | Analytics |
| qBittorrent | Torrent client |
| Mullvad VPN | VPN for torrenting |

Additional: FreeTube, Spotify, Cider-2, mpv, Cava (audio visualizer).

Config: `system/programs/obs.nix`, `system/services/streaming.nix`

### Communication

- **Discord** via Nixcord/Equicord with 80+ plugins (code formatting, voice enhancements, UI tweaks)
- **FluffyChat** (Matrix client)
- **Fastmail** + **ProtonMail** desktop entries

Config: `home/programs/discord.nix`, `home/programs/chat.nix`, `home/programs/email.nix`

### Development

Languages and tools: Go, Rust (cargo/rustc/rustup), Python3, GCC, GMake, Ollama, KoboldCpp, LM Studio, SillyTavern.

Game dev: Godot, Unity Hub.

Config: `home/programs/gamedev/`

### System Tools

Yazi (file manager), eza, btop, fastfetch, nh (Nix helper), direnv, alejandra/nixfmt (Nix formatters), nil/nixd (Nix LSPs), Jujutsu (VCS), gitleaks, zoxide, tealdeer, tree, jq, socat, playerctl, waypaper, ddcutil, localsend, xremap (CapsLock -> Ctrl/Esc).

Config: `system/packages.nix`, `home/programs/`

### Virtualization

Podman (with Docker compatibility), QEMU/Quickemu, Distrobox, kubectl, Kind.

Config: `system/services/virtualization.nix`

---

## Custom Packages

Packages in `pkgs/` that aren't available in nixpkgs or NUR:

| Package | Description |
|---------|-------------|
| `jackify` | Wabbajack modlist installer for Linux (AppImage) |
| `amethyst` | Amethyst Mod Manager for Linux (AppImage) |
| `helium` | Helium browser — privacy-focused Chromium fork (AppImage, multi-arch) |
| `iloader` | iOS IPA sideloading tool (.deb) |

---

## Scripts

Standalone scripts in `scripts/`:

| Script | Purpose |
|--------|---------|
| `disable_usb_wakup.sh` | Disables USB devices from waking the system from suspend |
| `eso-trade-update.sh` | Downloads and extracts Elder Scrolls Online trade pricing data |
| `fetch-firefox-addon.sh` | Extracts Firefox extension IDs from addon URLs |
| `proton-wine.sh` | Runs Wine through a specific Proton version via steam-run |
| `rdo-private.sh` | Forces a private lobby in Red Dead Online via iptables rules |
| `restart-noctalia.sh` | Kills and restarts the Noctalia Shell (Quickshell) process |
| `faf-setup.sh` | Creates Proton run configuration for Supreme Commander: FAF |

---

## Disk Layout (terra)

Managed declaratively with **Disko**:

- **Root**: LUKS-encrypted btrfs with subvolumes: `root`, `home`, `nix`, `persist`, `log`, `lib`, `swap` (64GB)
- **Games SSD**: btrfs with zstd compression (optional)
- **Data HDD**: btrfs with zstd compression (optional)

Config: `hosts/terra/disk-config.nix`, `hosts/terra/disk-games.nix`, `hosts/terra/disk-data.nix`

---

## Getting Started

1. Clone this repository:
   ```sh
   git clone https://github.com/your-username/nixos-maxxing.git
   ```

2. Replace the `hardware-configuration.nix` files with ones generated for your hardware:
   ```sh
   sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
   ```

3. Update `flake.nix` to define your own host or adjust the existing ones.

4. Change usernames, timezone, and any host-specific settings in the relevant `hosts/<hostname>/` files.

5. Set up secrets if needed (SOPS/Agenix) or remove the secrets modules.

6. Build and switch:
   ```sh
   # For a NixOS configuration:
   sudo nixos-rebuild switch --flake .#your-hostname

   # For standalone Home Manager:
   home-manager switch --flake .#your-username
   ```

> **Note:** You may need to update `flake.lock` with `nix flake update` and adjust inputs to match your preferences.

---

## See Also

- [NixOS](https://nixos.org/) — The declarative operating system used to make this all possible
- [NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world/introduction/) — Incredible written learning resource for getting started
- [Vimjoyer](https://www.youtube.com/@vimjoyer) — Video resources for getting started with Nix concepts
- [Niri](https://github.com/YaLTeR/niri) — Window manager used for this setup. Offers infinite horizontal scrolling
- [Noctalia Shell](https://github.com/noctalia-dev/noctalia-shell) — Desktop shell built on Quickshell with extensive widget support
- [Catppuccin](https://catppuccin.com/) — Lovely theme for nearly any application. Allows for cohesive and cozy styling
- [Disko](https://github.com/nix-community/disko) — Declarative disk partitioning for NixOS
- [SOPS-nix](https://github.com/Mic92/sops-nix) — Secrets management for NixOS
