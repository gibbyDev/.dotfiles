{ config, pkgs, ... }: 
{
  wayland.windowManager.hyprland = {

    settings = {
      monitor = [ ",preferred,auto,auto" ];

      exec-once = [
        "waybar &"
          "spotify &"
          "${pkgs.swww}/bin/swww-daemon"
          "networkmanagerapplet --indicator"
          "$HOME/.local/share/bin/set-wallpaper.sh"
      ];

      env = [
        "PATH,$PATH:$HOME/.local/share/bin"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        force_no_accel = 1;
        numlock_by_default = true;

        touchpad.natural_scroll = false;
      };

      device = [{ name = "epic mouse V1"; sensitivity = -0.5; }];

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      general = {
        gaps_in = 3;
        gaps_out = 8;
        border_size = 0;
        "col.active_border" = "rgba(ff00ffee)";
        "col.inactive_border" = "rgba(888888aa)";
      };

      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 6;
          passes = 2;
        };
      };

      animations = {
        enabled = true;
        bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
        animation = [
          "windows, 1, 3, myBezier"
            "border, 1, 10, default"
            "fade, 1, 10, default"
            "workspaces, 1, 2, default"
        ];
      };

      misc = {
        vrr = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
      };

      xwayland.force_zero_scaling = true;

      bindm = [
          "SUPER, mouse_down, workspace, e+1"
          "SUPER, mouse_up, workspace, e-1"

            # Move/Resize focused window
          "SUPER, mouse:272, movewindow"
          "SUPER, Z, movewindow"
          "SUPER, X, resizewindow"


      ]

      bind = [
# Window/Session actions
        "SUPER, Q, exec, $HOME/.local/share/bin/dontkillsteam.sh"
          "ALT, F4, exec, $HOME/.local/share/bin/dontkillsteam.sh"
          "SUPER, Delete, exit"
          "SUPER, W, togglefloating"
          "SUPER, G, togglegroup"
          "ALT, Return, fullscreen"
          "SUPER, L, exec, swaylock"
          "SUPER+SHIFT, F, exec, $HOME/.local/share/bin/windowpin.sh"
          "SUPER, Backspace, exec, wlogout"

# Applications
          "SUPER, T, exec, kitty"
          "SUPER, E, exec, dolphin"
          "SUPER, C, exec, code"
          "SUPER, F, exec, firefox"

# Rofi
          "SUPER, A, exec, pkill -x rofi || $HOME/.local/share/bin/rofilaunch.sh d"
          "SUPER, Tab, exec, pkill -x rofi || $HOME/.local/share/bin/rofilaunch.sh w"
          "SUPER+SHIFT, E, exec, pkill -x rofi || $HOME/.local/share/bin/rofilaunch.sh f"

# Audio
          ", F10, exec, $HOME/.local/share/bin/volumecontrol.sh -o m"
          ", F11, exec, $HOME/.local/share/bin/volumecontrol.sh -o d"
          ", F12, exec, $HOME/.local/share/bin/volumecontrol.sh -o i"

# Media keys
          ", XF86AudioMute, exec, $HOME/.local/share/bin/volumecontrol.sh -o m"
          ", XF86AudioLowerVolume, exec, $HOME/.local/share/bin/volumecontrol.sh -o d"
          ", XF86AudioRaiseVolume, exec, $HOME/.local/share/bin/volumecontrol.sh -o i"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"

# Brightness
          ", XF86MonBrightnessUp, exec, $HOME/.local/share/bin/brightnesscontrol.sh i"
          ", XF86MonBrightnessDown, exec, $HOME/.local/share/bin/brightnesscontrol.sh d"

# Screenshots
          "SUPER, P, exec, $HOME/.local/share/bin/screenshot.sh s"
          "SUPER+CTRL, P, exec, $HOME/.local/share/bin/screenshot.sh sf"
          "SUPER+ALT, P, exec, $HOME/.local/share/bin/screenshot.sh m"
          ", Print, exec, $HOME/.local/share/bin/screenshot.sh p"

# Custom scripts
          "SUPER+ALT, G, exec, $HOME/.local/share/bin/gamemode.sh"
          "SUPER+ALT, Right, exec, $HOME/.local/share/bin/set-wallpaper.sh next"
          "SUPER+ALT, Left, exec, $HOME/.local/share/bin/set-wallpaper.sh prev"
          "SUPER+ALT, Up, exec, $HOME/.local/share/bin/wbarconfgen.sh n"

# Move/Change window focus
          "SUPER, Left, movefocus, l"
          "SUPER, Right, movefocus, r"
          "SUPER, Up, movefocus, u"
          "SUPER, Down, movefocus, d"
          "Alt, Tab, movefocus, d"

# Move to the first empty workspace
          "SUPER+Ctrl, Down, workspace, empty" 

# Resize windows
          "SUPER+Shift, Right, resizeactive, 30 0"  
          "SUPER+Shift, Left, resizeactive, -30 0"
          "SUPER+Shift, Up, resizeactive, 0 -30"
          "SUPER+Shift, Down, resizeactive, 0 30"

          "SUPER+SHIFT+CTRL, left, exec, $HOME/.local/share/bin/move-floating.sh l -30"
          "SUPER+SHIFT+CTRL, right, exec, $HOME/.local/share/bin/move-floating.sh r 30"
          "SUPER+SHIFT+CTRL, up, exec, $HOME/.local/share/bin/move-floating.sh u -30"
          "SUPER+SHIFT+CTRL, down, exec, $HOME/.local/share/bin/move-floating.sh d 30"

            # Move active window around current workspace with mainMod + SHIFT + CTRL [←→↑↓]
            #"$moveactivewindow=grep -q 'true' <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive"
            #"SUPER+Shift+Ctrl, left, Move active window to the left, exec, $moveactivewindow -30 0 || hyprctl dispatch movewindow l"
            #"SUPER+Shift+Ctrl, right, Move active window to the right, exec, $moveactivewindow 30 0 || hyprctl dispatch movewindow r"
            #"SUPER+Shift+Ctrl, up, Move active window up, exec, $moveactivewindow 0 -30 || hyprctl dispatch movewindow u"
            #"SUPER+Shift+Ctrl, down, Move active window down, exec, $moveactivewindow 0 30 || hyprctl dispatch movewindow d"

            # Workspace toggles
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"

          "SUPER+SHIFT, 1, movetoworkspace, 1"
          "SUPER+SHIFT, 2, movetoworkspace, 2"
          "SUPER+SHIFT, 3, movetoworkspace, 3"
          "SUPER+SHIFT, 4, movetoworkspace, 4"
          "SUPER+SHIFT, 5, movetoworkspace, 5"
          "SUPER+SHIFT, 6, movetoworkspace, 6"
          "SUPER+SHIFT, 7, movetoworkspace, 7"
          "SUPER+SHIFT, 8, movetoworkspace, 8"
          "SUPER+SHIFT, 9, movetoworkspace, 9"
          "SUPER+SHIFT, 0, movetoworkspace, 10"

# Move/Switch to special workspace (scratchpad)
          "SUPER+Alt, S, movetoworkspacesilent, special"
          "SUPER, S, togglespecialworkspace"

          "SUPER, J, togglesplit"

# Move focused window to a workspace silently
          "SUPER+Alt, 1, movetoworkspacesilent, 1"
          "SUPER+Alt, 2, movetoworkspacesilent, 2"
          "SUPER+Alt, 3, movetoworkspacesilent, 3"
          "SUPER+Alt, 4, movetoworkspacesilent, 4"
          "SUPER+Alt, 5, movetoworkspacesilent, 5"
          "SUPER+Alt, 6, movetoworkspacesilent, 6"
          "SUPER+Alt, 7, movetoworkspacesilent, 7"
          "SUPER+Alt, 8, movetoworkspacesilent, 8"
          "SUPER+Alt, 9, movetoworkspacesilent, 9"
          "SUPER+Alt, 0, movetoworkspacesilent, 10"
          ];

      windowrulev2 = [
          "opacity 0.90 0.80,class:^(firefox)$"
          "opacity 0.90 0.90,class:^(Google-chrome)$"
          "opacity 0.90 0.90,class:^(Brave-browser)$"
          "opacity 0.80 0.80,class:^(code-oss)$"
          "opacity 0.80 0.80,class:^([Cc]ode)$"
          "opacity 0.80 0.80,class:^(code-url-handler)$"
          "opacity 0.80 0.80,class:^(code-insiders-url-handler)$"
          "opacity 0.86 0.80,class:^(kitty)$"
          "opacity 0.86 0.80,class:^(yazi)$"
          "opacity 0.80 0.80,class:^(org.kde.dolphin)$"
          "opacity 0.80 0.80,class:^(org.kde.ark)$"
          "opacity 0.80 0.80,class:^(nwg-look)$"
          "opacity 0.80 0.80,class:^(qt5ct)$"
          "opacity 0.80 0.80,class:^(qt6ct)$"
          "opacity 0.80 0.80,class:^(kvantummanager)$"
          "opacity 0.80 0.70,class:^(org.pulseaudio.pavucontrol)$"
          "opacity 0.80 0.70,class:^(blueman-manager)$"
          "opacity 0.80 0.70,class:^(networkmanagerapplet)$"
          "opacity 0.80 0.70,class:^(nm-connection-editor)$"
          "opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$"
          "opacity 0.80 0.70,class:^(polkit-gnome-authentication-agent-1)$"
          "opacity 0.80 0.70,class:^(org.freedesktop.impl.portal.desktop.gtk)$"
          "opacity 0.80 0.70,class:^(org.freedesktop.impl.portal.desktop.hyprland)$"
          "opacity 0.70 0.70,class:^([Ss]team)$"
          "opacity 0.70 0.70,class:^(steamwebhelper)$"
          "opacity 0.70 0.70,class:^([Ss]potify)$"
          "opacity 0.70 0.70,initialTitle:^(Spotify Free)$"
          "opacity 0.70 0.70,initialTitle:^(Spotify Premium)$"

          "opacity 0.90 0.90,class:^(com.github.rafostar.Clapper)$"
          "opacity 0.80 0.80,class:^(com.github.tchx84.Flatseal)$"
          "opacity 0.80 0.80,class:^(hu.kramo.Cartridges)$"
          "opacity 0.80 0.80,class:^(com.obsproject.Studio)$"
          "opacity 0.80 0.80,class:^(gnome-boxes)$"
          "opacity 0.80 0.80,class:^(vesktop)$"
          "opacity 0.80 0.80,class:^(discord)$"
          "opacity 0.80 0.80,class:^(WebCord)$"
          "opacity 0.80 0.80,class:^(ArmCord)$"
          "opacity 0.80 0.80,class:^(app.drey.Warp)$"
          "opacity 0.80 0.80,class:^(net.davidotek.pupgui2)$"
          "opacity 0.80 0.80,class:^(yad)$"
          "opacity 0.80 0.80,class:^(Signal)$"
          "opacity 0.80 0.80,class:^(io.github.alainm23.planify)$"
          "opacity 0.80 0.80,class:^(io.gitlab.theevilskeleton.Upscaler)$"
          "opacity 0.80 0.80,class:^(com.github.unrud.VideoDownloader)$"
          "opacity 0.80 0.80,class:^(io.gitlab.adhami3310.Impression)$"
          "opacity 0.80 0.80,class:^(io.missioncenter.MissionCenter)$"
          "opacity 0.80 0.80,class:^(io.github.flattool.Warehouse)$"

          "float,class:^(org.kde.dolphin)$,title:^(Progress Dialog — Dolphin)$"
          "float,class:^(org.kde.dolphin)$,title:^(Copying — Dolphin)$"
          "float,title:^(About Mozilla Firefox)$"
          "float,class:^(firefox)$,title:^(Picture-in-Picture)$"
          "float,class:^(firefox)$,title:^(Library)$"
          "float,class:^(kitty)$,title:^(top)$"
          "float,class:^(kitty)$,title:^(btop)$"
          "float,class:^(kitty)$,title:^(htop)$"
          "float,class:^(vlc)$"
          "float,class:^(kvantummanager)$"
          "float,class:^(qt5ct)$"
          "float,class:^(qt6ct)$"
          "float,class:^(nwg-look)$"
          "float,class:^(org.kde.ark)$"
          "float,class:^(org.pulseaudio.pavucontrol)$"
          "float,class:^(blueman-manager)$"
          "float,class:^(nm-applet)$"
          "float,class:^(nm-connection-editor)$"
          "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"

          "float,class:^(Signal)$"
          "float,class:^(com.github.rafostar.Clapper)$"
          "float,class:^(app.drey.Warp)$"
          "float,class:^(net.davidotek.pupgui2)$"
          "float,class:^(yad)$"
          "float,class:^(eog)$"
          "float,class:^(io.github.alainm23.planify)$"
          "float,class:^(io.gitlab.theevilskeleton.Upscaler)$"
          "float,class:^(com.github.unrud.VideoDownloader)$"
          "float,class:^(io.gitlab.adhami3310.Impression)$"
          "float,class:^(io.missioncenter.MissionCenter)$"
          ];

      windowrule = [
        "float,title:^(Open)$"
          "float,title:^(Choose Files)$"
          "float,title:^(Save As)$"
          "float,title:^(Confirm to replace files)$"
          "float,title:^(File Operation Progress)$"
      ];

      layerrule = [
        "blur,rofi"
          "ignorezero,rofi"
          "blur,notifications"
          "ignorezero,notifications"
          "blur,swaync-notification-window"
          "ignorezero,swaync-notification-window"
          "blur,swaync-control-center"
          "ignorezero,swaync-control-center"
          "blur,logout_dialog"
      ];
    };
  };
}
