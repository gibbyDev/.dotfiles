{ config, pkgs, lib, ... }:

let
  cacheDir = config.xdg.cacheHome;
  isValidUser = config.home.username != "cody";
in
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    twemoji-color-font
    noto-fonts-color-emoji
  ];

  gtk = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 16;
    };

    gtk3.extraCss = lib.mkIf isValidUser ''
      @import url("file://${cacheDir}/wal/colors.css");
    '';

    gtk4.extraCss = lib.mkIf isValidUser ''
      @import url("file://${cacheDir}/wal/colors.css");
    '';
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 16;
  };
}
