{
  ...
}:

{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "bira";
      plugins = [
        "git"
        "sudo"
      ];
    };

    initContent = ''
      if [[ $- == *i* ]] && [[ -z $IN_NIX_SHELL ]]; then
        nitch
      fi

      setopt NO_SHARE
      setopt NO_BANG_HIST
    '';
  };
}
