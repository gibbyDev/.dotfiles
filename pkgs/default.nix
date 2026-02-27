{ pkgs, ... }:
{
  # SDDM theme packages
  # These will be overlayed into nixpkgs automatically
  # Usage: pkgs.sddm-sugar-dark-theme
  sddm-sugar-dark-theme = pkgs.callPackage ./sddm-themes/sugar-dark.nix { };
}
