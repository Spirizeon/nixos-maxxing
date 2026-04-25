{ config, pkgs, ... }:

{
  # Graphics
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures.
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu, accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      # Use "offload.enable" for better battery or "sync.enable" for maximum performance
      sync.enable = true;
      # offload.enable = true;
      # offload.enableOffloadCmd = true;

      # Bus IDs calculated from your lshw output
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:5:0:0";
    };
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
