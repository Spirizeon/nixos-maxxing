{
  ...
}:

{
  programs.niri.settings = {
    layer-rules = [
      {
        # Set the overview wallpaper on the backdrop
        matches = [
          {
            namespace = "^noctalia-wallpaper*";
          }
        ];
        place-within-backdrop = true;
      }
    ];

    window-rules = [
      # Browsers
      # {
      #   matches = [
      #     { app-id = "firefox"; }
      #   ];
      #   open-on-workspace = "browser";
      # }
      # {
      #   matches = [
      #     { app-id = "zen"; }
      #   ];
      #   open-on-workspace = "browser";
      # }

      # Discord
      {
        matches = [
          { app-id = "vesktop"; }
        ];
        open-on-workspace = "discord";
      }

      # Music
      {
        matches = [
          { title = "spotify_player"; }
        ];
        open-on-workspace = "music";
      }
      {
        matches = [
          { title = "Cider"; }
        ];
        open-on-workspace = "music";
      }

      # MCSR
      {
        matches = [
          { app-id = "waywall"; }
        ];
        open-maximized = true;
      }

      {
        matches = [ { } ];
        background-effect = {
          xray = true;
        };
        geometry-corner-radius = {
          top-left = 20.0;
          top-right = 20.0;
          bottom-left = 20.0;
          bottom-right = 20.0;
        };
        clip-to-geometry = true;
        draw-border-with-background = false;
      }
    ];
  };
}
