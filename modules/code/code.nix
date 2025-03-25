{ config, pkgs, ... }:

let
  vscode-version = "1.88.1"; # Change this to your desired version
  my-vscode = pkgs.vscode.overrideAttrs (oldAttrs: {
    version = vscode-version;
    src = pkgs.fetchurl {
      url = "https://update.code.visualstudio.com/${vscode-version}/linux-x64/stable";
      sha256 = "sha256-14m9w7wkg1704apd4d46yi6zwdlbrx2rp3fry9ffk2nn6kkahwk2"; # Replace with the correct hash
    };
  });
in
{
  programs.vscode = {
    enable = true;
    package = my-vscode;  # Use overridden VS Code package

    extensions = with pkgs.vscode-extensions; [
      esbenp.prettier-vscode
      vscodevim.vim
      github.copilot
      ms-azuretools.vscode-docker
    ];

    userSettings = {
      "editor.formatOnSave" = true;
      "editor.fontFamily" = "Fira Code";
      "editor.fontLigatures" = true;
      "editor.tabSize" = 4;
      "files.autoSave" = "afterDelay";
      "workbench.colorTheme" = "Pywal";
      "editor.minimap.enabled" = false;
      "vim.useSystemClipboard" = true;
    };
  };
}

