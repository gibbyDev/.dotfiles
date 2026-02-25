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
        let baseName = lib.baseNameOf path;
        in baseName != ".git"
           && baseName != ".direnv"
           && baseName != "result";
    };

    hostDirs = builtins.attrNames (builtins.readDir ./hosts);

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

    devShells.${system} = {

golang = pkgs.mkShell {
  name = "golang-shell";

  # -----------------------
  # Packages
  # -----------------------
  buildInputs = with pkgs; [
    go         # Golang compiler & tooling
    git        # for cloning repos
    curl       # fetch templates/examples
    gnumake    # optional, for builds
    bash       # shell utilities
  ];

  # -----------------------
  # Shell setup
  # -----------------------
  shellHook = ''
    echo ""
    echo "🚀 Golang dev shell ready"

    # Ensure GOPATH/bin is in PATH
    export GOPATH=$HOME/go
    export PATH=$GOPATH/bin:$PATH

    # Go modules enabled
    export GO111MODULE=on

    # Preinstall templ if missing
    if [ ! -x "$GOPATH/bin/templ" ]; then
      echo "Installing Templ..."
      mkdir -p $GOPATH/src/github.com/evanw/templ
      cd $GOPATH/src/github.com/evanw
      git clone https://github.com/evanw/templ.git
      cd templ
      go install ./...
      cd -
    fi

    echo "Go version: $(go version)"
    echo "Templ location: $(command -v templ || echo 'not found')"
    echo "HTMX is front-end only: include <script src='https://unpkg.com/htmx.org@1.11.1'></script> in HTML"
  '';
};


      # -----------------------
      # Jetzig dev shell
      # -----------------------
      jetzig = pkgs.mkShell {
        name = "jetzig-shell";

        buildInputs = with pkgs; [
          zig
          git
          gnumake
          pkg-config
          openssl
        ];

        shellHook = ''
          echo ""
          echo "🚀 Jetzig dev shell ready"

          export JETZIG_HOME=$HOME/.jetzig
          export ZIG_GLOBAL_CACHE_DIR=$HOME/.cache/zig
          export PATH=$JETZIG_HOME/zig-out/bin:$PATH

          # Clone if missing
          if [ ! -d "$JETZIG_HOME" ]; then
            echo "Cloning Jetzig into $JETZIG_HOME ..."
            git clone https://github.com/jetzig-framework/jetzig $JETZIG_HOME
          fi

          # Build if not built yet
          if [ ! -f "$JETZIG_HOME/zig-out/bin/jetzig" ]; then
            echo "Building Jetzig..."
            cd $JETZIG_HOME
            zig build -Doptimize=ReleaseSafe
            cd -
          fi

          echo "jetzig location: $(command -v jetzig || echo 'not found')"
        '';
      };

      # -----------------------
      # MERN dev shell
      # -----------------------
      mern = pkgs.mkShell {
        name = "mern-shell";

        buildInputs = with pkgs; [
          nodejs
          yarn
          mongodb-tools
          git
          curl
          openssl
          gnumake
        ];

        shellHook = ''
          echo ""
          echo "🚀 MERN dev shell ready"

          # Local node_modules bin
          export PATH=$(pwd)/node_modules/.bin:$PATH

          # Default MongoDB URL
          export MONGO_URL="mongodb://localhost:27017"

          echo "Node.js version: $(node -v)"
          echo "npm version: $(npm -v)"
          echo "MongoDB tools available: $(which mongo || echo 'not found')"
        '';
      };
    };
  };
}
