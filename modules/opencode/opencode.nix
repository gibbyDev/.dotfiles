{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.opencode;
in
{
  options.programs.opencode = {
    enable = mkEnableOption "OpenCode AI editor";

    package = mkOption {
      type = types.package;
      default = pkgs.opencode;
      description = "The opencode package to use.";
    };

    enableCopilot = mkOption {
      type = types.bool;
      default = true;
      description = "Enable GitHub Copilot integration via GitHub CLI auth.";
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      [ cfg.package ]
      ++ optional cfg.enableCopilot pkgs.gh;

    # Environment variables opencode / copilot typically rely on
    home.sessionVariables = mkMerge [
      (mkIf cfg.enableCopilot {
        GITHUB_COPILOT = "1";
        GITHUB_TOKEN = ""; # picked up from gh auth at runtime
      })
    ];

    # Example config file for opencode
    xdg.configFile."opencode/config.toml".text = ''
      [editor]
      theme = "dark"
      autoSave = true

      [ai]
      provider = "github-copilot"

      [ai.github]
      auth = "gh"
    '';

    # Friendly reminder if gh isn’t authenticated yet
    home.activation.opencodeCopilotAuth =
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ "${toString cfg.enableCopilot}" = "1" ]; then
          if ! ${pkgs.gh}/bin/gh auth status >/dev/null 2>&1; then
            echo "⚠️  GitHub Copilot enabled, but gh is not authenticated."
            echo "Run: gh auth login"
          fi
        fi
      '';
  };
}

