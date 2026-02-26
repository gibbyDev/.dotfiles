{ config, pkgs, lib, ... }:

{
  config = lib.mkIf config.programs.pywal.enable {
    home.sessionVariables = {
      PYWAL_CACHE_DIR = "${config.xdg.cacheHome}/wal";
    };

    home.file.".config/waybar/colors.css".source =
      "${config.xdg.cacheHome}/wal/colors-waybar.css";

    home.file.".config/rofi/colors.rasi".text = ''
      * {
          background:     #''${palette.background};
          foreground:     #''${palette.foreground};
          normal-background: #''${palette.background};
          normal-foreground: #''${palette.foreground};
          alternate-normal-background: #''${palette.background};
          alternate-normal-foreground: #''${palette.foreground};
          selected-normal-background: #''${palette.color7};
          selected-normal-foreground: #''${palette.background};
          active-background: #''${palette.background};
          active-foreground: #''${palette.color2};
          alternate-active-background: #''${palette.background};
          alternate-active-foreground: #''${palette.color2};
          selected-active-background: #''${palette.color2};
          selected-active-foreground: #''${palette.background};
          urgent-background: #''${palette.color1};
          urgent-foreground: #''${palette.background};
          alternate-urgent-background: #''${palette.background};
          alternate-urgent-foreground: #''${palette.color1};
          selected-urgent-background: #''${palette.color1};
          selected-urgent-foreground: #''${palette.background};
      }
    '';
  };
}

