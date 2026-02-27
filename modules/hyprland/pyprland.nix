{pkgs, ...}: {
  home.packages = with pkgs; [pyprland];

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
plugins = ["scratchpads"]

[scratchpads.term]
animation = "fromTop"
command = "kitty --class floating-term"
class = "floating-term"
size = "60% 60%"
position = ""
on_open = "move cursor 0 0"
lazy = true
  '';
}
