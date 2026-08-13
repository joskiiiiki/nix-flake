{
  pkgs,
  inputs,
  lib,
  ...
}:
let
  vercel-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "vercel-nvim";
    src = inputs.vercel-nvim;
  };
in
{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = false;
      vimAlias = true;

      lsp.enable = true;
      lsp.formatOnSave = true;

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        nix.enable = true;
        tex = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = true;
          format = {
            enable = true;
            type = [ "tex-fmt" ];
          };
        };
      };

      treesitter = {
        enable = true;
        grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          lua
          nix
          markdown
          # latex and bibtex handled by languages.tex.treesitter
        ];
      };

      telescope.enable = true;

      filetree.neo-tree = {
        enable = true;
        setupOpts.filesystem.filtered_items.hide_dotfiles = false;
      };

      autocomplete.nvim-cmp.enable = true;
      snippets.luasnip.enable = true;

      git = {
        enable = true;
        gitsigns.enable = true;
      };

      statusline.lualine = {
        enable = true;
        # theme = "auto";
      };

      binds.whichKey.enable = true;
      autopairs.nvim-autopairs.enable = true;

      extraPackages = with pkgs; [
        ripgrep
        fd
        zathura
        texlivePackages.latexmk
      ];

      extraPlugins = {
        vimtex = {
          package = pkgs.vimPlugins.vimtex;
          setup = ''
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_compiler_method = 'latexmk'
            vim.g.vimtex_mappings_enabled = 1
            vim.g.vimtex_syntax_enabled = 1
          '';
        };
        vercel = {
          package = vercel-nvim;
          setup = ''
            require("vercel").setup({
              theme = "dark",
              transparent = false,
              italics = {
                comments = true,
                keywords = true,
                functions = true,
                strings = true,
                variables = true,
              },
            })
            vim.cmd.colorscheme("vercel")
          '';
        };
      };

      theme.enable = lib.mkForce false;
    };
  };
}
