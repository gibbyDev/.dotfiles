{ config, pkgs, ... }:

let
  customStyle = builtins.toFile "wlogout.css" ''
    
    @import url("colors-waybar.css");

    * {
        font-family: "JetBrainsMono Nerd Font", sans-serif;
    }
    
    window {
        background-color: rgba(0, 0, 0, 0.8);
    }
    
    button {
        background-color: @color0;
        color: @color4;
        border-radius: 10px;
        border: 2px solid @color4;
        padding: 5px;
        margin: 5px;
        transition: all 0.3s ease;
    }
    
    button:focus, button:hover {
        background-color: @color0;
        color: @color4;
        transform: scale(1.2);
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

