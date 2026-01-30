{ config, pkgs, lib, ... }:

let
  # Path to pywal colors
  walColorsFile = "${config.home.homeDirectory}/.cache/wal/colors.json";

  # Function to parse JSON and pick colors
  # Returns a record with background, foreground, frame, and accent
  pywalColors = lib.optionalString (builtins.pathExists walColorsFile) ''
    #!/usr/bin/env bash
    wal=$(cat ${walColorsFile})
    BG=$(echo $wal | jq -r '.special.background')
    FG=$(echo $wal | jq -r '.special.foreground')
    ACCENT=$(echo $wal | jq -r '.colors.color2')  # Use red or blue as accent
    FRAME=$ACCENT
    echo "BG=$BG"
    echo "FG=$FG"
    echo "ACCENT=$ACCENT"
    echo "FRAME=$FRAME"
  '';
in

{
  programs.dunst = {
    enable = true;

    # Use extraConfig to dynamically generate the dunstrc
    extraConfig = lib.mkForce (let
      colors = builtins.readFile walColorsFile;
      bg = builtins.fromJSON colors.special.background;
      fg = builtins.fromJSON colors.special.foreground;
      accent = builtins.fromJSON colors.colors.color2;
    in ''
      # Dunst config generated from Pywal
      font = Monospace 10
      geometry = "300x50-10+50"
      timeouts = {
          low = 3000
          normal = 5000
          critical = 0
      }
      frame_color = "${accent}"
      background = "${bg}"
      foreground = "${fg}"
    '');
  };
}

