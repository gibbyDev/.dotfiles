{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    dolphin
    ffmpegthumbs # Enables video thumbnails in Dolphin
  ] ++ (pkgs.lib.optionals (pkgs ? kio-extras) [ pkgs.kio-extras ]);

}

