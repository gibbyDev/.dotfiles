{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      # Powerlevel10k Theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

      # zsh-autosuggestions
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh

      # zsh-syntax-highlighting
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

      # Optional Pywal + Kitty Reload Alias
      alias reloadkitty="kitty @ set-colors ~/.cache/wal/kitty/kitty.conf"
    '';

    shellAliases = {
      ll = "ls -la";
      reload = "exec zsh";
    };
  };

  # Fonts for Powerlevel10k icons and general nerd fonts
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono

    zsh-autosuggestions
    zsh-syntax-highlighting
  ];
}

