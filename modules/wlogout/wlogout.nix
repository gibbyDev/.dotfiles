{ config, pkgs, ... }:

let
  # Catppuccin Mocha colors (hard-coded)
  color_bg       = "#1E1E2E";
  color_fg       = "#D9E0EE";
  color_button   = "#313244";
  color_button_hover = "#F5C2E7";
  color_border   = "#585B70";
in
{
  programs.wlogout = {
    enable = true;

    layout = [
      { label = "shutdown"; action = "sleep 1; systemctl poweroff"; text = "Shutdown"; keybind = "s"; }
      { label = "reboot"; action = "sleep 1; systemctl reboot"; text = "Reboot"; keybind = "r"; }
      { label = "logout"; action = "sleep 1; hyprctl dispatch exit"; text = "Exit"; keybind = "e"; }
      { label = "suspend"; action = "sleep 1; systemctl suspend"; text = "Suspend"; keybind = "u"; }
      { label = "lock"; action = "sleep 1; hyprlock"; text = "Lock"; keybind = "l"; }
      { label = "hibernate"; action = "sleep 1; systemctl hibernate"; text = "Hibernate"; keybind = "h"; }
    ];

    style = ''
      * {
        font-family: "JetBrainsMono NF", FontAwesome, sans-serif;
        transition: 0.2s;
      }

      window {
        background-color: ${color_bg}CC; /* semi-transparent */
      }

      button {
        background-color: ${color_button};
        color: ${color_fg};
        font-size: 20px;
        border-radius: 15px;
        border: 3px solid ${color_border};
        padding: 10px;
        margin: 10px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.3);
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:hover,
      button:focus,
      button:active {
        color: ${color_button_hover};
        background-color: ${color_button_hover}33; /* light hover */
        border: 3px solid ${color_button_hover};
        transform: scale(1.1);
      }

      #shutdown { background-image: url("icons/shutdown.png"); }
      #reboot { background-image: url("icons/reboot.png"); }
      #logout { background-image: url("icons/logout.png"); }
      #suspend { background-image: url("icons/suspend.png"); }
      #lock { background-image: url("icons/lock.png"); }
      #hibernate { background-image: url("icons/hibernate.png"); }
    '';
  };

  home.file.".config/wlogout/icons" = {
    source = ./icons;
    recursive = true;
  };
}

