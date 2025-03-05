# shell.nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.fhsUserEnv  # This provides a traditional Linux environment
    pkgs.nodejs      # If you need node or other dependencies
  ];

  shellHook = ''
    export PATH="$HOME/droidcam_install/bin:$PATH"
  '';
}

