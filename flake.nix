{
  description = "NixOS with Hyprland and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
  };
outputs = { self, nixpkgs, home-manager, nur, ... }@inputs:
let
  lib = nixpkgs.lib;
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    overlays = [ nur.overlays.default ];
    config.allowUnfree = true;
  };

  src = lib.cleanSourceWith {
    src = ./.;
    filter = path: type:
      let baseName = baseNameOf path;
      in baseName != ".git"
         && baseName != ".direnv"
         && baseName != "result";
  };

  # Automatically read host directories
  hostDirs =
    builtins.attrNames (builtins.readDir ./hosts);

  mkHost = host:
    lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/${host}/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit src; };
        }
      ];
    };

in
{
  nixosConfigurations =
    builtins.listToAttrs (
      map (host: {
        name = host;
        value = mkHost host;
      }) hostDirs
    );
};
}
#   outputs = { self, nixpkgs, home-manager, nur, ... }@inputs:
#     let
#       lib = nixpkgs.lib;
#       system = "x86_64-linux";
#       pkgs = import nixpkgs {
#         inherit system;
#         overlays = [
#           nur.overlays.default
#         ];
#         config.allowUnfree = true;
#       };
#
#       # Clean source to pass into Home Manager module
#       src = lib.cleanSourceWith {
#         src = ./.;
#         filter = path: type:
#           let baseName = baseNameOf path;
#           in baseName != ".git" && baseName != ".direnv" && baseName != "result";
#       };
#       # host = builtins.getEnv "HOST";
#     in
#     {
#       # NixOS system configuration
#       nixosConfigurations = {
#         nixos = lib.nixosSystem {
#           inherit system;
#           modules = [
#             # ./hosts/${host}/configuration.nix
#             ./hosts/default/configuration.nix
#           ];
#         };
#       };
#
#       # Home Manager standalone configuration
#       homeConfigurations = {
#         # ${host} = home-manager.lib.homeManagerConfiguration {
#         cody = home-manager.lib.homeManagerConfiguration {
#           inherit pkgs;
#           extraSpecialArgs = { inherit src; }; # Pass `src` to `home.nix`
#           modules = [
#             # ./hosts/${host}/home.nix
#             ./hosts/default/home.nix
#           ];
#         };
#       };
#     };
# }
#

