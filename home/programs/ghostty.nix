{
  ...
}:

{

  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 11;
      font-family = "JetBrainsMono Nerd Font";
      background-opacity = 0.7;
      window-decoration = false;
      font-feature = [
        "-liga"
        "-dlig"
        "-calt"
      ];
    };
  };
}
