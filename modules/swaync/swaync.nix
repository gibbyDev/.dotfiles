{config, pkgs, ...}:
{
  home.packages = with pkgs; [
    swaynotificationcenter
  ];

  xdg.configFile."swaync/style.css".text = ''
    @import url("file://${config.home.homeDirectory}/.cache/wal/colors.css");

    .notification {
      background: @background;
      color: @foreground;
      border-radius: 12px;
      border: 2px solid @color4;
    }

    .control-center {
      background: alpha(@background, 0.95);
      border-radius: 16px;
    }
  '';
}
