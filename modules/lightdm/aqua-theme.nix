{ pkgs, lib, config, ... }:

let
  aqua-theme = pkgs.stdenv.mkDerivation {
    pname = "aqua-lightdm-webkit-theme";
    version = "1.0";

    src = pkgs.fetchzip {
      url = "https://github.com/paysonwallach/aqua-lightdm-webkit-theme/archive/master.zip";
      sha256 = "sha256-+nn2JN+l/SF6fNH/caT/JIptHilRdwLZ7FlFMD68VxA=";
      stripRoot = true;
    };

    installPhase = ''
      mkdir -p $out/share/lightdm-webkit/themes/aqua
      cp -r . $out/share/lightdm-webkit/themes/aqua/
    '';

    meta = with pkgs.lib; {
      description = "macOS-inspired LightDM Webkit greeter theme";
      homepage = "https://github.com/paysonwallach/aqua-lightdm-webkit-theme";
      platforms = platforms.linux;
    };
  };
in
{
  config = lib.mkIf config.services.xserver.displayManager.lightdm.enable {
    # Install the aqua theme (for future webkit greeter use)
    environment.systemPackages = [
      aqua-theme
    ];

    # Create symlink for theme to be accessible to lightdm
    system.activationScripts.aqua-lightdm-theme = {
      text = ''
        mkdir -p /usr/share/lightdm-webkit/themes
        if [ -L /usr/share/lightdm-webkit/themes/aqua ]; then
          rm /usr/share/lightdm-webkit/themes/aqua
        fi
        ln -sf ${aqua-theme}/share/lightdm-webkit/themes/aqua /usr/share/lightdm-webkit/themes/aqua
      '';
      deps = [];
    };
  };
}
