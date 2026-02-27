{ config, pkgs, lib, ... }:

{
  services.displayManager.sddm = {
    enable = true;

    # Wayland support (important for Hyprland)
    wayland.enable = true;

    # Use the custom sugar-dark theme from pkgs overlay
    theme = "sugar-dark";
    package = pkgs.kdePackages.sddm;

    # Add theme and dependencies to system packages
    extraPackages = with pkgs; [
      sddm-sugar-dark-theme
      kdePackages.qtsvg
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
    ];

    # Optional but recommended
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        Font = "JetBrainsMono Nerd Font";
      };
    };
  };

  # Ensure theme is available in system packages
  environment.systemPackages = with pkgs; [
    sddm-sugar-dark-theme
  ];
}


