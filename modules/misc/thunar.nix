{ config, pkgs, ... }:

{
  programs.thunar = {
    enable = true;
    
    # Enable thumbnails for supported file types
    enableThumbnailing = true;

    # Set Thunar as the default file manager
    defaultFileManager = true;

    # Enable the Thunar custom actions (e.g., opening a terminal in the current directory)
    customActions = [
      {
        name = "Open terminal here";
        command = "xfce4-terminal --working-directory=%f";
        description = "Open a terminal in the current directory";
        condition = "has_directory";
      }
    ];

    # Optional: Customize the icon theme for Thunar
    iconTheme = "Papirus-Dark"; # Adjust as needed based on your icon theme
  };
}

