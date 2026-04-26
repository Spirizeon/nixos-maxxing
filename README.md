# NixOS Flake Configuration

> A modular NixOS system configuration using dendritic flake patterns — because your OS config should grow like a tree, not explode like a spaghetti bowl.

## What's This?

This is my NixOS configuration, reimagined with **dendritic patterns** — a fancy word for "tree-like structure." Instead of one giant configuration file with everything tangled together, I've broken everything into branches that flow from a single root.

Think of it like organizing your room: instead of throwing everything into one drawer, you use shelves. Each shelf has a purpose. That's what flakes do for your OS config.


<img width="4872" height="500px" alt="diagram(2)" src="https://github.com/user-attachments/assets/69203486-69f3-49e1-a3f6-8800ffad8bea" />

## The Dendritic Structure

```
flake.nix          ← The root (trunk)
├── nixos/         ← Main branches (categories)
│   ├── boot/      ← Boot stuff
│   ├── hardware/ ← GPU, bluetooth
│   ├── networking/ ← Network, locale
│   ├── desktop/   ← Desktop environment
│   ├── packages/  ← Software to install
│   └── users/     ← User accounts
├── hosts/         ← Machine-specific configs
│   └── default.nix
└── lib/           ← Shared utilities
    └── default.nix
```

### Why Break It Up?

**1. Find things easily**
> Old way: "Where did I put that firewall rule?" → Search through 500 lines of chaos
> New way: "It's in `nixos/networking/default.nix`" → 5 seconds flat

**2. Reuse across machines**
> Got a desktop and a laptop? Share the same `packages` branch between both. Just plug in the hardware branch that matches each machine.

**3. Test safely**
> Want to try a new package? Edit only `nixos/packages/default.nix`. Mess it up? The rest of your system keeps working.

**4. Collaborate**
> Your friend likes your desktop setup? Send them just the `nixos/desktop/` branch. No need to share your WiFi password or custom packages.

### Why "Dendritic"?

In biology, dendrites are the branches that receive signals in neurons. They're modular, redundant, and efficient. If one branch gets damaged, the cell survives.

That's exactly what we want:
- **Modular**: Each branch does one thing
- **Resilient**: One broken branch doesn't crash the system  
- **Efficient**: Signals (config) flow cleanly from root to tips

Flakes let us express this in Nix. Each module outputs a `nixosModule` that combines into a whole. The root flake pulls everything together like a trunk connecting branches.

## Quick Start

```bash
# See what the configuration looks like
nix flake show

# Check for errors without applying
nix build .#nixosConfigurations.berzilinux.config.system.build.toplevel --dry-run

# Actually apply (when you're ready)
sudo nixos-rebuild switch --flake .#berzilinux

# Or test in a chroot first
sudo nixos-rebuild test --flake .#berzilinux
```

## For Your Own Machine

### Step 1: Copy the structure

```bash
git clone https://github.com/yourusername/nixos-maxxing.git
cd nixos-maxxing
```

### Step 2: Create your host

Edit `hosts/default.nix`:

```nix
{
  your-hostname = pkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.boot
      self.nixosModules.hardware
      self.nixosModules.networking
      self.nixosModules.desktop
      self.nixosModules.packages
      self.nixosModules.users

      # Your custom settings go here
      ({ pkgs, ... }: {
        nix.settings.experimental-features = [ "nix-command" "flakes" ];
        nixpkgs.config.allowUnfree = true;
        system.stateVersion = "23.11";
      })
    ];
  };
}
```

### Step 3: Customize modules

Each module in `nixos/` is just a NixOS module. Edit them like you would any `configuration.nix`:

- `nixos/hardware/` → Your GPU drivers
- `nixos/packages/` → Your software list  
- `nixos/networking/` → Your WiFi, timezone, hostname

### Step 4: Build

```bash
sudo nixos-rebuild switch --flake .#your-hostname
```

## The Modules Explained

| Module | What It Does |
|--------|--------------|
| `boot/` | Bootloader, kernel hardening, disabled risky kernel modules |
| `hardware/` | NVIDIA + AMD GPU drivers, Bluetooth |
| `networking/` | NetworkManager, timezone, locale |
| `desktop/` | GNOME, PipeWire audio, screen locker |
| `packages/` | 40+ programs I use daily |
| `users/` | My user account, Docker access |

## Key Features

- **NVIDIA + AMD PRIME** — Use the powerful GPU when needed, save battery otherwise
- **Security hardening** — Disabled unnecessary kernel features, blocked attack surfaces
- **PipeWire** — Modern audio that actually works
- **Flakes enabled** — Declarative, reproducible builds
- **State version 23.11** — Current stable channel

## Why Not Just Use the Old Way?

You could keep everything in `configuration.nix`. People did that for years. But:

```
Old way:  configuration.nix (1000 lines of nested mess)
New way:  10 files, 50 lines each, organized by topic
```

The flake approach costs maybe 15 minutes to understand. The old way costs hours every time you need to find something or debug an issue.

## Further Reading

- [Nix Flakes](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake.html) — Official docs
- [NixOS Options](https://search.nixos.org/options) — All available options
- [Determinate Systems](https://determinate.systems/posts/getting-started-with-nix-flakes) — Great tutorial

## Credits

Built on [NixOS](https://nixos.org/) — the OS that treats config as code.

---

*"The best code is code you don't have to write. The second best is code that's easy to find."* — Somewhere on the internet, probably
