{ self }:

{
  description = "Packages configuration";

  nixosModule = { config, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      oh-my-posh
      kitty
      vim
      nitch
      gh
      ani-cli
      vlc
      mpv
      ffmpeg
      fzf
      curl
      wget
      gnused
      opencode
      python3
      gawk

      git
      gcc
      gnumake
      autoconf
      automake
      go
      cargo
      rustc
      helix

      zoxide
      htop
      eza
      zip
      unzip
      stow

      flameshot
      discord
      spotify
      lshw
    ];
  };
}