{ ... }:
{
  programs.waybar.settings.mainBar = {
    position= "top";
    layer= "top";
    height= 30;
    margin-top= 4;
    margin-bottom= 0;
    margin-left= 4;
    margin-right= 4;

    modules-left= [
        "custom/icon" 
        "custom/separator"
        "custom/separator"
        "custom/separator"
        "custom/separator"
        "clock"
        "custom/separator"
        "custom/cava_mviz"
    ];

    modules-center= [
        "hyprland/workspaces"
    ];

    modules-right= [
        #"hyprland/window"
        "network"
        "pulseaudio#audio"
        "pulseaudio#mic"
        "battery"
        "custom/power"
        "custom/swaync"
        "custom/separator"
    ];

    "hyprland/window" = {
        format = "<b>{}</b>";
        exec = "hyprctl activewindow | grep class | awk '{print $2}'";
        separate-outputs = true;
        max-length = 35;
    };

    # clock= {
    #     calendar = {
    #       format = { today = "<span color='#b4befe'><b>{}</b></span>"; };
    #     };
    #     # format = " {:%H:%M}";
    #     format = "{:%H:%M}";
    #     tooltip= "true";
    #     tooltip-format= "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    #     format-alt= " {:%d/%m}";
    # };
    #
    clock = {
      format = "{:%H:%M}";
      tooltip = true;
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      on-click = "xdg-open https://calendar.google.com";  # opens Google Calendar on click
    };

    "hyprland/workspaces" = {
  format = "{icon}";

  format-icons = {
    active = "";   # filled circle
    default = "";  # empty circle
  };

  persistent-workspaces = {
    "*" = 2;        # always show exactly 3 workspaces
  };

  sort-by-number = true;

  on-scroll-up = "hyprctl dispatch workspace e-1";
  on-scroll-down = "hyprctl dispatch workspace e+1";
  on-click = "activate";
};

    memory= {
        format= " {}%";
        interval= 2;
    };

    cpu= {
        format= "  {usage}%";
        format-alt= "  {avg_frequency} GHz";
        interval= 2;
    };


    network = {
      format-wifi = " ";
      format-ethernet = "";
      tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = " ";
      on-click = "nm-applet &";  # launches nmapplet
    };

    # network = {
    #     format-wifi = " ";
    #     format-ethernet = "";
    #     tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
    #     format-linked = "{ifname} (No IP)";
    #     format-disconnected = " ";
    # };
    #
    backlight = {
        format = "{icon} {percent}%";
        format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
        ];
        interval = 2;
    };

    "custom/right-arr" = {
        format = "  ";
    };

    battery = {
      format = "{icon} {capacity}% ";
      format-alt = "{icon} {time}";
      format-charging = " {capacity}% ";
      format-icons = [" " " " " " " "];

    };

    tray= {
        icon-size= 20;
        spacing= 8;
    };

"pulseaudio#audio" = {
    format = "{format_source}";
    format-source = "  {volume} ";
    format-source-muted = " 󰸈 {volume} ";
    on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
    on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ -1%";
    on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ +1%";
    scroll-step = 5;
    tooltip = false;
  };

  "pulseaudio#mic" = {
    format = "{format_source}";
    format-source = "  {volume} ";
    format-source-muted = "   {volume} ";
    on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
    on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ -1%";
    on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ +1%";
    scroll-step = 5;
    tooltip = true;
  };

  "pulseaudio/slider" = {
    min = 0;
    max = 100;
    orientation = "horizontal";
  };

# pulseaudio= {
    #     format= "{icon} <b>{volume}</b> {format_source}";
    #     format-source = "  <b>{volume}</b> ";
    #     format-source-muted = "  ";
    #     format-bluetooth = " ᛒ <b>{volume}</b> ";
    #     format-bluetooth-muted = " ";
    #     format-muted= " {format_source}";
    #     format-icons= {
    #         default= ["" "" ""];
    #     };
    #     scroll-step= 5;
    #
    # };
    #

        "custom/cava_mviz" = {
          exec = "~/.local/share/bin/waybar-cava.sh";
          format = "<span color='#a6e3a1'>[</span> {} <span color='#a6e3a1'>]</span>";
        };

        "custom/swaync" = {
          tooltip = true;
          "tooltip-format" = "Left Click: Launch Notification Center\nRight Click: Do not Disturb";
          format = "{} {icon} ";
          "format-icons" = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            "dnd-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-none" = "";
            "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-inhibited-none" = "";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          exec = "swaync-client -swb";
          "on-click" = "systemctl --user start swaync.service; swaync-client -t";
          "on-click-right" = "systemctl --user start swaync.service; swaync-client -d";
          escape = true;
        };


    "custom/icon"= {
        format= "";
        on-click= "sh -c 'rofi -show drun &'";
        tooltip= "App Launcher";
    };

    "custom/separtor" = {
      format = " ";
    };

    "custom/browser" = {
        format = " ";
    };

    "custom/window-icon" = {
      # to be added
    };

    "custom/power" = {
        format = "  ";
        tooltip = "Power menu";
        on-click = "sh -c 'wlogout &'";
    };

  };
}


