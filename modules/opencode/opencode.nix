{ config, lib, pkgs, ... }:

let
  cfg = config.programs.opencode;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.gh ];

    xdg.configFile."opencode/config.toml".text = ''
      [ai]
      provider = "github-copilot"

      [ai.github]
      auth = "gh"
    '';
  };
}

