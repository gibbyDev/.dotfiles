# { pkgs, ... }:
#
# {
#   programs.yazi = {
#     enable = true;
#     settings = {
#       manager = {
#         show_hidden = true;
#         sort_by = "natural";
#       };
#       open = {
#         rules = [
#           { name = "^.*$"; use = "nvim"; }
#         ];
#       };
#     };
#   };
# }

{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;

    settings = {
      manager = {
        show_hidden = true;
        sort_by = "natural";
      };

      # Disable bottom status bar completely
      status = {
        enable = false;
      };
    # Disable bottom status bar (this is the real switch)
      ui = {
        status = {
          enable = false;
        };
      };
      # Neovim opener
      opener = {
        nvim = [
          {
            run = "nvim \"$@\"";
            block = true;
          }
        ];
      };

      # Make nvim override Yazi defaults
      open = {
        prepend_rules = [
          {
            name = ".*";
            use = "nvim";
          }
        ];
      };
    };
  };
}

