{ config, pkgs, lib, ... }:

{
  services.displayManager.sddm = {
    enable = true;

    # Wayland support (important for Hyprland)
    wayland.enable = true;

    # Optional but recommended
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        Font = "JetBrainsMono Nerd Font";
      };
    };
  };

  # Make sure SDDM has themes available
  environment.systemPackages = with pkgs; [
    sddm
    sddm-themes
  ];
}

