{
  pkgs,
  inputs,
  self,
  ...
}:

let
  ani-cli = pkgs.ani-cli.overrideAttrs (oldAttrs: rec {
    version = "4.14";
    src = pkgs.fetchFromGitHub {
      owner = "pystardust";
      repo = "ani-cli";
      rev = "v${version}";
      sha256 = "0jm26w53nd70dfmkdaia8gqsmly80g1rvjgdyzwirc1xvw68l81v";
    };
  });
in
with pkgs; [
  oh-my-posh
  vim
  nitch
  gh
  vlc
  gnused
  opencode
  python3
  gawk
  cloudflare-warp
  zoom-us
  gcc
  gnumake
  autoconf
  automake
  go
  cargo
  rustc
  ollama
  obsidian
  htop
  eza
  zip
  unzip
  stow
  spotify
  lshw

  # Custom ani-cli deps
  fzf
  mpv
  curl
  aria2
  ani-skip
  openssl
  ani-cli
]
