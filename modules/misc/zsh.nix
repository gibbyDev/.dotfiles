{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    initExtra = ''
      # Powerlevel10k
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';

    shellAliases = {
      # Defaults – hosts may override
      ll = lib.mkDefault "ls -lah";
      ".." = lib.mkDefault "cd ../";
       c = lib.mkDefault "clear";
      ff = lib.mkDefault "fastfetch";
      gs = lib.mkDefault "git status";
      hmr = lib.mkDefault "home-manager switch --flake .";
      reload = lib.mkDefault "exec zsh";
    };
  };

  ################################
  # Fonts (for p10k icons)
  ################################
  fonts.fontconfig.enable = true;

  ################################
  # Packages
  ################################
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono

    zsh-powerlevel10k
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];
}

