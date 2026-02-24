{pkgs, ...}: {
  home.packages = with pkgs; [pyprland];

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
plugins = ["scratchpads"]

[scratchpads.term]
animation = "fromTop"
command = "kitty --class dropterm"
class = "dropterm"
size = "70% 70%"
position = "center"
lazy = true
  '';
}
