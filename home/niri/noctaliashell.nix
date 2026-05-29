{
  inputs,
  config,
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
        density = "spacious";
        position = "top";
        barType = "floating";
        showCapsule = true;
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
	      id = "AudioVisualizer";
	    }
            {
              id = "Workspace";
              hideUnoccupied = false;
              labelMode = "index";
            }
	    {
	      id = "MediaMini";
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
              icon = "noctalia"; # used when distro logo is set to false
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
