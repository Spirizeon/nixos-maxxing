{
  pkgs,
  ...
}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;

    settings = {
      monitor = [
        "DP-2,3840x1600@143.998,0x0,1,vrr,1"
        "HDMI-A-1,1920x1080@60,3840x0,1"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
        };
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 5;
        rounding_power = 2;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = "easeOutQuint, 0.23, 1, 0.32, 1";
        animation = [
          "windows, 1, 7, easeOutQuint"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      cursor = {
        no_hardware_cursors = true;
      };

      env = [
        "CLUTTER_BACKEND,wayland"
        "GDK_BACKEND,wayland,x11"
        "MOZ_ENABLE_WAYLAND,1"
        "NIXOS_OZONE_WL,1"
        "QT_QPA_PLATFORM,wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "XDG_SESSION_TYPE,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "DISPLAY,:0"
      ];

      layerrule = [
        "blur on, ignore_alpha 0.5, match:namespace noctalia-background-.*$"
      ];

      windowrule = [
        "match:class ^(zed)$, opacity 0.90 0.85"
      ];
    };
  };
}
