{ pkgs, ... }: {
  programs.git = {
    enable = true;

    settings = {
      user.name = "gibbyDev";
      user.email = "gibbyDEV@protonmail.com";
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  home.packages = [
    pkgs.gh
    pkgs.git-lfs
    pkgs.copilot-cli
    pkgs.noto-fonts
    pkgs.noto-fonts-color-emoji  # renamed
  ];
}

