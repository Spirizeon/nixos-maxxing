{
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "systemctl --user start hyprpolkitagent"
      "arrpc"
      "xwayland-satellite"
      "noctalia-shell"
    ];
  };
}
