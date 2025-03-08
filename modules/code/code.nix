# code.nix
{ pkgs, ... }:

{
  # Add Visual Studio Code to system packages
  environment.systemPackages = with pkgs; [
    vscode  # The Visual Studio Code package from Nixpkgs
  ];

  # Optional: Enable the VSCode extensions (if you need a specific extension set)
  programs.vscode = {
    enable = true;
    extensions = [
      "ms-python.python"
      "ms-vscode.cpptools"
      "esbenp.prettier-vscode"
      "github.copilot"
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

