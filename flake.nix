{
  description = "NixOS with Hyprland and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
      let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
      in {
    # NixOS System Configuration (for `sudo nixos-rebuild switch`)
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/desktop/configuration.nix];
      };
    };

    # Optional: Home Manager standalone configuration (for `home-manager switch`)
    homeConfigurations = {
      cody = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./hosts/desktop/home.nix ];
      };
    };
  };
}

