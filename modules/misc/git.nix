{ pkgs, ... }: 
{
  programs.git = {
    enable = true;
    
    userName = "gibbyDev";
    userEmail = "gibbyDEV2protonmail.com";
    
    extraConfig = { 
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  home.packages = [ pkgs.gh pkgs.git-lfs ];
}
