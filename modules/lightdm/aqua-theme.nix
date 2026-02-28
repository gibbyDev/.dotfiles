{ pkgs, lib, config, ... }:

let
  aqua-theme = pkgs.stdenv.mkDerivation {
    pname = "aqua-lightdm-webkit-theme";
    version = "1.0";

    src = pkgs.fetchzip {
      url = "https://github.com/paysonwallach/aqua-lightdm-webkit-theme/archive/master.zip";
      sha256 = "sha256-042pphz30iarxkch4xsi54g6v2i4zyj73zyigix23zd5vwjgcygs";
      stripRoot = true;
    };

    installPhase = ''
      mkdir -p $out/share/lightdm-webkit/themes/aqua
      cp -r . $out/share/lightdm-webkit/themes/aqua/
    '';

    meta = with pkgs.lib; {
      description = "macOS-inspired LightDM Webkit greeter theme";
      homepage = "https://github.com/paysonwallach/aqua-lightdm-webkit-theme";
      license = licenses.hip;
      platforms = platforms.linux;
    };
  };
in
{
  options = {
    services.lightdm.aqua-theme.enable = lib.mkEnableOption "aqua LightDM webkit theme";
  };

  config = lib.mkIf config.services.lightdm.aqua-theme.enable {
    # Ensure theme files and webkit2 greeter are available
    environment.systemPackages = [ aqua-theme pkgs.lightdm_webkit2 ];

    # Create symlink for theme to be accessible to lightdm
    system.activationScripts.aqua-lightdm-theme = ''
      mkdir -p /usr/share/lightdm-webkit/themes
      if [ -L /usr/share/lightdm-webkit/themes/aqua ]; then
        rm /usr/share/lightdm-webkit/themes/aqua
      fi
      ln -sf ${aqua-theme}/share/lightdm-webkit/themes/aqua /usr/share/lightdm-webkit/themes/aqua
    '';

    # Create lightdm-webkit2-greeter config
    environment.etc."lightdm/lightdm-webkit2-greeter.conf" = {
      text = ''
        [General]
        webkit-theme = aqua
        debug-mode = false
      '';
    };

    # Update lightdm.conf to use webkit2 greeter
    environment.etc."lightdm/lightdm.conf" = lib.mkIf config.services.xserver.displayManager.lightdm.enable {
      text = lib.mkForce ''
        [General]
        greeter-session=lightdm-webkit2
        session-wrapper=/etc/lightdm/Xsession
        user-session=hyprland
      '';
    };
  };
}
