# { inputs, ... }:
# {
  # imports = [ (import ./hyprland.nix) ]
    # ++ [ (import ./config.nix) ];
# }

{
  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./config.nix
    ./pyprland.nix
  ];
}
