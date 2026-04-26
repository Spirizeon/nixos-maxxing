{ self }:

{
  description = "Hardware configuration";

  nixosModule = { config, pkgs, ... }: {
    imports = [ ./hardware.nix ];

    hardware.graphics = {
      enable = true;
    };

    services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];

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

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
  };
}