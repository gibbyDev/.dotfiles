{ config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;

    # Use the unwrapped package to avoid extension issues
    package = pkgs.vscode;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        github.copilot
        vscodevim.vim
        esbenp.prettier-vscode
        ms-azuretools.vscode-docker
      ];

      userSettings = {
        ## Editor
        "editor.fontFamily" = "Fira Code";
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "editor.tabSize" = 4;

        ## Files
        "files.autoSave" = "afterDelay";

        ## Vim
        "vim.useSystemClipboard" = true;
        ## Line numbers
        "editor.lineNumbers" = "relative";

        ## Vim polish
        "vim.smartRelativeLine" = true; # absolute number on current line
        "vim.hlsearch" = true; # highlight search matches

        ## UI
        "workbench.sideBar.location" = "right";
        "workbench.colorTheme" = "Pywal";

        ## Copilot
        "github.copilot.enable" = {
          "*" = true;
          "plaintext" = false;
          "markdown" = true;
        };
        "github.copilot.nextEditSuggestions.enabled" = true;
      };
    };
  };
}
