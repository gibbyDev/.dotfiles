{ config, pkgs, ... }: {

  wayland.windowManager.hyprland = {
    settings = {
      monitor = [ ",preferred,auto,auto" ];

      exec-once = [
        "${pkgs.swww}/bin/swww-daemon &"
        "networkmanagerapplet --indicator &"
        "$HOME/.local/share/bin/set-wallpaper.sh &"
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

      device = [
        {
          name = "epic mouse V1";
          sensitivity = -0.5;
        }
      ];

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
        gaps_in = 2;
        gaps_out = 4;
        border_size = 0;
        "col.active_border" = "rgba(ff00ffee)";
        "col.inactive_border" = "rgba(888888aa)";
      };

      decoration = {
        rounding = 2;
        blur = {
          enabled = true;
          size = 6;
          passes = 2;
        };
      };

      animations = {
        enabled = false;
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
      #
      # bindm = [
      #   "SUPER, mouse_down, exec, \"$HOME/.local/share/bin/switch-workspace.sh down\""
      #   "SUPER, mouse_up, exec, \"$HOME/.local/share/bin/switch-workspace.sh up\""
      #   "SUPER, mouse:272, movewindow"
      #   "SUPER, Z, movewindow"
      #   "SUPER, X, resizewindow"
      # ];
      #
      bind = [
        "SUPER, Q, exec, $HOME/.local/share/bin/dontkillsteam.sh"
        "ALT, F4, exec, $HOME/.local/share/bin/dontkillsteam.sh"
        "SUPER, Delete, exit"
        "SUPER, W, togglefloating"
        "SUPER, G, togglegroup"
        "ALT, Return, fullscreen"
        "SUPER, L, exec, swaylock"
        "SUPER+SHIFT, F, exec, $HOME/.local/share/bin/windowpin.sh"
        "SUPER, Backspace, exec, wlogout"

        "SUPER, T, exec, kitty"
        "SUPER, E, exec, dolphin"
        "SUPER, C, exec, code"
        "SUPER, F, exec, firefox"

        "SUPER, A, exec, pkill -x rofi || $HOME/.local/share/bin/rofilaunch.sh d"
        "SUPER, Tab, exec, pkill -x rofi || $HOME/.local/share/bin/rofilaunch.sh w"
        "SUPER+SHIFT, E, exec, pkill -x rofi || $HOME/.local/share/bin/rofilaunch.sh f"

        "bind = SUPER, B, exec, sh -c 'systemctl --user is-active waybar && systemctl --user stop waybar || systemctl --user start waybar'"

        ", F10, exec, $HOME/.local/share/bin/volumecontrol.sh -o m"
        ", F11, exec, $HOME/.local/share/bin/volumecontrol.sh -o d"
        ", F12, exec, $HOME/.local/share/bin/volumecontrol.sh -o i"

        ", XF86AudioMute, exec, $HOME/.local/share/bin/volumecontrol.sh -o m"
        ", XF86AudioLowerVolume, exec, $HOME/.local/share/bin/volumecontrol.sh -o d"
        ", XF86AudioRaiseVolume, exec, $HOME/.local/share/bin/volumecontrol.sh -o i"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        ", XF86MonBrightnessUp, exec, $HOME/.local/share/bin/brightnesscontrol.sh i"
        ", XF86MonBrightnessDown, exec, $HOME/.local/share/bin/brightnesscontrol.sh d"

        "SUPER, P, exec, $HOME/.local/share/bin/screenshot.sh s"
        "SUPER+CTRL, P, exec, $HOME/.local/share/bin/screenshot.sh sf"
        "SUPER+ALT, P, exec, $HOME/.local/share/bin/screenshot.sh m"
        ", Print, exec, $HOME/.local/share/bin/screenshot.sh p"

        "SUPER+ALT, G, exec, $HOME/.local/share/bin/gamemode.sh"
        "SUPER+ALT, Right, exec, $HOME/.local/share/bin/set-wallpaper.sh next"
        "SUPER+ALT, Left, exec, $HOME/.local/share/bin/set-wallpaper.sh prev"
        "SUPER+ALT, Up, exec, $HOME/.local/share/bin/wbarconfgen.sh n"

        "SUPER, Left, movefocus, l"
        "SUPER, Right, movefocus, r"
        "SUPER, Up, movefocus, u"
        "SUPER, Down, movefocus, d"
        "ALT, <Tab>, movefocus, d"

        "SUPER+Ctrl, Down, workspace, empty"

        "SUPER+Shift, Right, resizeactive, 30 0"
        "SUPER+Shift, Left, resizeactive, -30 0"
        "SUPER+Shift, Up, resizeactive, 0 -30"
        "SUPER+Shift, Down, resizeactive, 0 30"

        "SUPER+SHIFT+CTRL, left, exec, \"$HOME/.local/share/bin/move-floating.sh l -30\""
        "SUPER+SHIFT+CTRL, right, exec, \"$HOME/.local/share/bin/move-floating.sh r 30\""
        "SUPER+SHIFT+CTRL, up, exec, \"$HOME/.local/share/bin/move-floating.sh u -30\""
        "SUPER+SHIFT+CTRL, down, exec, \"$HOME/.local/share/bin/move-floating.sh d 30\""

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

        "SUPER+Alt, S, movetoworkspacesilent, special"
        "SUPER, S, togglespecialworkspace"

        "SUPER, J, togglesplit"

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
      ];
    };
  };
}

