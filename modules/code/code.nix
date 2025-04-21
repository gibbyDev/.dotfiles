{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    package = pkgs.vscode;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        github.copilot
        vscodevim.vim
        esbenp.prettier-vscode
        ms-azuretools.vscode-docker
      ];

      userSettings = {
        "editor.fontFamily" = "Fira Code";
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "editor.tabSize" = 4;
        "files.autoSave" = "afterDelay";
        "vim.useSystemClipboard" = true;
        "workbench.colorTheme" = "Pywal";
        "workbench.sideBar.location" = "right";
        "github.copilot.nextEditSuggestions.enabled" = true;
      };
    };
  };
}

