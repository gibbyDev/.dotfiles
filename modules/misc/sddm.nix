{ config, pkgs, lib, ... }:

let
  sugar-candy-theme = pkgs.stdenv.mkDerivation rec {
    pname = "sugar-candy-sddm-theme";
    version = "latest";
    src = builtins.fetchGit {
      url = "https://github.com/sddm-theme/sugar-candy.git";
      ref = "main";
    };
    installPhase = ''
      mkdir -p $out/share/sddm/themes/sugar-candy
      cp -r * $out/share/sddm/themes/sugar-candy
    '';
  };
in
{
  options.sddm.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable SDDM with Sugar Candy theme";
  };

  config = lib.mkIf config.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      theme = "sugar-candy";
      extraPackages = with pkgs; [
        sddm
        qt5.qtgraphicaleffects
        qt5.qtsvg
        qt5.qtquickcontrols2
      ];
    };

    environment.systemPackages = [ sugar-candy-theme ];

    environment.etc."sddm.conf.d/10-theme.conf".text = ''
      [Theme]
      Current=sugar-candy
    '';
  };
}

