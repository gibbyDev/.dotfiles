{ config, pkgs, ... }:

let
  customStyle = builtins.toFile "wlogout.css" ''
    * {
        font-family: "JetBrainsMono Nerd Font", sans-serif;
    }
    
    window {
        background-color: rgba(0, 0, 0, 0.8);
    }
    
    button {
        background-color: transparent;
        color: #cdd6f4;
        border-radius: 10px;
        border: 2px solid #89b4fa;
        padding: 10px;
        margin: 10px;
    }
    
    button:focus, button:hover {
        background-color: #89b4fa;
        color: #1e1e2e;
    }
  '';

  layoutJson = builtins.toFile "wlogout.json" (builtins.toJSON [
    { label = "Lock"; icon = "/usr/share/icons/Papirus-Dark/24x24/actions/lock.svg"; command = "hyprlock"; }
    { label = "Logout"; icon = "/usr/share/icons/Papirus-Dark/24x24/actions/logout.svg"; command = "hyprctl dispatch exit"; }
    { label = "Suspend"; icon = "/usr/share/icons/Papirus-Dark/24x24/actions/suspend.svg"; command = "systemctl suspend"; }
    { label = "Shutdown"; icon = "/usr/share/icons/Papirus-Dark/24x24/actions/shutdown.svg"; command = "systemctl poweroff"; }
    { label = "Reboot"; icon = "/usr/share/icons/Papirus-Dark/24x24/actions/reboot.svg"; command = "systemctl reboot"; }
  ]);
  
in {
  home.packages = with pkgs; [ wlogout ];

  home.file.".config/wlogout/style.css".source = customStyle;
  home.file.".config/wlogout/layout.json".source = layoutJson;
}

