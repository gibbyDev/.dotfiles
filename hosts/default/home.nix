{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules
  ];

  home.username = "cody";
  home.homeDirectory = "/home/cody";
  home.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    kitty
    screenkey
    docker
    tree
    ffmpeg
    unzip
    gimp
    ripgrep
    fzf
    lsd
    lazygit
    opencode
    neofetch
    fastfetch
    tree
    chafa
    git
    nodejs_20
    # zig_0_12
    swww
    tailwindcss
    templ
    imagemagick
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

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  programs.dircolors.enable = true;

  home.file.".p10k.zsh".source = ../../.p10k.zsh;
  
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

  home.file.".config/lsd/colors.yaml".text = ''
    date: "white"
    user: "white"
    group: "white"
    # ...any other preferences
  '';

  programs.home-manager.enable = true;
}

