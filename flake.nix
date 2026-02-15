{
  description = "ParanaOS by GibbyDev";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    stash.url = "github:NotAShelf/stash";
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
      
      specialArgs = {
        inherit inputs src;
      };

      modules = [
        ./hosts/${host}/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs src; };
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
