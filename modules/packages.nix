{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Shell / UI
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

    # Dev tools
    git
    gcc
    gnumake
    autoconf
    automake
    go
    cargo
    rustc
    helix

    # CLI tools
    zoxide
    htop
    eza
    zip
    unzip
    stow

    # Extras
    flameshot
    discord
    spotify
    lshw
  ];
}
