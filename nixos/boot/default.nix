{ self }:

{
  description = "Boot configuration";

  nixosModule = { config, pkgs, ... }: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.editor = false;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelParams = [ "nvidia-drm.modeset=1" ];

    boot.kernel.sysctl = {
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

    boot.blacklistedKernelModules = [
      "ax25"
      "netrom"
      "rose"
      "adfs"
      "affs"
      "befs"
      "cramfs"
      "efs"
      "freevxfs"
      "hfs"
      "hfsplus"
      "hpfs"
      "jfs"
      "minix"
      "nilfs2"
      "omfs"
      "qnx4"
      "qnx6"
      "sysv"
      "vivid"
    ];
  };
}