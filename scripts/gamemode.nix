{ pkgs }:

pkgs.writeShellScriptBin "gamemode" ''
  # Toggle animations on/off for gaming mode
  status=$(${pkgs.hyprland}/bin/hyprctl getoption animations:enabled | grep -oP 'int: \K[0-9]+')
  
  if [ "$status" = "1" ]; then
    # Disable animations
    ${pkgs.hyprland}/bin/hyprctl keyword animations:enabled 0
    ${pkgs.libnotify}/bin/notify-send "Gamemode: ON" "Animations disabled"
  else
    # Enable animations
    ${pkgs.hyprland}/bin/hyprctl keyword animations:enabled 1
    ${pkgs.libnotify}/bin/notify-send "Gamemode: OFF" "Animations enabled"
  fi
''
