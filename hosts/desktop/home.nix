{ config, pkgs, lib, src, ... }:

{
  imports = [
    ../../modules
  ];

  home.username = "cody";
  home.homeDirectory = "/home/cody";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    hello
    libsForQt5.qt5ct
#    libsForQt6.qt6ct
    kitty
    neofetch
    fastfetch
    tree
    git
    swww
    pywal
    bat
  ];

  xdg.configFile."kdeglobals".text = ''
    [General]
    ColorScheme=BreezeDark
    Name=BreezeDark
  '';


  # Copy all scripts from ./scripts into ~/.local/share/bin
#  home.file.".local/share/bin/set-wallpaper.sh" = {
#    source = "../../scripts/set-wallpaper.sh";
#    recursive = true;
#  };

  # Use a custom script to copy wallpapers to the correct location
#  home.activation.wallpapers = lib.hm.dag.entryAfter ["writeBoundary"] ''
#    mkdir -p "$HOME/Pictures/wallpapers"
#    cp -r ../../wallpapers/* "$HOME/Pictures/wallpapers/"
#  '';

#  home.activation.makeScriptsExecutable = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
#    chmod +x "$HOME/.local/share/bin/"*
#  '';

#  home.sessionPath = [ "$HOME/.local/share/bin" ];

  programs.home-manager.enable = true;
}

