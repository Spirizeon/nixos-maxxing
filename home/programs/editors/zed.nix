{
  lib,
  pkgs,
  ...
}:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "gleam"
      "gdscript"
      "catppuccin"
      "catppuccin-icons"
      "vhs"
      "discord-presence"
    ];
    extraPackages = with pkgs; [
      nil
      nixd
      nixfmt
    ];
    userSettings = {
      features = {
        copilot = false;
      };
      telemetry = {
        metrics = false;
      };
      vim_mode = false;
      #      ui_font_size = 16;
      #      buffer_font_size = 14;

      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        dock = "bottom";
        env = {
          TERM = "ghostty";
        };
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        shell = "system";
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };

      hour_format = "hour24";
      auto_update = false;
      base_keymap = "VSCode";
      theme = lib.mkForce {
        mode = "dark";
        light = "Catppuccin Latte";
        dark = "Catppuccin Mocha";
      };

      background.appearance = "blurred";
      show_whitespaces = "all";

      theme_overrides = {
        "background" = "#1e1e2ecc";
        "elevated_surface.background" = "#313244cc";
        "surface.background" = "#313244cc";
        "title_bar.background" = "#181825cc";
        "tab_bar.background" = "#181825cc";
        "tab.inactive_background" = "#181825cc";
        "tab.active_background" = "#1e1e2ecc";
        "status_bar.background" = "#181825cc";
        "toolbar.background" = "#181825cc";
        "panel.background" = "#181825cc";
        "editor.background" = "#1e1e2eaa";
        "editor.gutter.background" = "#181825cc";
        "editor.active_line.background" = "#1e1e2ecc";
        "terminal.background" = "#1e1e2eaa";
      };

      lsp = {
        nil = {
          binary.path = "/run/current-system/sw/bin/nil";
          autoArchive = true;
        };
        discord_presence = {
          initialization_options = {
            application_id = "1263505205522337886";
            state = "Working on {filename}";
            details = "In {workspace}";
            large_image = "{base_icons_url}/{language:lo}.png";
            large_text = "{language:u}";
            small_image = "{base_icons_url}/zed.png";
            small_text = "Zed";
            base_icons_url = "https://raw.githubusercontent.com/xhyrom/zed-discord-presence/main/assets/icons/";
          };
        };
      };

      agent_servers = {
        OpenCode = {
          command = "opencode";
          args = [ "acp" ];
        };
      };

      languages = {
        Nix = {
          language_servers = [
            "nil"
            "!nixd"
          ];
          formatter.external = {
            command = "nixfmt";
            arguments = [
              "--quiet"
              "--"
            ];
          };
        };
      };
    };
  };
}
