{ config, pkgs, ... }:

{
  # Display server & GNOME desktop
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Screen locker
  services.physlock.enable = true;

  # Keyboard layout
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Printing
  services.printing.enable = true;

  # Security
  security = {
    rtkit.enable = true;
    protectKernelImage = true;
    forcePageTableIsolation = true;
  };

  # Audio (PipeWire)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
