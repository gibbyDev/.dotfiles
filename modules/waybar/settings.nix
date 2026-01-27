{ ... }:
{
  programs.waybar.settings.mainBar = {
    position= "top";
    layer= "top";
    height= 30;
    margin-top= 6;
    margin-bottom= 0;
    margin-left= 6;
    margin-right= 6;

    modules-left= [
        "custom/icon" 
        #"custom/separator"
        #"custom/browser"
        #"cpu"
        #"memory"
        #"temperature"
        #"custom/separator"
        #"custom/window-icon"
    ];

    modules-center= [
        "hyprland/workspaces"
    ];

    modules-right= [
        #"hyprland/window"
        "network"
        "backlight"
        "pulseaudio"
        "custom/right-arr" 
        "battery"
        "clock"
    ];

    "hyprland/window" = {
        format = "<b>{}</b>";
        exec = "hyprctl activewindow | grep class | awk '{print $2}'";
        separate-outputs = true;
        max-length = 35;
    };

    clock= {
        calendar = {
          format = { today = "<span color='#b4befe'><b>{}</b></span>"; };
        };
        format = " {:%H:%M}";
        tooltip= "true";
        tooltip-format= "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt= " {:%d/%m}";
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

    #
    # "hyprland/workspaces"= {
    #     format = "{icon}";
    #     format-icons= {
    #         # "1"= " ";
    #         # "2"= " ";
    #         # "3"= " ";
    #         # "4"= " ";
    #         # "5"= " ";
    #         # "6"= " ";
    #         active= "";
    #         default = "";
    #         sort-by-number= true;
    #     };
    #     on-scroll-up = "hyprctl dispatch workspace e-1";
    #     on-scroll-down = "hyprctl dispatch workspace e+1";
    #     on-click = "activate";
    # };

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
    };

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
      format = "{icon} {capacity}%";
      format-alt = "{icon} {time}";
      format-charging = " {capacity}%";
      format-icons = [" " " " " " " "];
      
    };

    tray= {
        icon-size= 20;
        spacing= 8;
    };

    pulseaudio= {
        format= "{icon} <b>{volume}</b> {format_source}";
        format-source = "{volume}%  ";
        format-source-muted = "  ";
        format-bluetooth = " ᛒ <b>{volume}</b> ";
        format-bluetooth-muted = " ";
        format-muted= " {format_source}";
        format-icons= {
            default= ["" "" ""];
        };
        scroll-step= 5;
        
    };
    
    temperature = {
        critical-threshold = 40;
        format = "{icon} {temperatureC}°C";
        format-critical = "{icon} {temperatureC}°C";
        format-icons = [
            ""
            ""
            ""
        ];
        interval = 2;
    };

    "custom/icon"= {
        format= "";   
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

  };
}
