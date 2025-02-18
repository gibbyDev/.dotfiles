{ config, pkgs, ... }:

{
  imports = [
    ../../modules
    #./home-modules/kitty.nix
    #./home-modules/hyprland.nix
    #./home-modules/firefox.nix
    #./home-modules/rofi.nix
    #./home-modules/btop.nix
    # ./home-modules/pywal.nix
    #./home-modules/yazi.nix
    #./home-modules/nvim.nix
  ];

  home.username = "cody";
  home.homeDirectory = "/home/cody";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
     hello
     kitty
     swww
     pywal
  ];

  home.file = {

  };

 
  home.sessionVariables = {
    # EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
