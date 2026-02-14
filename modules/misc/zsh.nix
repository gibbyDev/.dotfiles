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
      ls = lib.mkDefault "lsd --color=auto";
      ll = lib.mkDefault "lsd -lah --color=auto";
      ".." = lib.mkDefault "cd ../";
       v = lib.mkDefault "nvim .";
       c = lib.mkDefault "clear";
       z = lib.mkDefault "zoxide";
      op = lib.mkDefault "opencode .";
      ff = lib.mkDefault "fastfetch";
      gs = lib.mkDefault "git status";
      hmr = lib.mkDefault "home-manager switch --flake .";
      snr = lib.mkDefault "sudo nixos-rebuild switch --flake .";
      ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
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

