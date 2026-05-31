{pkgs, ...}: {
  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      # LaTeX
      vimtex

      # LSP
      nvim-lspconfig

      # Autocompletion
      nvim-cmp
      cmp-nvim-lsp
      cmp_luasnip
      luasnip

      # Treesitter
      (nvim-treesitter.withPlugins (p: with p; [
        lua
        nix
        latex
        bibtex
        markdown
      ]))

      # Telescope
      telescope-nvim
      telescope-fzf-native-nvim
      plenary-nvim

      # File tree
      neo-tree-nvim
      nvim-web-devicons
      nui-nvim

      # Quality of life
      which-key-nvim
      gitsigns-nvim
      lualine-nvim
      nvim-autopairs
    ];

    extraPackages = with pkgs; [
      texlab
      texlive.combined.scheme-medium
      ripgrep
      fd
    ];

    extraLuaConfig = ''
      -- VimTeX
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_mappings_enabled = 1
      vim.g.vimtex_syntax_enabled = 1  -- let VimTeX handle LaTeX highlighting

      -- LSP
      local lspconfig = require('lspconfig')
      lspconfig.texlab.setup {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        settings = {
          texlab = {
            build = { onSave = true },
            forwardSearch = {
              executable = 'zathura',
              args = { '--synctex-forward', '%l:1:%f', '%p' },
            },
          },
        },
      }

      -- Treesitter
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
          disable = { 'latex' },  -- let VimTeX handle it
        },
        indent = { enable = true },
      }

      -- Telescope
      local telescope = require('telescope')
      telescope.setup {
        extensions = {
          fzf = {}
        }
      }
      telescope.load_extension('fzf')

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files)
      vim.keymap.set('n', '<leader>fg', builtin.live_grep)
      vim.keymap.set('n', '<leader>fb', builtin.buffers)
      vim.keymap.set('n', '<leader>fh', builtin.help_tags)
      vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols)

      -- Neo-tree
      require('neo-tree').setup {
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
          },
        },
      }
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>')

      -- Autocompletion
      local cmp = require('cmp')
      cmp.setup {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>']      = cmp.mapping.confirm { select = true },
          ['<Tab>']     = cmp.mapping.select_next_item(),
          ['<S-Tab>']   = cmp.mapping.select_prev_item(),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
      }

      -- Autopairs
      require('nvim-autopairs').setup {}

      -- Lualine
      require('lualine').setup {
        options = { theme = 'auto' },
        sections = {
          lualine_c = {
            { 'filename', path = 1 },
          },
        },
      }

      -- Gitsigns
      require('gitsigns').setup {}

      -- Which-key
      require('which-key').setup {}
    '';
  };
}
