{
  config,
  lib,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 10;
        hide_cursor = true;
        no_fade_in = false;
      };
      background = [
        {
          # Wallpaper path will be managed by set-wallpaper.sh script
          # which symlinks the current wallpaper to this location
          path = "$HOME/.cache/hyprlock_wallpaper";
          blur_passes = 3;
          blur_size = 3;
        }
      ];
      image = [
        {
          path = "$HOME/.dotfiles/modules/fastfetch/me.png";
          size = 150;
          border_size = 4;
          # Border color will use color4 from pywal
          border_color = "rgb(142, 115, 113)";
          rounding = -1; # Negative means circle
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
       ];
       label = [
         {
           # Media player information
           monitor = "";
           text = "cmd[update:1000] $HOME/.local/share/bin/media-player-info.sh";
           text_align = "center";
           font_size = 12;
           font_family = "Monospace";
           position = "0, 100";
           halign = "center";
           valign = "center";
           color = "rgb(205, 188, 187)";
         }
       ];
       input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          # Foreground color from pywal
          font_color = "rgb(205, 188, 187)";
          # Color2 from pywal for inner color
          inner_color = "rgb(118, 96, 95)";
          # Background from pywal for outer color
          outer_color = "rgb(10, 10, 10)";
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }
      ];
    };
  };
}
