{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    swww
    # hyprpicker
    # wofi
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      # hidpi = true;
    };
    # enableNvidiaPatches = false;
    systemd.enable = true;
  };
  wayland.windowManager.hyprland.extraConfig = ''
    source = ~/.config/hypr/monitors.conf
    source = ~/.config/hypr/workspaces.conf
    rule = float,class:floating-term
    rule = center,class:floating-term
    rule = size 400 200,class:floating-term
  '';

}
