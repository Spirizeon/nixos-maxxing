{ self }:

{
  description = "Desktop configuration";

  nixosModule = { config, pkgs, ... }: {
    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    services.physlock.enable = true;

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    services.printing.enable = true;

    security.rtkit.enable = true;
    security.protectKernelImage = true;
    security.forcePageTableIsolation = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}