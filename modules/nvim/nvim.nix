{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true; # Useful for JS/TS LSPs and other plugins
    withPython3 = true;

    extraPackages = with pkgs; [
      tree-sitter
      nodejs # Needed for some LSPs and plugins
      ripgrep # Needed for Telescope
      fd # Needed for Telescope
      unzip # Needed for Lazy.nvim to download plugins
    ];
    extraConfig = ''
      lua << EOF
      -- Bootstrap lazy.nvim plugin manager
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
          "git",
          "clone",
          "--filter=blob:none",
          "https://github.com/folke/lazy.nvim.git",
          "--branch=stable",
          lazypath,
        })
      end
      vim.opt.rtp:prepend(lazypath)

      require("lazy").setup({
        { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function()
          require("nvim-tree").setup({})
        end },
        { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = function()
          require("telescope").setup({})
        end },
        { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function()
          require("nvim-treesitter.configs").setup {
            ensure_installed = { "python", "css", "html", "c", "cpp", "go", "javascript", "typescript", "lua", "bash", "json", "yaml", "toml" },
            highlight = { enable = true },
            indent = { enable = true },
          }
        end },
        { "neovim/nvim-lspconfig", config = function()
          local lspconfig = require("lspconfig")
          lspconfig.pyright.setup {}
          lspconfig.cssls.setup {}
          lspconfig.html.setup {}
          lspconfig.clangd.setup {}
          lspconfig.gopls.setup {}
          lspconfig.tsserver.setup {}
        end },
        { "hrsh7th/nvim-cmp", dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-cmdline",
          "L3MON4D3/LuaSnip"
        }, config = function()
          local cmp = require("cmp")
          cmp.setup({
            snippet = {
              expand = function(args)
                require("luasnip").lsp_expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'buffer' },
              { name = 'path' },
            })
          })
        end },
      })

      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      -- Basic Keybindings
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
      vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
      vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
      vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
      vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>")

      -- Quality-of-Life Settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.clipboard = "unnamedplus"
      vim.opt.termguicolors = false
      EOF

      " Automatically load pywal colorscheme
      set termguicolors
      let g:colors_name = "colors-wal"
      source $HOME/.cache/wal/colors-wal.vim
    '';

   };
}

