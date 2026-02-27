{ pkgs }:

pkgs.writeShellScriptBin "togglepowermode" ''
  # Toggle between performance and power saving mode
  config_dir="$HOME/.config/hypr"
  power_mode_file="$config_dir/power_mode"
  
  mkdir -p "$config_dir"
  
  # Read current mode or default to balanced
  current_mode=$(cat "$power_mode_file" 2>/dev/null || echo "balanced")
  
  if [ "$current_mode" = "powersave" ]; then
    # Switch to performance mode
    echo "performance" > "$power_mode_file"
    echo "Performance Mode"
  else
    # Switch to powersave mode
    echo "powersave" > "$power_mode_file"
    echo "Power Saving Mode"
  fi
''
