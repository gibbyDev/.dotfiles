{ config, pkgs, ... }:

let
  vscode-version = "1.88.1"; # Change this to your desired version
  my-vscode = pkgs.vscode.overrideAttrs (oldAttrs: {
    version = vscode-version;
    src = pkgs.fetchurl {
      url = "https://update.code.visualstudio.com/${vscode-version}/linux-x64/stable";
      sha256 = "sha256-YnKo5jTWiulc8tmNm0XPizb+TfSGNNKuIuCEN/nhqZI=";
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

