{
  config,
  pkgs,
  inputs,
  lib,
  self,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    "${self}/system/greeter/greetd.nix"
    "${self}/system/programs/nix-ld.nix"
    "${self}/system/programs/stylix.nix"
    "${self}/system/services/flatpak.nix"
    "${self}/system/services/keyring.nix"
    "${self}/system/services/ssh.nix"
    "${self}/system/services/disable-usb-wakeup.nix"
    "${self}/system/xdg.nix"
    "${self}/system/environment.nix"
  ];

  nixpkgs.overlays = [
    (final: prev: {
      nur = import inputs.nur {
        nurpkgs = prev;
        pkgs = prev;
      };
    })
  ];

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Dummy system user required by shared modules (greetd, ssh)
  users.users.chris = {
    isSystemUser = true;
    group = "chris";
  };
  users.groups.chris = {};

  users.users.berzi = {
    isNormalUser = true;
    description = "ayush";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
      "plugdev"
      "bluetooth"
      "podman"
    ];
  };

  # Override shared module references from chris to berzi
  services.greetd.settings.default_session.user = lib.mkForce "berzi";
  services.openssh.settings.AllowUsers = lib.mkForce [ "berzi" ];

  fonts.packages = with pkgs; [
    fira-sans
    roboto
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    material-symbols
    material-icons
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ext4" "vfat" ];

    kernel.sysctl = {
      "kernel.kptr_restrict" = 2;
      "net.ipv4.tcp_syncookies" = 1;
      "net.ipv4.tcp_rfc1337" = 1;
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.conf.default.rp_filter" = 1;
      "net.ipv4.conf.all.log_martians" = true;
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.send_redirects" = 0;
      "kernel.yama.ptrace_scope" = 2;
      "net.core.bpf_jit_enable" = 0;
      "kernel.ftrace_enabled" = 0;
    };

    blacklistedKernelModules = [
      "ax25" "netrom" "rose"
      "adfs" "affs" "befs" "cramfs" "efs"
      "freevxfs" "hfs" "hfsplus" "hpfs" "jfs"
      "minix" "nilfs2" "omfs" "qnx4" "qnx6" "sysv"
      "vivid"
    ];

    kernelParams = [
      "nvidia-drm.modeset=1"
    ];

    consoleLogLevel = 3;
    initrd.verbose = false;
    loader.timeout = 0;
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };

  networking = {
    hostName = "berzilinux";
    networkmanager.enable = true;
    networkmanager = {
      wifi.backend = "wpa_supplicant";
      wifi.powersave = false;
    };
  };

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" "amdgpu" ];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:5:0:0";
    };
  };

  services = {
    dbus.enable = true;

    power-profiles-daemon.enable = true;
    printing.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    input.General.ClassicBondedOnly = false;
  };

  environment.systemPackages = with pkgs; [
    bluez
    wget
    git
    ffmpeg
  ];

  nixpkgs.config.allowUnfree = true;

  # home-manager is standalone (not a NixOS module).
  # Run: home-manager switch --flake /home/berzi/nixos#berzi

  programs.zsh.enable = true;

  system.stateVersion = "25.05";
}
