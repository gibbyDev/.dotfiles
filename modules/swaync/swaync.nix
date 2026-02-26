{ config, pkgs, lib, ... }:

let
  walColors = "${config.xdg.cacheHome}/wal/colors.css";
  isValidUser = config.home.username != "REPLACE_USER";
in
{
  home.packages = with pkgs; [
    swaynotificationcenter
    nerd-fonts.jetbrains-mono
    playerctl   # Required for music control
    networkmanager
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

    [network]
    interface = "*"  # detect all interfaces
    refresh-rate = 5

    [widgets]
    widget-order = music,volume,brightness,network,battery
  '';

  xdg.configFile."swaync/style.css".text = lib.mkIf isValidUser ''
    @import url("file://${walColors}");

    .control-center {
      background: @background;
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

    /* Music widget with buttons */
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

    .music-widget button {
      background: alpha(@color2, 0.5);
      border: none;
      border-radius: 4px;
      padding: 4px 6px;
      cursor: pointer;
      margin-left: 4px;
      font-size: 12px;
      color: @foreground;
    }

    .network-widget {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background: alpha(@color3, 0.25);
      border-radius: 6px;
      padding: 8px;
      font-size: 13px;
      color: @foreground;
    }
  '';
}
