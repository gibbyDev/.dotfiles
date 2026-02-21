{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    swaynotificationcenter
    nerd-fonts.jetbrains-mono
  ];

  xdg.configFile."swaync/config".text = '' 
    [general]
    show-music-widget = true
    show-network-widget = true
    show-battery-widget = true
    show-volume-widget = true
    show-brightness-widget = true

    [music]
    player = "playerctl"
    refresh-rate = 2

    [widgets]
    widget-order = music,volume,brightness,network,battery
  '';

  xdg.configFile."swaync/style.css".text = ''
    @import url("file://${config.home.homeDirectory}/.cache/wal/colors.css");

    .control-center {
      background: alpha(@background, 0.95);
      border-radius: 8px;
      padding: 12px;
      border: 2px solid @color4;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.25);
    }

    .notification {
      background: @background;
      color: @foreground;
      border-radius: 6px;
      border: 2px solid @color4;
      padding: 8px;
      font-size: 13px;
    }

    .widget {
      background: alpha(@color0, 0.25);
      border-radius: 6px;
      padding: 6px;
      margin: 4px 0;
    }

    .music-widget {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background: alpha(@color1, 0.25);
      border-radius: 6px;
      padding: 8px;
      font-size: 13px;
      color: @foreground;
    }

    .music-widget .title { font-weight: bold; }
    .music-widget .artist { font-style: italic; }
  '';
}
