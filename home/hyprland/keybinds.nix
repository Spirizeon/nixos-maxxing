{
  config,
  pkgs,
  ...
}:

let
  apps = import ./applications.nix { inherit pkgs; };

  noctalia =
    cmd:
    "noctalia-shell ipc call ${cmd}";
in
{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";

    bind = [
      # Volume
      ", XF86AudioRaiseVolume, exec, ${noctalia "volume increase"}"
      ", XF86AudioLowerVolume, exec, ${noctalia "volume decrease"}"
      ", XF86AudioMute, exec, ${noctalia "volume muteOutput"}"
      "shift, XF86AudioRaiseVolume, exec, ${noctalia "volume increaseInput"}"
      "shift, XF86AudioLowerVolume, exec, ${noctalia "volume decreaseInput"}"
      "shift, XF86AudioMute, exec, ${noctalia "volume muteInput"}"
      "ctrl, XF86AudioMute, exec, ${noctalia "volume togglePanel"}"

      # Media
      ", XF86AudioPlay, exec, ${noctalia "media playPause"}"
      ", XF86AudioNext, exec, ${noctalia "media next"}"
      ", XF86AudioPrev, exec, ${noctalia "media previous"}"

      # Applications
      "$mainMod, Space, exec, ${noctalia "launcher toggle"}"
      "$mainMod, q, killactive,"
      "$mainMod, b, exec, ${apps.browser}"
      "$mainMod, Return, exec, ${apps.terminal}"
      "$mainMod, E, exec, ${apps.fileManager}"
      "$mainMod, L, exec, ${noctalia "lockScreen lock"}"

      # Window management
      "$mainMod, f, fullscreen,"
      "$mainMod, t, togglefloating,"

      # Screenshots
      "ctrl shift, 1, exec, ${apps.screenshotArea}"
      "ctrl shift, 2, exec, ${apps.screenshotWindow}"

      # Focus
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, down, movefocus, d"
      "$mainMod, up, movefocus, u"

      # Move windows
      "$mainMod shift, left, movewindow, l"
      "$mainMod shift, right, movewindow, r"
      "$mainMod shift, down, movewindow, d"
      "$mainMod shift, up, movewindow, u"

      # Workspaces
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"

      # Move active window to workspace
      "$mainMod shift, 1, movetoworkspace, 1"
      "$mainMod shift, 2, movetoworkspace, 2"
      "$mainMod shift, 3, movetoworkspace, 3"
      "$mainMod shift, 4, movetoworkspace, 4"
    ];

    workspace = [
      "1, name:main, monitor:DP-2"
      "2, name:browser, monitor:HDMI-A-1"
      "3, name:discord, monitor:HDMI-A-1"
      "4, name:music, monitor:HDMI-A-1"
    ];
  };
}
