{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = "user"; # default theme
  };

  xdg.configFile."rofi/user.rasi".text = ''
        // Config //
    configuration {
        modi:         "drun,run,window";
        show-icons:   true;
        font:         "JetBrainsMono Nerd Font 12"; // slightly bigger
        icon-theme:   "Tela-circle-dracula";
    }

    @theme "~/.config/rofi/colors.rasi"

    // Main window //
    window {
        width:        25em;
        height:       14em;
        transparency: "real";
        fullscreen:   false;
        cursor:       "default";
        border-color: @foreground;
        border-width: 2px;
        background-color: @foreground;
        padding: 0.15em;
    }

    // Mainbox (vertical stack: input on top, list below)
    mainbox {
        orientation: vertical;
        spacing:     0.5em;
        padding:     0.25em;
        background-color: @background;
    }

    // Input bar at top with border
    inputbar {
        enabled: true;
        children: [ "entry" ];
        background-color: @background;
        border-color: @foreground;
        border-width: 2px;
        padding: 0.4em 0.5em;
    }

    entry {
        enabled: true;
        text-color: @foreground;
        background-color: @background;
        padding: 0.2em 0.4em;
    }

    // List view //
    listbox {
        spacing: 0.5em;
        padding: 0.5em;
        background-color: transparent;
    }

    listview {
        enabled: true;
        columns: 1;
        lines:   6;
        cycle:   true;
        dynamic: true;
        scrollbar: false;
        layout: vertical;
        background-color: transparent;
        text-color: @foreground;
    }

    // Elements (programs) //
    element {
        enabled: true;
        spacing: 0.5em;
        padding: 0.3em 0.5em;
        cursor: pointer;
        background-color: transparent;
        text-color: @foreground;
    }

    // Highlight both selection and mouse hover
    element selected.normal,
    element selected.active,
    element selected.focused,
    element hovered {
        background-color: @foreground;
        text-color: @background;
    }

    element-icon {
        size: 1.5em;
        background-color: transparent;
        text-color: inherit;
    }

    element-text {
        cursor: inherit;
        background-color: transparent;
        text-color: inherit;
    }

    // Error messages //
    error-message {
        text-color: @foreground;
        background-color: @background;
    }

    textbox {
        text-color: @foreground;
        background-color: inherit;
    }
  '';

  xdg.configFile."rofi/wallpaper.rasi".text = ''
    configuration {
        modi:                        "drun";
        show-icons:                  true;
        drun-display-format:         "{name}";
    }

    @theme "~/.config/rofi/colors.rasi"

    window {
        enabled:                     true;
        fullscreen:                  false;
        width:                       100%;
        transparency:                "real";
        cursor:                      "default";
        spacing:                     0px;
        padding:                     0px;
        border:                      0px;
        border-radius:               0px;
        border-color:                transparent;
        background-color:            transparent;
    }

    mainbox {
        enabled:                     true;
        children:                    [ "listview" ];
        background-color:            @background;
    }

    listview {
        enabled:                     true;
        columns:                     6;
        lines:                       1;
        spacing:                     10px 20px;
        padding:                     20px 10px;
        cycle:                       true;
        dynamic:                     false;
        scrollbar:                   false;
        layout:                      vertical;
        reverse:                     false;
        fixed-height:                false;
        height: 40px;
        fixed-columns:               true;
        cursor:                      "default";
        background-color:            transparent;
        text-color:                  transparent;
    }

    element {
        enabled:                     true;
        orientation:                 horizontal;
        spacing:                     0px;
        padding:                     4px;
        border-radius:               4px;
        cursor:                      pointer;
        background-color:            transparent;
        text-color:                  transparent;
    }

    @media(max-aspect-ratio: 1.8) {
        element {
            orientation:             vertical;
        }
    }

    element selected.normal {
        background-color:            @foreground;
        text-color:                  transparent;
    }

    element-icon {
        size:                        50%;
            border-radius:				 4px;
        cursor:                      inherit;
        background-color:            transparent;
        text-color:                  transparent;
    }

    element-text {
      enabled: false;
    }
  '';

  xdg.configFile."rofi/fullscreen-grid.rasi".text = ''
    @import "~/.config/rofi/colors.rasi"
    configuration {
  show-icons: true;
  drun-display-format: "{name}";
  icon-theme: "Papirus-Dark";
  location: 5;
}

* {
  background-color: @background;
  text-color: @foreground;
}

window {
  fullscreen: true;
  width: 100%;
  height: 100%;
  font: "UW Ttyp0 10";
  background-color: @background;
}

prompt { enabled: false; }

entry  {
  padding: 10px 0 10px 0;
  horizontal-align: 0.5;
  margin: 65px 40% 0 40%;
  color: @normal-foreground;
  background-color: @normal-background;
  font: "UW Ttyp0 11";
  border-radius: 30px;
  placeholder: "Search";
}

listview {
  columns: 7;
  margin: 10% 10% 10% 10%;
}

element {
  padding: 0.8%;
  margin: 1%;
  orientation: vertical;
}

element selected {
  text-color: @foreground;
  background-color: @background;
  border-radius: 10px;
}

element-icon {
  size: 64;
}

element-text {
  horizontal-align: 0.5;
}
  '';
}

