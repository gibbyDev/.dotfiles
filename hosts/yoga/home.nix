{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules
  ];

  home.username = "cody";
  home.homeDirectory = "/home/cody";
  home.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;

  ################################
  # Packages
  ################################
  home.packages = with pkgs; [
    kitty
    obs-studio
    screenkey
    docker
    tree
    ffmpeg
    unzip
    gimp
    neofetch
    fastfetch
    tree
    git
    chromium
    nodejs_20
    # zig_0_12
    swww
    tailwindcss
    templ
    protobuf
    air
    pywal
    bat
    w3m
    nwg-displays
    (writeShellScriptBin "protoc-gen-go" ''
      export PATH=$HOME/.go/bin:$PATH
      go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
    '')

    (writeShellScriptBin "protoc-gen-go-grpc" ''
      export PATH=$HOME/.go/bin:$PATH
      go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
    '')
  ];

  ################################
  # Zsh
  ################################
  programs.zsh.shellAliases = {
    ls = "ls --color=auto";
    ll = "ls -lah --color=auto";
  };

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  ################################
  # Dircolors
  ################################
  programs.dircolors.enable = true;

  ################################
  # Powerlevel10k
  ################################
  home.file.".p10k.zsh".source = ../../.p10k.zsh;

  ################################
  # Activation scripts
  ################################
  home.activation.copyScripts =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p ~/.local/share/bin
      rm -rf ~/.local/share/bin/*
      cp -r ${../../scripts}/* ~/.local/share/bin/
      chmod +x ~/.local/share/bin/*
    '';

  home.activation.copyWallpapers =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p ~/Pictures/wallpapers
      rm -rf ~/Pictures/wallpapers/*
      cp -r ${../../wallpapers}/* ~/Pictures/wallpapers/
    '';

  ################################
  programs.home-manager.enable = true;
}

