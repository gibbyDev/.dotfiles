{ pkgs, lib, ... }:

{
  # Install Zig globally (remove if you want shell-only)
  environment.systemPackages = with pkgs; [
    zig
    git
  ];

  # Dev shell for Jetzig work
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.shellAliases = {
    jetzig-shell = "nix develop .#jetzig";
  };
}
