{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.zed-editor = {
    enable = true;

    # Auto-install extensions
    extensions = [
      "basedpyright"
      "basher"
      "biome"
      "blueprint"
      "catppuccin-icons"
      "charmed-icons"
      "colored-zed-icons-theme"
      "deno"
      "docker-compose"
      "dockerfile"
      "git-firefly"
      "github-theme"
      "graphql"
      "html"
      "ini"
      "jetbrains-new-ui-icons"
      "latex"
      "lua"
      "make"
      "material-icon-theme"
      "meson"
      "nix"
      "nordic-nvim-theme"
      "nordic-theme"
      "oxocarbon"
      "rose-pine-theme"
      "scss"
      "sql"
      "svelte"
      "toml"
      "vscode-icons"
      "xml"
      "zig"
    ];

    userSettings = {
      # Indent guides
      indent_guides = {
        coloring = "indent_aware";
        background_coloring = "indent_aware";
      };

      # Minimap
      minimap = {
        show = "always";
      };

      # Languages configuration
      languages = {
        TypeScript = {
          format_on_save = "on";
          formatter = {
            external = {
              command = "biome";
              arguments = [
                "format"
                "--write"
                "--stdin-file-path={buffer_path}"
              ];
            };
          };
          jsx_tag_auto_close = {
            enabled = false;
          };
          indent_guides = {
            coloring = "indent_aware";
            background_coloring = "indent_aware";
            enabled = true;
          };
          language_servers = [
            "typescript-language-server"
            "!vtsls"
            "..."
          ];
        };

        TSX = {
          formatter = {
            external = {
              command = "biome";
              arguments = [
                "format"
                "--write"
                "--stdin-file-path={buffer_path}"
              ];
            };
          };
          language_servers = [
            "typescript-language-server"
            "!vtsls"
            "..."
          ];
        };

        JavaScript = {
          formatter = {
            external = {
              command = "biome";
              arguments = [
                "format"
                "--write"
                "--stdin-file-path={buffer_path}"
              ];
            };
          };
          language_servers = [
            "typescript-language-server"
            "!vtsls"
            "..."
          ];
        };

        JSON = {
          formatter = {
            external = {
              command = "biome";
              arguments = [
                "format"
                "--write"
                "--stdin-file-path={buffer_path}"
              ];
            };
          };
          indent_guides = {
            background_coloring = "indent_aware";
            coloring = "indent_aware";
            enabled = true;
          };
        };

        JSONC = {
          formatter = {
            external = {
              command = "biome";
              arguments = [
                "format"
                "--write"
                "--stdin-file-path={buffer_path}"
              ];
            };
          };
          indent_guides = {
            background_coloring = "indent_aware";
            coloring = "indent_aware";
            enabled = true;
          };
        };

        XML = {
          formatter = "prettier";
          tab_size = 2;
        };

        Python = {
          language_servers = [
            "ruff"
            "ty"
            "!basedpyright"
          ];
        };
      };

      # Agent configuration
      agent = {
        play_sound_when_agent_done = true;
        always_allow_tool_actions = true;
        inline_assistant_model = {
          provider = "deepseek";
          model = "deepseek-chat";
        };
        default_model = {
          provider = "deepseek";
          model = "deepseek-reasoner";
        };
      };

      # Language models
      language_models = {
        deepseek = {
          api_url = "https://api.deepseek.com";
          available_models = [
            {
              name = "deepseek-chat";
              display_name = "DeepSeek Chat";
              max_tokens = 64000;
            }
            {
              name = "deepseek-reasoner";
              display_name = "DeepSeek Reasoner";
              max_tokens = 64000;
              max_output_tokens = 4096;
            }
          ];
        };
      };

      # Autosave and session
      autosave = "on_focus_change";
      session = {
        restore_unsaved_buffers = true;
      };

      # Features
      features = {
        edit_prediction_provider = "zed";
      };

      # UI settings
      ui_font_size = lib.mkForce 14;
      buffer_font_size = lib.mkForce 16;

      # Theme
      theme = lib.mkForce {
        mode = "system";
        light = "Github Dark";
        dark = "Vercel Dark";
      };

      # Panels
      outline_panel = {
        dock = "left";
        scrollbar = {
          show = "never";
        };
      };

      project_panel = {
        dock = "right";
        scrollbar = {
          show = "never";
        };
      };

      scrollbar = {
        show = "never";
      };

      # Icon theme
      icon_theme = "Soft Charmed Icons";

      # Helix mode
      helix_mode = true;

      # Git configuration
      git = {
        git_gutter = "tracked_files";
        inline_blame = {
          enabled = true;
          show_commit_summary = true;
        };
        hunk_style = null;
      };

      git_panel = {
        dock = "left";
      };

      # Terminal
      terminal = {
        dock = "bottom";
      };

      # Toolbar
      toolbar = {
        breadcrumbs = true;
        quick_actions = true;
        selections_menu = true;
      };

      # Gutter
      gutter = {
        folds = true;
        line_numbers = true;
      };

      # Edit predictions
      edit_predictions = {
        mode = "eager";
      };

      # Inlay hints
      inlay_hints = {
        enabled = false;
        show_type_hints = true;
        show_background = true;
        toggle_on_modifiers_press = {
          control = true;
        };
      };

      # Language server
      enable_language_server = true;

      # LSP configuration
      lsp = {
        tailwindcss-language-server = {
          settings = {
            experimental = {
              classRegex = [
                "\\.className\\s*[+]?=\\s*['\"]([^'\"]*)['\"]"
                "\\.setAttributeNS\\(.*,\\s*['\"]class['\"],\\s*['\"]([^'\"]*)['\"]"
                "\\.setAttribute\\(['\"]class['\"],\\s*['\"]([^'\"]*)['\"]"
                "\\.classList\\.add\\(['\"]([^'\"]*)['\"]"
                "\\.classList\\.remove\\(['\"]([^'\"]*)['\"]"
                "\\.classList\\.toggle\\(['\"]([^'\"]*)['\"]"
                "\\.classList\\.contains\\(['\"]([^'\"]*)['\"]"
                "\\.classList\\.replace\\(\\s*['\"]([^'\"]*)['\"]"
                "\\.classList\\.replace\\([^,)]+,\\s*['\"]([^'\"]*)['\"]"
              ];
            };
          };
        };

        rust-analyzer = {
          initialization_options = {
            cargo = {
              buildScripts = {
                enable = true;
              };
            };
            procMacro = {
              enable = true;
            };
            diagnostics = {
              experimental = {
                enable = true;
              };
            };
          };
        };
      };

      lsp_document_colors = "background";
    };
  };

  # Install required packages
  home.packages = with pkgs; [
    # Formatters
    biome
    prettier
    

    # Language servers
    typescript-language-server
    tailwindcss-language-server

    # Fonts
  ];

}
