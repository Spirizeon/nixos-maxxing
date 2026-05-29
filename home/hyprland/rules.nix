{
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # Discord
      "match:class ^(vesktop)$, workspace 3"

      # Music
      "match:title ^(spotify_player)$, workspace 4"
      "match:title ^(Cider)$, workspace 4"

      # MCSR
      "match:class ^(waywall)$, maximize on"

      # Round all tiled windows
      "match:float false, rounding 5"
    ];

    layerrule = [
      "blur on, ignore_alpha 0.5, match:namespace noctalia-background-.*$"
    ];
  };
}
