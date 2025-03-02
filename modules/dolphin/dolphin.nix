{ config, pkgs, ... }:

{
  programs.dolphin = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    dolphin
    kio-extras  # Adds additional protocol support (e.g., FTP, SFTP, SMB)
    ffmpegthumbs # Enables video thumbnails in Dolphin
  ];

  # Optional: If using Hyprland or other non-KDE environments
  services.dbus.enable = true;
}

