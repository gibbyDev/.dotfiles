{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    dunst
    jq
  ];

  home.file.".config/dunst/dunstrc".text = ''
    #!/usr/bin/env sh
    WAL_COLORS="$HOME/.cache/wal/colors.json"

    if [ -f "$WAL_COLORS" ]; then
        BG=$(jq -r '.special.background' "$WAL_COLORS")
        FG=$(jq -r '.special.foreground' "$WAL_COLORS")
        LOW=$(jq -r '.colors.color2' "$WAL_COLORS")
        NORMAL=$(jq -r '.colors.color1' "$WAL_COLORS")
        CRITICAL=$(jq -r '.colors.color3' "$WAL_COLORS")
    else
        BG="#0f1016"
        FG="#c6c3da"
        LOW="#6F6C91"
        NORMAL="#6B6691"
        CRITICAL="#877AB1"
    fi

    cat <<EOL > "$HOME/.config/dunst/dunstrc"
    [global]
    font = Monospace 10
    geometry = "300x50-10+50"
    timeouts = { low = 1000, normal = 1500, critical = 3000 }
    frame_color = "$NORMAL"
    background = "$BG"
    foreground = "$FG"
    separator_height = 2
    padding = 8
    transparency = 10
    sort = newest
    ignore_new_urgency = false

    [urgency_low]
    background = "$BG"
    foreground = "$FG"
    frame_color = "$LOW"

    [urgency_normal]
    background = "$BG"
    foreground = "$FG"
    frame_color = "$NORMAL"

    [urgency_critical]
    background = "$BG"
    foreground = "$FG"
    frame_color = "$CRITICAL"
    EOL
  '';
}

