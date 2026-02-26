{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ obsidian ];

  # NOTE: vault is at ~/Documents/Notebook
  # Commented out symlink due to pure eval restrictions
  # home.file.".config/obsidian" = {
  #   source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Notebook";
  # };

#  systemd.user.services.obsidian-git-sync = {
#    Unit = {
#      Description = "Auto-commit and push Obsidian Vault";
#      After = [ "network-online.target" ];
#    };

#    Service = {
#      ExecStart = pkgs.writeShellScript "obsidian-git-sync" ''
#        cd ${vaultPath}
#        if [ -n "$(git status --porcelain)" ]; then
#          git add .
#          git commit -m "Auto-sync: $(date)"
#          git push origin main
#        fi
#      '';
#      Restart = "always";
#    };

#    Install = { WantedBy = [ "default.target" ]; };
#  };
}

