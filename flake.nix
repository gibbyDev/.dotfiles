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
        overlays = [
          nur.overlays.default
        ];
        config.allowUnfree = true;
      };

      # Clean source to pass into Home Manager module
      src = lib.cleanSourceWith {
        src = ./.;
        filter = path: type:
          let baseName = baseNameOf path;
          in baseName != ".git" && baseName != ".direnv" && baseName != "result";
      };
      host = builtins.getEnv "HOST";
    in
    {
      # NixOS system configuration
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/${host}/configuration.nix
          ];
        };
      };

      # Home Manager standalone configuration
      homeConfigurations = {
        cody = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit src; }; # Pass `src` to `home.nix`
          modules = [
            ./hosts/${host}/home.nix
          ];
        };
      };
    };
}


