{pkgs, ...}: {
  home.packages = with pkgs; [pyprland];

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
plugins = ["scratchpads"]

[scratchpads.term]
animation = "fromTop"
command = "kitty --class floating-term"
class = "floating-term"
size = "70% 50%"
position = "center top"
on_open = "move cursor 0 0"
lazy = true
  '';
}
