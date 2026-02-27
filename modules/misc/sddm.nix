{ config, pkgs, lib, ... }:

let
  # Define the sugar-dark theme with proper installation
  sugar-dark-theme = pkgs.stdenv.mkDerivation {
    name = "sddm-sugar-dark-theme";
    src = pkgs.fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
      sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
    };
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes/sugar-dark
      cp -R ./* $out/share/sddm/themes/sugar-dark/
    '';
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = lib.mkForce pkgs.kdePackages.sddm;

    # Bundle the theme with system packages so it's available to SDDM
    extraPackages = [
      sugar-dark-theme
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtmultimedia
      pkgs.kdePackages.qtvirtualkeyboard
    ];

    # Configure SDDM to use the sugar-dark theme
    settings = {
      General = {
        Session = "hyprland";
      };
      Theme = {
        Current = "sugar-dark";
        CursorTheme = "Bibata-Modern-Ice";
      };
    };
  };

  environment.systemPackages = [
    sugar-dark-theme
  ];
}



