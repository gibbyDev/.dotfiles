{ config, pkgs, lib, ...}:

{
  programs.firefox = {
    enable = true;

    # set default settings
    profiles.default = {
      isDefault = true;
      settings = {
        #"browser.startup.homepage" = "https://www.mozilla.org";
        "privacy.donottrackheader.enabled" = true;
        "network.trr.mode" = 2; # Use DNS over HTTPS
      };
      bookmarks = [
        {
          name = "YouTube";
          url = "https://www.youtube.com";
        }
        {
          name = "GitHub";
          url = "https://github.com";
        }
        {
          name = "lh:3000";
          url = "http://localhost:3000";
        }
        {
          name = "lh:8080";
          url = "http://localhost:8080";
        }
      ];
    };
  };
}


