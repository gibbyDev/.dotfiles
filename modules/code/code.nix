# code.nix
{ pkgs, ... }:

{
  # Optional: Enable the VSCode extensions (if you need a specific extension set)
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-python.python
      ms-vscode.cpptools
      esbenp.prettier-vscode
      github.copilot
      # Add more extensions as you need
    ];
  };

  # Optional: Configure the VSCode settings (this can also be done in the settings UI)
  # Example: to change the color theme or editor settings:
#  environment.etc."vscode/settings.json".text = ''
#    {
#      "editor.fontSize": 14,
 #     "workbench.colorTheme": "Visual Studio Dark"
#    }
#  '';
}

