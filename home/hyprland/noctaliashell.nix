{
  inputs,
  config,
  lib,
  ...
}:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;

    settings = {
      bar = {
        density = lib.mkForce "spacious";
        position = lib.mkForce "top";
        barType = lib.mkForce "floating";
        showCapsule = lib.mkForce true;
        backgroundOpacity = lib.mkForce 0.85;
        frameRadius = lib.mkForce 5;
        widgets = {
          left = [
            {
              id = "Launcher";
            }
            {
              id = "Clock";
              formatHorizontal = "HH:mm ddd, MMM dd";
              formatVertical = "HH mm";
              useMonospacedFont = true;
              usePrimaryColor = false;
            }
            {
              id = "SystemMonitor";
            }
            {
              id = "VPN";
              displayMode = "alwaysShow";
            }
            {
              id = "ActiveWindow";
            }
          ];
          center = [
            {
              id = "Workspace";
              hideUnoccupied = false;
              labelMode = "index";
            }
            {
              id = "MediaMini";
            }
            {
              id = "AudioVisualizer";
            }
          ];
          right = [
            {
              id = "Tray";
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "Volume";
            }
            {
              id = "ControlCenter";
              useDistroLogo = true;
              icon = "noctalia";
              enableColorization = true;
            }
          ];
        };
      };

      general = {
        avatarImage = "/home/${config.home.username}/.face";
      };

      colorSchemes.predefinedScheme = "Ayu";

      location = {
        analogClockInCalendar = "true";
        name = "Indianapolis, US";
        useFahrenheit = true;
      };

      network = {

      };
    };
    # this may also be a string or a path to a JSON file.
  };
}
