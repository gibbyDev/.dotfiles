{ config, pkgs, ... }:

{
  programs.swaync.enable = true;

  xdg.configFile."swaync/style.css".text = ''
    @import url("file://${config.home.homeDirectory}/.cache/wal/colors.css");

    .notification {
      background: @background;
      color: @foreground;
      border-radius: 14px;
      border: 2px solid @color4;
    }

    .control-center {
      background: alpha(@background, 0.95);
      border: 2px solid @color5;
      border-radius: 20px;
    }
  '';

  xdg.configFile."wal/hooks/swaync".text = ''
    #!/usr/bin/env sh
    pkill -USR1 swaync
  '';

  xdg.configFile."wal/hooks/swaync".executable = true;
}
