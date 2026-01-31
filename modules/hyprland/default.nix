# { inputs, ... }:
# {
  # imports = [ (import ./hyprland.nix) ]
    # ++ [ (import ./config.nix) ];
# }

{
  imports = [
    ./hyprland.nix
    ./config.nix
    ./windowrules.nix
    ./pyprland.nix
  ];
}
